/* Procedure publish_video_and_notify: Inserts a new video and notifies all subscribers of the channel using an explicit cursor. */
IF OBJECT_ID(N's32782.publish_video_and_notify', N'P') IS NOT NULL
    DROP PROCEDURE s32782.publish_video_and_notify;
GO
CREATE PROCEDURE s32782.publish_video_and_notify
  @Title            NVARCHAR(230),
  @FileType         NVARCHAR(25),
  @Channel_ID       INT,
  @AgeRestriction   INT = NULL,
  @Advertisement_ID INT = NULL,
  @NewVideoID       INT OUTPUT
AS
BEGIN

  BEGIN TRY
    BEGIN TRAN;

    IF @AgeRestriction IS NOT NULL AND @AgeRestriction < 0
      THROW 50010, 'AgeRestriction must be >= 0', 1;

    DECLARE @ChannelName NVARCHAR(240);
    SELECT @ChannelName = Name
    FROM s32782.Channel
    WHERE ID = @Channel_ID;

    IF @ChannelName IS NULL
      THROW 50012, 'Channel_ID does not exist', 1;

    IF @Advertisement_ID IS NOT NULL
    BEGIN
      IF NOT EXISTS (SELECT 1 FROM s32782.Advertisement WHERE ID = @Advertisement_ID)
        THROW 50011, 'Advertisement_ID does not exist', 1;
    END

    SELECT @NewVideoID = ISNULL(MAX(ID), 0) + 1
    FROM s32782.Video WITH (UPDLOCK, HOLDLOCK);

    INSERT INTO s32782.Video (ID, Title, FileType, Channel_ID, AgeRestriction, Advertisement_ID)
    VALUES (@NewVideoID, @Title, @FileType, @Channel_ID, @AgeRestriction, @Advertisement_ID);

    DECLARE @NextNotifID INT;
    SELECT @NextNotifID = ISNULL(MAX(ID), 0)
    FROM s32782.Notification WITH (UPDLOCK, HOLDLOCK);

    DECLARE @SubUserID INT;

    DECLARE c_subscribers CURSOR LOCAL FOR
      SELECT User_ID
      FROM s32782.Subscriber
      WHERE Channel_ID = @Channel_ID;

    OPEN c_subscribers;
    FETCH NEXT FROM c_subscribers INTO @SubUserID;

    WHILE @@FETCH_STATUS = 0
    BEGIN
      SET @NextNotifID = @NextNotifID + 1;

      INSERT INTO s32782.Notification (ID, User_ID, Message, CreateTime)
      VALUES
      (
        @NextNotifID,
        @SubUserID,
        N'New video uploaded on channel "' + @ChannelName + N'": ' + @Title,
        CAST(GETDATE() AS date)
      );

      FETCH NEXT FROM c_subscribers INTO @SubUserID;
    END

    CLOSE c_subscribers;
    DEALLOCATE c_subscribers;

    COMMIT;
  END TRY
  BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK;
    THROW;
  END CATCH
END;
GO


/* Procedure subscribe_user: Creates a subscription with validation and notifies the channel owner about the new subscriber. */
IF OBJECT_ID(N's32782.subscribe_user', N'P') IS NOT NULL
    DROP PROCEDURE s32782.subscribe_user;
GO
CREATE PROCEDURE s32782.subscribe_user
  @User_ID    INT,
  @Channel_ID INT
AS
BEGIN

  BEGIN TRY
    BEGIN TRAN;

    IF NOT EXISTS (SELECT 1 FROM s32782.Users WHERE ID = @User_ID)
      THROW 50022, 'User does not exist', 1;

    DECLARE @OwnerUserID INT, @ChannelName NVARCHAR(240);

    SELECT @OwnerUserID = User_ID, @ChannelName = Name
    FROM s32782.Channel
    WHERE ID = @Channel_ID;

    IF @OwnerUserID IS NULL
      THROW 50023, 'Channel_ID does not exist', 1;

    IF @OwnerUserID = @User_ID
      THROW 50020, 'User cannot subscribe to own channel', 1;

    IF EXISTS (
      SELECT 1
      FROM s32782.Subscriber
      WHERE Channel_ID = @Channel_ID AND User_ID = @User_ID
    )
      THROW 50021, 'This user has already subscribed for this channel', 1;

    INSERT INTO s32782.Subscriber (Channel_ID, User_ID, CreationT)
    VALUES (@Channel_ID, @User_ID, SYSDATETIME());

    DECLARE @UserFullName NVARCHAR(500);
    SELECT @UserFullName = FirstName + N' ' + LastName
    FROM s32782.Users
    WHERE ID = @User_ID;

    DECLARE @NextNotifID INT;
    SELECT @NextNotifID = ISNULL(MAX(ID), 0) + 1
    FROM s32782.Notification WITH (UPDLOCK, HOLDLOCK);

    INSERT INTO s32782.Notification (ID, User_ID, Message, CreateTime)
    VALUES
    (
      @NextNotifID,
      @OwnerUserID,
      N'New subscriber: ' + @UserFullName + N' subscribed to "' + @ChannelName + N'".',
      CAST(GETDATE() AS date)
    );

    COMMIT;
  END TRY
  BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK;
    THROW;
  END CATCH
END;
GO


/* Trigger tr_video_create_stats: After inserting a video, automatically creates the related VideoStats row with zero counters. */
IF OBJECT_ID(N's32782.tr_video_create_stats', N'TR') IS NOT NULL
    DROP TRIGGER s32782.tr_video_create_stats;
GO
CREATE TRIGGER s32782.tr_video_create_stats
ON s32782.Video
AFTER INSERT
AS
BEGIN
  INSERT INTO s32782.VideoStats (Video_ID, ViewCount, LikeCount, DislikeCount)
  SELECT i.ID, 0, 0, 0
  FROM inserted i;
END;
GO


/* Trigger tr_ad_validate_dates: Validates advertisement dates and basic format rules on every insert or update. */
IF OBJECT_ID(N's32782.tr_ad_validate_dates', N'TR') IS NOT NULL
    DROP TRIGGER s32782.tr_ad_validate_dates;
GO
CREATE TRIGGER s32782.tr_ad_validate_dates
ON s32782.Advertisement
AFTER INSERT, UPDATE
AS
BEGIN
  IF EXISTS (SELECT 1 FROM inserted WHERE EndDate < StartDate)
  BEGIN
    ROLLBACK;
    THROW 50030, 'EndDate must be greater than or equal to StartDate', 1;
  END;

  IF EXISTS (SELECT 1 FROM inserted WHERE AdType NOT IN (N'pre-roll', N'overlay', N'banner'))
  BEGIN
    ROLLBACK;
    THROW 50031, 'AdType must be pre-roll, overlay, or banner', 1;
  END;

  IF EXISTS (SELECT 1 FROM inserted WHERE TargetUrl NOT LIKE N'http://%' AND TargetUrl NOT LIKE N'https://%')
  BEGIN
    ROLLBACK;
    THROW 50032, 'TargetUrl must start with http:// or https://', 1;
  END;
END;
GO
