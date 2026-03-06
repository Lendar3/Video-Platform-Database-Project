
/* Procedure publish_video_and_notify: Inserts a new video and notifies all subscribers of the channel using an explicit cursor. */
CREATE OR REPLACE PROCEDURE publish_video_and_notify(
  p_title            IN  Video.Title%TYPE,
  p_filetype         IN  Video.FileType%TYPE,
  p_channel_id       IN  Video.Channel_ID%TYPE,
  p_age_restriction  IN  Video.AgeRestriction%TYPE DEFAULT NULL,
  p_advertisement_id IN  Video.Advertisement_ID%TYPE DEFAULT NULL,
  p_new_video_id     OUT Video.ID%TYPE
) IS
  v_channel_name   Channel.Name%TYPE;
  v_next_video_id  Video.ID%TYPE;
  v_next_notif_id  Notification.ID%TYPE;

  CURSOR c_subscribers IS
    SELECT User_ID
    FROM Subscriber
    WHERE Channel_ID = p_channel_id;
BEGIN
  SELECT Name INTO v_channel_name
  FROM Channel
  WHERE ID = p_channel_id;

  IF p_age_restriction IS NOT NULL AND p_age_restriction < 0 THEN
    raise_application_error(-20010, 'AgeRestriction must be >= 0');
  END IF;

  IF p_filetype NOT IN ('mp4','mov','avi','mkv','mp3') THEN
    raise_application_error(-20013, 'Unsupported FileType');
  END IF;

  IF p_advertisement_id IS NOT NULL THEN
    DECLARE v_dummy NUMBER;
    BEGIN
      SELECT 1 INTO v_dummy FROM Advertisement WHERE ID = p_advertisement_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(-20011, 'Advertisement_ID does not exist');
    END;
  END IF;

  SELECT NVL(MAX(ID), 0) + 1 INTO v_next_video_id FROM Video;

  INSERT INTO Video (ID, Title, FileType, Channel_ID, AgeRestriction, Advertisement_ID)
  VALUES (v_next_video_id, p_title, p_filetype, p_channel_id, p_age_restriction, p_advertisement_id);

  p_new_video_id := v_next_video_id;

  SELECT NVL(MAX(ID), 0) INTO v_next_notif_id FROM Notification;

  FOR r IN c_subscribers LOOP
    v_next_notif_id := v_next_notif_id + 1;

    INSERT INTO Notification (ID, User_ID, Message, CreateTime)
    VALUES (
      v_next_notif_id,
      r.User_ID,
      'New video uploaded on channel "' || v_channel_name || '": ' || p_title,
      SYSDATE
    );
  END LOOP;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    raise_application_error(-20012, 'Channel_ID does not exist');
END;




/* Procedure subscribe_user: Creates a subscription with validation and notifies the channel owner about the new subscriber. */
CREATE OR REPLACE PROCEDURE subscribe_user(
  p_user_id    IN Subscriber.User_ID%TYPE,
  p_channel_id IN Subscriber.Channel_ID%TYPE
) IS
  v_channel_owner_id Channel.User_ID%TYPE;
  v_channel_name     Channel.Name%TYPE;
  v_cnt              NUMBER;
  v_next_notif_id    Notification.ID%TYPE;
  v_user_full_name   NVARCHAR2(500);
BEGIN
  SELECT COUNT(*) INTO v_cnt FROM "User" WHERE ID = p_user_id;
  IF v_cnt = 0 THEN
    raise_application_error(-20022, 'User_ID does not exist');
  END IF;

  SELECT User_ID, Name INTO v_channel_owner_id, v_channel_name
  FROM Channel
  WHERE ID = p_channel_id;

  IF v_channel_owner_id = p_user_id THEN
    raise_application_error(-20020, 'User cannot subscribe to own channel');
  END IF;

  SELECT COUNT(*) INTO v_cnt
  FROM Subscriber
  WHERE Channel_ID = p_channel_id AND User_ID = p_user_id;

  IF v_cnt > 0 THEN
    raise_application_error(-20021, 'Subscription already exists');
  END IF;

  INSERT INTO Subscriber (Channel_ID, User_ID, CreationT)
  VALUES (p_channel_id, p_user_id, SYSTIMESTAMP);

  SELECT FirstName || ' ' || LastName INTO v_user_full_name
  FROM "User"
  WHERE ID = p_user_id;

  SELECT NVL(MAX(ID), 0) + 1 INTO v_next_notif_id FROM Notification;

  INSERT INTO Notification (ID, User_ID, Message, CreateTime)
  VALUES (
    v_next_notif_id,
    v_channel_owner_id,
    'New subscriber: ' || v_user_full_name || ' subscribed to "' || v_channel_name || '".',
    SYSDATE
  );

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    raise_application_error(-20023, 'Channel_ID does not exist');
END;




/* Trigger tr_video_create_stats: After inserting a video, automatically creates the related VideoStats row with zero counters. */
CREATE OR REPLACE TRIGGER tr_video_create_stats
AFTER INSERT ON Video
FOR EACH ROW
BEGIN
  INSERT INTO VideoStats (Video_ID, ViewCount, LikeCount, DislikeCount)
  VALUES (:NEW.ID, 0, 0, 0);
END;



/* Trigger tr_ad_validate_dates: Validates advertisement dates and format rules on every insert or update. */
CREATE OR REPLACE TRIGGER tr_ad_validate_dates
BEFORE INSERT OR UPDATE ON Advertisement
FOR EACH ROW
BEGIN
  IF :NEW.EndDate < :NEW.StartDate THEN
    raise_application_error(-20030, 'EndDate must be greater than or equal to StartDate');
  END IF;

  IF :NEW.AdType NOT IN ('pre-roll','overlay','banner') THEN
    raise_application_error(-20031, 'AdType must be pre-roll, overlay, or banner');
  END IF;

  IF NOT REGEXP_LIKE(:NEW.TargetUrl, '^https?://') THEN
    raise_application_error(-20032, 'TargetUrl must start with http:// or https://');
  END IF;
END;