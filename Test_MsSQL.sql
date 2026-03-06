
-- TEST 1: publish_video_and_notify
-- procedure works + trigger tr_video_create_stats works

DECLARE @AnyChannel INT, @NewVideoID INT;

SELECT TOP (1) @AnyChannel = Channel_ID
FROM s32782.Subscriber
ORDER BY CreationT;

EXEC s32782.publish_video_and_notify
  @Title = N'Test video',
  @FileType = N'mp4',
  @Channel_ID = @AnyChannel,
  @AgeRestriction = NULL,
  @Advertisement_ID = NULL,
  @NewVideoID = @NewVideoID OUTPUT;

SELECT @NewVideoID AS NewVideoID;

-- trigger check
SELECT *
FROM VideoStats
WHERE Video_ID = @NewVideoID;

-- show notifications
SELECT TOP (20) *
FROM s32782.Notification
ORDER BY ID DESC;

-- TEST 2: subscribe_user
-- procedure works + inserts Subscriber row + notify channel owner
DECLARE @UserID INT, @ChannelID INT;

SELECT TOP (1)
  @UserID = u.ID,
  @ChannelID = c.ID
FROM s32782.Users u
JOIN s32782.Channel c ON c.User_ID <> u.ID
WHERE NOT EXISTS (
  SELECT 1
  FROM s32782.Subscriber s
  WHERE s.Channel_ID = c.ID AND s.User_ID = u.ID
);

EXEC s32782.subscribe_user @User_ID = @UserID, @Channel_ID = @ChannelID;

SELECT TOP (20) *
FROM s32782.Subscriber
ORDER BY CreationT DESC;

SELECT TOP (20) *
FROM s32782.Notification
ORDER BY ID DESC;


-- TEST 3: trigger tr_video_create_stats (direct insert)
DECLARE @DirectVideoID INT = (SELECT ISNULL(MAX(ID),0) + 1 FROM s32782.Video), @AnyChannel INT = 4;

INSERT INTO s32782.Video (ID, Title, FileType, Channel_ID, AgeRestriction, Advertisement_ID)
VALUES (@DirectVideoID, N'Direct insert video (trigger check)', N'mp4', @AnyChannel, NULL, NULL);

SELECT *
FROM s32782.VideoStats
WHERE Video_ID = @DirectVideoID;


-- TEST 4: trigger tr_ad_validate_dates (should FAIL) - bad dates

BEGIN TRY
  INSERT INTO s32782.Advertisement (ID, Title, AdType, TargetUrl, StartDate, EndDate)
  VALUES (
    (SELECT ISNULL(MAX(ID),0) + 1 FROM s32782.Advertisement),
    N'Bad Ad (type)',
    N'popup',
    N'https://ok.example',
    '2025-06-11',
    '2025-06-10'
  );
END TRY
BEGIN CATCH
  SELECT ERROR_NUMBER() AS ErrNo, ERROR_MESSAGE() AS ErrMsg;
END CATCH;


-- TEST 5: trigger tr_ad_validate_dates (should FAIL) - bad type
BEGIN TRY
  INSERT INTO s32782.Advertisement (ID, Title, AdType, TargetUrl, StartDate, EndDate)
  VALUES (
    (SELECT ISNULL(MAX(ID),0) + 1 FROM s32782.Advertisement),
    N'Bad Ad (type)',
    N'popup',
    N'https://ok.example',
    '2025-06-11',
    '2025-06-13'
  );
END TRY
BEGIN CATCH
  SELECT ERROR_NUMBER() AS ErrNo, ERROR_MESSAGE() AS ErrMsg;
END CATCH;

------------------------------------------------------------
-- TEST 6: trigger tr_ad_validate_dates (should FAIL) - bad url
BEGIN TRY
  INSERT INTO s32782.Advertisement (ID, Title, AdType, TargetUrl, StartDate, EndDate)
  VALUES (
    (SELECT ISNULL(MAX(ID),0) + 1 FROM s32782.Advertisement),
    N'Bad Ad (url)',
    N'banner',
    N'ffffff',
    '2025-06-01',
    '2025-06-10'
  );
END TRY
BEGIN CATCH
  SELECT ERROR_NUMBER() AS ErrNo, ERROR_MESSAGE() AS ErrMsg;
END CATCH;
