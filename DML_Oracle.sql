-- Advertisement (5)
INSERT INTO Advertisement VALUES (1, 'Summer Sale', 'pre-roll', 'https://ads.example/summer', TO_DATE('2025-06-01','YYYY-MM-DD'), TO_DATE('2025-06-30','YYYY-MM-DD'));
INSERT INTO Advertisement VALUES (2, 'New Phone', 'overlay', 'https://ads.example/phone', TO_DATE('2025-05-10','YYYY-MM-DD'), TO_DATE('2025-07-10','YYYY-MM-DD'));
INSERT INTO Advertisement VALUES (3, 'Gaming Laptop', 'banner', 'https://ads.example/laptop', TO_DATE('2025-04-01','YYYY-MM-DD'), TO_DATE('2025-08-01','YYYY-MM-DD'));
INSERT INTO Advertisement VALUES (4, 'Coffee Brand', 'pre-roll', 'https://ads.example/coffee', TO_DATE('2025-01-01','YYYY-MM-DD'), TO_DATE('2025-12-31','YYYY-MM-DD'));
INSERT INTO Advertisement VALUES (5, 'Streaming Service', 'banner', 'https://ads.example/stream', TO_DATE('2025-02-15','YYYY-MM-DD'), TO_DATE('2025-09-15','YYYY-MM-DD'));

-- Userauth (10)
INSERT INTO Userauth VALUES (1,  'irina',  'hash_pw_1');
INSERT INTO Userauth VALUES (2,  'olek',   'hash_pw_2');
INSERT INTO Userauth VALUES (3,  'anna',   'hash_pw_3');
INSERT INTO Userauth VALUES (4,  'max',    'hash_pw_4');
INSERT INTO Userauth VALUES (5,  'kate',   'hash_pw_5');
INSERT INTO Userauth VALUES (6,  'den',    'hash_pw_6');
INSERT INTO Userauth VALUES (7,  'maria',  'hash_pw_7');
INSERT INTO Userauth VALUES (8,  'serg',   'hash_pw_8');
INSERT INTO Userauth VALUES (9,  'vlad',   'hash_pw_9');
INSERT INTO Userauth VALUES (10, 'nina',   'hash_pw_10');

-- "User" (10)
INSERT INTO "User" VALUES (1, 'Irina',  'Nekrashevych', TO_DATE('1996-02-10','YYYY-MM-DD'), 'F', 'irina@mail.com',  '48100100100', TO_DATE('2024-01-05','YYYY-MM-DD'), 1);
INSERT INTO "User" VALUES (2, 'Olek',   'Mykytchenko',  TO_DATE('2002-11-02','YYYY-MM-DD'), 'M', 'olek@mail.com',   NULL,          TO_DATE('2024-02-10','YYYY-MM-DD'), 2);
INSERT INTO "User" VALUES (3, 'Anna',   'Koval',        TO_DATE('1999-07-21','YYYY-MM-DD'), 'F', 'anna@mail.com',   '48100200300', TO_DATE('2024-03-11','YYYY-MM-DD'), 3);
INSERT INTO "User" VALUES (4, 'Max',    'Brown',        TO_DATE('1997-05-12','YYYY-MM-DD'), 'M', 'max@mail.com',    NULL,          TO_DATE('2024-03-20','YYYY-MM-DD'), 4);
INSERT INTO "User" VALUES (5, 'Kate',   'Nowak',        TO_DATE('2000-09-30','YYYY-MM-DD'), 'F', 'kate@mail.com',   '48100500500', TO_DATE('2024-04-05','YYYY-MM-DD'), 5);
INSERT INTO "User" VALUES (6, 'Denys',  'Shevchenko',   TO_DATE('1998-12-01','YYYY-MM-DD'), 'M', 'den@mail.com',    '48100600600', TO_DATE('2024-04-18','YYYY-MM-DD'), 6);
INSERT INTO "User" VALUES (7, 'Maria',  'Ivanova',      TO_DATE('2001-01-14','YYYY-MM-DD'), 'F', 'maria@mail.com',  NULL,          TO_DATE('2024-05-02','YYYY-MM-DD'), 7);
INSERT INTO "User" VALUES (8, 'Sergii', 'Petrenko',     TO_DATE('1995-10-10','YYYY-MM-DD'), 'M', 'serg@mail.com',   '48100800800', TO_DATE('2024-05-10','YYYY-MM-DD'), 8);
INSERT INTO "User" VALUES (9, 'Vlad',   'Nekrashevych', TO_DATE('2016-06-06','YYYY-MM-DD'), 'M', 'vlad@mail.com',   NULL,          TO_DATE('2024-06-01','YYYY-MM-DD'), 9);
INSERT INTO "User" VALUES (10,'Nina',   'Lee',          TO_DATE('1994-08-08','YYYY-MM-DD'), 'O', 'nina@mail.com',   '48101001000', TO_DATE('2024-06-10','YYYY-MM-DD'), 10);

-- Channel (5)
INSERT INTO Channel VALUES (1, 'Tech Lab',     1, TO_TIMESTAMP('2024-02-01 10:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Channel VALUES (2, 'Cooking Easy', 2, TO_TIMESTAMP('2024-02-10 12:30:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Channel VALUES (3, 'Music Room',   3, TO_TIMESTAMP('2024-03-01 09:15:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Channel VALUES (4, 'Fitness Pro',  4, TO_TIMESTAMP('2024-03-10 18:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Channel VALUES (5, 'Travel Daily', 5, TO_TIMESTAMP('2024-04-01 08:45:00','YYYY-MM-DD HH24:MI:SS'));

-- Video (10)
INSERT INTO Video VALUES (1, 'Java Threads Basics', 'mp4', 1, NULL, 1);
INSERT INTO Video VALUES (2, 'Oracle PL/SQL Cursor', 'mp4', 1, 16, NULL);
INSERT INTO Video VALUES (3, 'Pasta in 10 minutes', 'mp4', 2, NULL, 2);
INSERT INTO Video VALUES (4, 'Perfect pancakes', 'mp4', 2, NULL, NULL);
INSERT INTO Video VALUES (5, 'Lo-fi beats', 'mp3', 3, NULL, 5);
INSERT INTO Video VALUES (6, 'Guitar tutorial 1', 'mp4', 3, NULL, NULL);
INSERT INTO Video VALUES (7, 'Home workout 20min', 'mp4', 4, 12, 3);
INSERT INTO Video VALUES (8, 'Stretching routine', 'mp4', 4, NULL, NULL);
INSERT INTO Video VALUES (9, 'Warsaw weekend vlog', 'mp4', 5, NULL, 4);
INSERT INTO Video VALUES (10,'Kyiv city walk', 'mp4', 5, NULL, NULL);

-- VideoStats (10) 
INSERT INTO VideoStats VALUES (1,  1200, 130,  5);
INSERT INTO VideoStats VALUES (2,  900,  95,  3);
INSERT INTO VideoStats VALUES (3,  4000, 520, 10);
INSERT INTO VideoStats VALUES (4,  3100, 430,  7);
INSERT INTO VideoStats VALUES (5,  8000, 900, 20);
INSERT INTO VideoStats VALUES (6,  2500, 300,  8);
INSERT INTO VideoStats VALUES (7,  1500, 160,  4);
INSERT INTO VideoStats VALUES (8,  1800, 210,  6);
INSERT INTO VideoStats VALUES (9,  2200, 260,  9);
INSERT INTO VideoStats VALUES (10, 5000, 610, 12);

-- Tag (10)
INSERT INTO Tag VALUES (1,  'java');
INSERT INTO Tag VALUES (2,  'oracle');
INSERT INTO Tag VALUES (3,  'cooking');
INSERT INTO Tag VALUES (4,  'music');
INSERT INTO Tag VALUES (5,  'fitness');
INSERT INTO Tag VALUES (6,  'travel');
INSERT INTO Tag VALUES (7,  'tutorial');
INSERT INTO Tag VALUES (8,  'vlog');
INSERT INTO Tag VALUES (9,  'database');
INSERT INTO Tag VALUES (10, 'playlist');

-- VideoTag 
INSERT INTO VideoTag VALUES (1, 1);
INSERT INTO VideoTag VALUES (1, 7);
INSERT INTO VideoTag VALUES (2, 2);
INSERT INTO VideoTag VALUES (2, 9);
INSERT INTO VideoTag VALUES (3, 3);
INSERT INTO VideoTag VALUES (3, 7);
INSERT INTO VideoTag VALUES (5, 4);
INSERT INTO VideoTag VALUES (6, 4);
INSERT INTO VideoTag VALUES (7, 5);
INSERT INTO VideoTag VALUES (8, 5);
INSERT INTO VideoTag VALUES (9, 6);
INSERT INTO VideoTag VALUES (10, 6);

-- Subscriber (10)
INSERT INTO Subscriber VALUES (1, 2, TO_TIMESTAMP('2024-04-01 10:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Subscriber VALUES (1, 3, TO_TIMESTAMP('2024-04-02 11:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Subscriber VALUES (1, 4, TO_TIMESTAMP('2024-04-03 12:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Subscriber VALUES (2, 1, TO_TIMESTAMP('2024-04-04 13:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Subscriber VALUES (2, 5, TO_TIMESTAMP('2024-04-05 14:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Subscriber VALUES (3, 1, TO_TIMESTAMP('2024-04-06 15:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Subscriber VALUES (3, 6, TO_TIMESTAMP('2024-04-07 16:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Subscriber VALUES (4, 7, TO_TIMESTAMP('2024-04-08 17:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Subscriber VALUES (5, 8, TO_TIMESTAMP('2024-04-09 18:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Subscriber VALUES (5, 9, TO_TIMESTAMP('2024-04-10 19:00:00','YYYY-MM-DD HH24:MI:SS'));

-- Playlist (5)
INSERT INTO Playlist VALUES (1, 'Study DB',     'SQL & PL/SQL videos', 1, TO_DATE('2025-06-01','YYYY-MM-DD'), 2);
INSERT INTO Playlist VALUES (2, 'Quick Dinner', 'fast cooking',        2, TO_DATE('2025-06-01','YYYY-MM-DD'), 3);
INSERT INTO Playlist VALUES (3, 'Workout',      'home fitness',        4, TO_DATE('2025-06-02','YYYY-MM-DD'), 7);
INSERT INTO Playlist VALUES (4, 'Travel Plans', 'vlogs to watch',      5, TO_DATE('2025-06-02','YYYY-MM-DD'), 9);
INSERT INTO Playlist VALUES (5, 'Music Chill',  NULL,                 3, TO_DATE('2025-06-03','YYYY-MM-DD'), 5);

-- WatchLaterVideo (5)
INSERT INTO WatchLaterVideo VALUES (1, 1, 3, TO_DATE('2025-06-05','YYYY-MM-DD'));
INSERT INTO WatchLaterVideo VALUES (2, 1, 7, TO_DATE('2025-06-05','YYYY-MM-DD'));
INSERT INTO WatchLaterVideo VALUES (3, 2, 2, TO_DATE('2025-06-06','YYYY-MM-DD'));
INSERT INTO WatchLaterVideo VALUES (4, 6, 9, TO_DATE('2025-06-06','YYYY-MM-DD'));
INSERT INTO WatchLaterVideo VALUES (5, 8, 10, TO_DATE('2025-06-07','YYYY-MM-DD'));

-- Comments (10) (ParentComment)
INSERT INTO Comments VALUES (1, 2, 'Nice explanation!',           TO_DATE('2025-06-01','YYYY-MM-DD'), NULL, 1);
INSERT INTO Comments VALUES (2, 3, 'Can you add examples?',       TO_DATE('2025-06-01','YYYY-MM-DD'), NULL, 1);
INSERT INTO Comments VALUES (3, 1, 'Sure, next video will have.', TO_DATE('2025-06-02','YYYY-MM-DD'), 2,    1);
INSERT INTO Comments VALUES (4, 5, 'This pasta is great!',        TO_DATE('2025-06-02','YYYY-MM-DD'), NULL, 3);
INSERT INTO Comments VALUES (5, 2, 'Thanks for recipe',           TO_DATE('2025-06-03','YYYY-MM-DD'), 4,    3);
INSERT INTO Comments VALUES (6, 7, 'Lo-fi is perfect',            TO_DATE('2025-06-03','YYYY-MM-DD'), NULL, 5);
INSERT INTO Comments VALUES (7, 8, 'More guitar pls',             TO_DATE('2025-06-04','YYYY-MM-DD'), NULL, 6);
INSERT INTO Comments VALUES (8, 9, 'Workout was hard :D',         TO_DATE('2025-06-04','YYYY-MM-DD'), NULL, 7);
INSERT INTO Comments VALUES (9, 10,'Cool vlog!',                  TO_DATE('2025-06-05','YYYY-MM-DD'), NULL, 9);
INSERT INTO Comments VALUES (10,6, 'Nice editing',                TO_DATE('2025-06-05','YYYY-MM-DD'), 9,    9);

-- Notification (5)
INSERT INTO Notification VALUES (1, 2, 'New video uploaded on Tech Lab.',       TO_DATE('2025-06-10','YYYY-MM-DD'));
INSERT INTO Notification VALUES (2, 3, 'New video uploaded on Tech Lab.',       TO_DATE('2025-06-10','YYYY-MM-DD'));
INSERT INTO Notification VALUES (3, 1, 'New subscriber to your channel.',       TO_DATE('2025-06-11','YYYY-MM-DD'));
INSERT INTO Notification VALUES (4, 5, 'Your playlist "Quick Dinner" updated.', TO_DATE('2025-06-11','YYYY-MM-DD'));
INSERT INTO Notification VALUES (5, 3, 'Your video has been approved.',         TO_DATE('2025-06-12','YYYY-MM-DD'));

-- Report (5)
INSERT INTO Report VALUES (1, 1, 7, 'Inappropriate content',        TO_DATE('2025-06-10','YYYY-MM-DD'));
INSERT INTO Report VALUES (2, 5, 5, 'Copyright infringement',       TO_DATE('2025-06-11','YYYY-MM-DD'));
INSERT INTO Report VALUES (3, 4, 2, 'Spam / misleading content',    TO_DATE('2025-06-12','YYYY-MM-DD'));
INSERT INTO Report VALUES (4, 6, 5, 'Copyright infringement',       TO_DATE('2025-06-12','YYYY-MM-DD'));
INSERT INTO Report VALUES (5, 9, 7, 'Hate speech',                  TO_DATE('2025-06-12','YYYY-MM-DD'));

COMMIT;
