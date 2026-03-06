
-- Advertisement (5)
INSERT INTO s32782.Advertisement (ID, Title, AdType, TargetUrl, StartDate, EndDate) VALUES
(1, N'Summer Sale',       N'pre-roll', N'https://ads.example/summer',  '2025-06-01', '2025-06-30'),
(2, N'New Phone',         N'overlay',  N'https://ads.example/phone',   '2025-05-10', '2025-07-10'),
(3, N'Gaming Laptop',     N'banner',   N'https://ads.example/laptop',  '2025-04-01', '2025-08-01'),
(4, N'Coffee Brand',      N'pre-roll', N'https://ads.example/coffee',  '2025-01-01', '2025-12-31'),
(5, N'Streaming Service', N'banner',   N'https://ads.example/stream',  '2025-02-15', '2025-09-15');

-- Userauth (10)
INSERT INTO s32782.Userauth (ID, Name, PasswordHash) VALUES
(1,  N'irina', N'hash_pw_1'),
(2,  N'olek',  N'hash_pw_2'),
(3,  N'anna',  N'hash_pw_3'),
(4,  N'max',   N'hash_pw_4'),
(5,  N'kate',  N'hash_pw_5'),
(6,  N'den',   N'hash_pw_6'),
(7,  N'maria', N'hash_pw_7'),
(8,  N'serg',  N'hash_pw_8'),
(9,  N'vlad',  N'hash_pw_9'),
(10, N'nina',  N'hash_pw_10');

-- User (10)
INSERT INTO s32782.Users (ID, FirstName, LastName, BirthDate, Gender, Email, Phone, CreationTime, Userauth_ID) VALUES
(1,  N'Irina',  N'Nekrashevych', '1996-02-10', N'F', N'irina@mail.com',  '48100100100', '2024-01-05', 1),
(2,  N'Olek',   N'Mykytchenko',  '2002-11-02', N'M', N'olek@mail.com',   NULL,          '2024-02-10', 2),
(3,  N'Anna',   N'Koval',        '1999-07-21', N'F', N'anna@mail.com',   '48100200300', '2024-03-11', 3),
(4,  N'Max',    N'Brown',        '1997-05-12', N'M', N'max@mail.com',    NULL,          '2024-03-20', 4),
(5,  N'Kate',   N'Nowak',        '2000-09-30', N'F', N'kate@mail.com',   '48100500500', '2024-04-05', 5),
(6,  N'Denys',  N'Shevchenko',   '1998-12-01', N'M', N'den@mail.com',    '48100600600', '2024-04-18', 6),
(7,  N'Maria',  N'Ivanova',      '2001-01-14', N'F', N'maria@mail.com',  NULL,          '2024-05-02', 7),
(8,  N'Sergii', N'Petrenko',     '1995-10-10', N'M', N'serg@mail.com',   '48100800800', '2024-05-10', 8),
(9,  N'Vlad',   N'Nekrashevych', '2016-06-06', N'M', N'vlad@mail.com',   NULL,          '2024-06-01', 9),
(10, N'Nina',   N'Lee',          '1994-08-08', N'O', N'nina@mail.com',   '48101001000', '2024-06-10', 10);

-- Channel (5)
INSERT INTO s32782.Channel (ID, Name, User_ID, CreationTI) VALUES
(1, N'Tech Lab',     1, CAST('2024-02-01T10:00:00' AS datetime2(0))),
(2, N'Cooking Easy', 2, CAST('2024-02-10T12:30:00' AS datetime2(0))),
(3, N'Music Room',   3, CAST('2024-03-01T09:15:00' AS datetime2(0))),
(4, N'Fitness Pro',  4, CAST('2024-03-10T18:00:00' AS datetime2(0))),
(5, N'Travel Daily', 5, CAST('2024-04-01T08:45:00' AS datetime2(0)));

-- Video (10)
INSERT INTO s32782.Video (ID, Title, FileType, Channel_ID, AgeRestriction, Advertisement_ID) VALUES
(1,  N'Java Threads Basics',        N'mp4', 1, NULL, 1),
(2,  N'Oracle PL/SQL Cursor',       N'mp4', 1, 16,   NULL),
(3,  N'Pasta in 10 minutes',        N'mp4', 2, NULL, 2),
(4,  N'Perfect pancakes',           N'mp4', 2, NULL, NULL),
(5,  N'Lo-fi beats',                N'mp3', 3, NULL, 5),
(6,  N'Guitar tutorial 1',          N'mp4', 3, NULL, NULL),
(7,  N'Home workout 20min',         N'mp4', 4, 12,   3),
(8,  N'Stretching routine',         N'mp4', 4, NULL, NULL),
(9,  N'Warsaw weekend vlog',        N'mp4', 5, NULL, 4),
(10, N'Kyiv city walk',             N'mp4', 5, NULL, NULL);

-- VideoStats (10)
INSERT INTO s32782.VideoStats (Video_ID, ViewCount, LikeCount, DislikeCount) VALUES
(1,  1200, 130,  5),
(2,   900,  95,  3),
(3,  4000, 520, 10),
(4,  3100, 430,  7),
(5,  8000, 900, 20),
(6,  2500, 300,  8),
(7,  1500, 160,  4),
(8,  1800, 210,  6),
(9,  2200, 260,  9),
(10, 5000, 610, 12);

-- Tag (10)
INSERT INTO s32782.Tag (ID, Na) VALUES
(1,  N'java'),
(2,  N'oracle'),
(3,  N'cooking'),
(4,  N'music'),
(5,  N'fitness'),
(6,  N'travel'),
(7,  N'tutorial'),
(8,  N'vlog'),
(9,  N'database'),
(10, N'playlist');

-- VideoTag (12)
INSERT INTO s32782.VideoTag (Video_ID, Tag_ID) VALUES
(1, 1), (1, 7),
(2, 2), (2, 9),
(3, 3), (3, 7),
(5, 4), (6, 4),
(7, 5), (8, 5),
(9, 6), (10, 6);

-- Subscriber (10)
INSERT INTO s32782.Subscriber (Channel_ID, User_ID, CreationT) VALUES
(1, 2, CAST('2024-04-01T10:00:00' AS datetime2(0))),
(1, 3, CAST('2024-04-02T11:00:00' AS datetime2(0))),
(1, 4, CAST('2024-04-03T12:00:00' AS datetime2(0))),
(2, 1, CAST('2024-04-04T13:00:00' AS datetime2(0))),
(2, 5, CAST('2024-04-05T14:00:00' AS datetime2(0))),
(3, 1, CAST('2024-04-06T15:00:00' AS datetime2(0))),
(3, 6, CAST('2024-04-07T16:00:00' AS datetime2(0))),
(4, 7, CAST('2024-04-08T17:00:00' AS datetime2(0))),
(5, 8, CAST('2024-04-09T18:00:00' AS datetime2(0))),
(5, 9, CAST('2024-04-10T19:00:00' AS datetime2(0)));

-- Playlist (5)
INSERT INTO s32782.Playlist (ID, Name, [Description], User_ID, CreateTime, Video_ID) VALUES
(1, N'Study DB',     N'SQL & PL/SQL videos', 1, '2025-06-01', 2),
(2, N'Quick Dinner', N'fast cooking',        2, '2025-06-01', 3),
(3, N'Workout',      N'home fitness',        4, '2025-06-02', 7),
(4, N'Travel Plans', N'vlogs to watch',      5, '2025-06-02', 9),
(5, N'Music Chill',  NULL,                  3, '2025-06-03', 5);

-- WatchLaterVideo (5)
INSERT INTO s32782.WatchLaterVideo (ID, User_ID, Video_ID, AddedTI) VALUES
(1, 1, 3,  '2025-06-05'),
(2, 1, 7,  '2025-06-05'),
(3, 2, 2,  '2025-06-06'),
(4, 6, 9,  '2025-06-06'),
(5, 8, 10, '2025-06-07');

-- Comments (10)
INSERT INTO s32782.Comments (ID, User_ID, CommentText, ModificationTim, ParentComment, Video_ID) VALUES
(1,  2,  N'Nice explanation!',            '2025-06-01', NULL, 1),
(2,  3,  N'Can you add examples?',        '2025-06-01', NULL, 1),
(3,  1,  N'Sure, next video will have.',  '2025-06-02', 2,    1),
(4,  5,  N'This pasta is great!',         '2025-06-02', NULL, 3),
(5,  2,  N'Thanks for recipe',            '2025-06-03', 4,    3),
(6,  7,  N'Lo-fi is perfect',             '2025-06-03', NULL, 5),
(7,  8,  N'More guitar pls',              '2025-06-04', NULL, 6),
(8,  9,  N'Workout was hard :D',          '2025-06-04', NULL, 7),
(9,  10, N'Cool vlog!',                   '2025-06-05', NULL, 9),
(10, 6,  N'Nice editing',                 '2025-06-05', 9,    9);

-- Notification (5)
INSERT INTO s32782.Notification (ID, User_ID, Message, CreateTime) VALUES
(1, 2, N'New video uploaded on Tech Lab.',        '2025-06-10'),
(2, 3, N'New video uploaded on Tech Lab.',        '2025-06-10'),
(3, 1, N'New subscriber to your channel.',        '2025-06-11'),
(4, 5, N'Your playlist "Quick Dinner" updated.',  '2025-06-11'),
(5, 3, N'Your video has been approved.',          '2025-06-12');

-- Report (5)
INSERT INTO s32782.Report (ID, Reporter_User_ID, Video_ID, Reason, ReportTime) VALUES
(1, 1, 7, N'Inappropriate content',      '2025-06-10'),
(2, 5, 5, N'Copyright infringement',     '2025-06-11'),
(3, 4, 2, N'Spam / misleading content',  '2025-06-12'),
(4, 6, 5, N'Copyright infringement',     '2025-06-12'),
(5, 9, 7, N'Hate speech',                '2025-06-12');
