-- TEST 1: publish_video_and_notify
--procedure works + trigger tr_video_create_stats works
DECLARE
  v_new_video_id   Video.ID%TYPE;
  v_channel_id     Video.Channel_ID%TYPE;
BEGIN
  SELECT Channel_ID
  INTO v_channel_id
  FROM (
    SELECT CHANNEL_ID
    FROM Subscriber
    GROUP BY Channel_ID
    ORDER BY COUNT(*) DESC
  )
  WHERE ROWNUM = 1;

  publish_video_and_notify(
    p_title => 'Test video (publish_video_and_notify)',
    p_filetype => 'mp4',
    p_channel_id => v_channel_id,
    p_age_restriction => NULL,
    p_advertisement_id => NULL,
    p_new_video_id => v_new_video_id
  );

  DBMS_OUTPUT.PUT_LINE('NewVideoID = ' || v_new_video_id);
  DBMS_OUTPUT.PUT_LINE('ChannelID  = ' || v_channel_id);


  -- trigger cheack
  FOR s IN (SELECT Video_ID, ViewCount, LikeCount, DislikeCount
            FROM VideoStats
            WHERE Video_ID = v_new_video_id)
  LOOP
    DBMS_OUTPUT.PUT_LINE('VideoStats created: video='||s.Video_ID||
                         ', views='||s.ViewCount||', likes='||s.LikeCount||', dislikes='||s.DislikeCount);
  END LOOP;

  -- show last notifications
  DBMS_OUTPUT.PUT_LINE('Last 10 notifications:');
  FOR n IN (
    SELECT * FROM (
      SELECT ID, User_ID, Message, CreateTime
      FROM Notification
      ORDER BY ID DESC
    )
    WHERE ROWNUM <= 10
  )
  LOOP
    DBMS_OUTPUT.PUT_LINE(n.ID||' user= '||n.User_ID||' msg= '||SUBSTR(n.Message,1,120));
  END LOOP;
END;

-- TEST 2: subscribe_user
-- procedure works + inserts Subscriber row + notify channel owner
DECLARE
  v_user_id    Subscriber.User_ID%TYPE;
  v_channel_id Subscriber.Channel_ID%TYPE;
BEGIN
  SELECT u.ID, c.ID
  INTO v_user_id, v_channel_id
  FROM "User" u
  CROSS JOIN Channel c
  WHERE c.User_ID <> u.ID
    AND NOT EXISTS (
      SELECT 1
      FROM Subscriber s
      WHERE s.Channel_ID = c.ID AND s.User_ID = u.ID
    )
    AND ROWNUM = 1;

  subscribe_user(p_user_id => v_user_id, p_channel_id => v_channel_id);

  DBMS_OUTPUT.PUT_LINE('Subscribed: user='||v_user_id||' to channel='||v_channel_id);

  FOR s IN (
    SELECT Channel_ID, User_ID, CreationT
    FROM Subscriber
    WHERE Channel_ID = v_channel_id AND User_ID = v_user_id
  )

  LOOP
    DBMS_OUTPUT.PUT_LINE('Subscriber row OK, CreationT='||TO_CHAR(s.CreationT,'YYYY-MM-DD HH24:MI:SS'));
  END LOOP;


  DBMS_OUTPUT.PUT_LINE('Last notifications (top 5):');
  FOR n IN (
    SELECT * FROM (
      SELECT ID, User_ID, Message, CreateTime
      FROM Notification
      ORDER BY ID DESC
    )
    WHERE ROWNUM <= 5
  )
  LOOP
    DBMS_OUTPUT.PUT_LINE(n.ID||' user='||n.User_ID||' msg='||SUBSTR(n.Message,1,140));
  END LOOP;
END;

-- TEST 3: trigger tr_ad_validate_dates (should FAIL) (bad dates)

DECLARE
  v_new_id NUMBER;
BEGIN
  SELECT NVL(MAX(ID),0) + 1
  INTO v_new_id
  FROM Advertisement;

  BEGIN
    INSERT INTO Advertisement (ID, Title, AdType, TargetUrl, StartDate, EndDate)
    VALUES (v_new_id, 'Bad Ad (dates)', 'banner', 'https://ok.example',
            TO_DATE('2025-06-10','YYYY-MM-DD'),
            TO_DATE('2025-06-01','YYYY-MM-DD'));
    END;
END;


-- TEST 4: trigger tr_ad_validate_dates (should FAIL) - bad AdType
DECLARE
  v_new_id NUMBER;
BEGIN
  SELECT NVL(MAX(ID),0) + 1 INTO v_new_id FROM Advertisement;


  BEGIN
    INSERT INTO Advertisement (ID, Title, AdType, TargetUrl, StartDate, EndDate)
    VALUES (v_new_id, 'Bad Ad (type)', 'something', 'https://ok.example',
            TO_DATE('2025-06-01','YYYY-MM-DD'),
            TO_DATE('2025-06-10','YYYY-MM-DD'));

  END;
END;


-- TEST 5: trigger tr_ad_validate_dates (should FAIL) - bad URL
DECLARE
  v_new_id NUMBER;
BEGIN
  SELECT NVL(MAX(ID),0) + 1 INTO v_new_id FROM Advertisement;


  BEGIN
    INSERT INTO Advertisement (ID, Title, AdType, TargetUrl, StartDate, EndDate)
    VALUES (v_new_id, 'Bad Ad (url)', 'banner', 'example.invalid',
            TO_DATE('2025-06-01','YYYY-MM-DD'),
            TO_DATE('2025-06-10','YYYY-MM-DD'));
  END;
END;
