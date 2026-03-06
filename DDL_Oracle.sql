
-- 1) Advertisement
CREATE TABLE Advertisement (
  ID         NUMBER(10)     PRIMARY KEY,
  Title      NVARCHAR2(210)  NOT NULL,
  AdType     NVARCHAR2(220)  NOT NULL,
  TargetUrl  NVARCHAR2(200)  NOT NULL,
  StartDate  DATE           NOT NULL,
  EndDate    DATE           NOT NULL,
  CONSTRAINT CK_Advertisement_Dates CHECK (EndDate >= StartDate)
);

-- 2) Userauth
CREATE TABLE Userauth (
  ID       NUMBER(10)     PRIMARY KEY,
  Name     NVARCHAR2(210) NOT NULL,
  Password NVARCHAR2(210) NOT NULL,
  CONSTRAINT UQ_Userauth_Name UNIQUE (Name)
);

-- 3) User
CREATE TABLE "User" (
  ID            NUMBER(10)     PRIMARY KEY,
  FirstName     NVARCHAR2(220) NOT NULL,
  LastName      NVARCHAR2(220) NOT NULL,
  BirthDate     DATE           NOT NULL,
  Gender        NVARCHAR2(220) NULL,
  Email         NVARCHAR2(220) NOT NULL,
  Phone         VARCHAR2(220)  NULL,
  CreationTime  DATE           NOT NULL,
  Userauth_ID   NUMBER(10)     NOT NULL,
  CONSTRAINT UQ_User_Email UNIQUE (Email),
  CONSTRAINT FK_User_Userauth FOREIGN KEY (Userauth_ID) REFERENCES Userauth(ID),
  CONSTRAINT CK_User_Gender CHECK (Gender IN ('M','F','O') OR Gender IS NULL)
);

-- 4) Channel
CREATE TABLE Channel (
  ID          NUMBER(10)     PRIMARY KEY,
  Name        NVARCHAR2(240) NOT NULL,
  User_ID     NUMBER(10)     NOT NULL,
  CreationTI  TIMESTAMP      NOT NULL,
  CONSTRAINT FK_Channel_User FOREIGN KEY (User_ID) REFERENCES "User"(ID)
);

-- 5) Video
CREATE TABLE Video (
  ID              NUMBER(10)     PRIMARY KEY,
  Title           NVARCHAR2(230)  NOT NULL,
  FileType        NVARCHAR2(25)   NOT NULL,
  Channel_ID      NUMBER(10)      NOT NULL,
  AgeRestriction  NUMBER(10)      NULL,
  Advertisement_ID NUMBER(10)     NULL,
  CONSTRAINT FK_Video_Channel FOREIGN KEY (Channel_ID) REFERENCES Channel(ID),
  CONSTRAINT FK_Video_Advertisement FOREIGN KEY (Advertisement_ID) REFERENCES Advertisement(ID),
  CONSTRAINT CK_Video_AgeRestriction CHECK (AgeRestriction IS NULL OR AgeRestriction >= 0)
);

-- 6) VideoStats (1:1 with Video)
CREATE TABLE VideoStats (
  Video_ID     NUMBER(10) PRIMARY KEY,
  ViewCount    NUMBER(10) NOT NULL,
  LikeCount    NUMBER(10) NOT NULL,
  DislikeCount NUMBER(10) NOT NULL,
  CONSTRAINT FK_VideoStats_Video FOREIGN KEY (Video_ID) REFERENCES Video(ID),
  CONSTRAINT CK_VideoStats_Counts CHECK (
    ViewCount >= 0 AND LikeCount >= 0 AND DislikeCount >= 0
  )
);

-- 7) Tag
CREATE TABLE Tag (
  ID   NUMBER(10)     PRIMARY KEY,
  Na   NVARCHAR2(230) NOT NULL,
  CONSTRAINT UQ_Tag_Name UNIQUE (Na)
);

-- 8) VideoTag (M:N)
CREATE TABLE VideoTag (
  Video_ID NUMBER(10) NOT NULL,
  Tag_ID   NUMBER(10) NOT NULL,
  CONSTRAINT PK_VideoTag PRIMARY KEY (Video_ID, Tag_ID),
  CONSTRAINT FK_VideoTag_Video FOREIGN KEY (Video_ID) REFERENCES Video(ID),
  CONSTRAINT FK_VideoTag_Tag FOREIGN KEY (Tag_ID) REFERENCES Tag(ID)
);

-- 9) Subscriber (M:N)
CREATE TABLE Subscriber (
  Channel_ID NUMBER(10) NOT NULL,
  User_ID    NUMBER(10) NOT NULL,
  CreationT  TIMESTAMP  NOT NULL,
  CONSTRAINT PK_Subscriber PRIMARY KEY (Channel_ID, User_ID),
  CONSTRAINT FK_Subscriber_Channel FOREIGN KEY (Channel_ID) REFERENCES Channel(ID),
  CONSTRAINT FK_Subscriber_User FOREIGN KEY (User_ID) REFERENCES "User"(ID)
);

-- 10) Playlist
CREATE TABLE Playlist (
  ID         NUMBER(10)     PRIMARY KEY,
  Name       NVARCHAR2(250) NOT NULL,
  Description NVARCHAR2(200) NULL,
  User_ID    NUMBER(10)     NOT NULL,
  CreateTime DATE           NOT NULL,
  Video_ID   NUMBER(10)     NOT NULL,
  CONSTRAINT FK_Playlist_User FOREIGN KEY (User_ID) REFERENCES "User"(ID),
  CONSTRAINT FK_Playlist_Video FOREIGN KEY (Video_ID) REFERENCES Video(ID)
);

-- 11) WatchLaterVideo
CREATE TABLE WatchLaterVideo (
  ID       NUMBER(10) PRIMARY KEY,
  User_ID  NUMBER(10) NOT NULL,
  Video_ID NUMBER(10) NOT NULL,
  AddedTI  DATE       NOT NULL,
  CONSTRAINT FK_WatchLater_User FOREIGN KEY (User_ID) REFERENCES "User"(ID),
  CONSTRAINT FK_WatchLater_Video FOREIGN KEY (Video_ID) REFERENCES Video(ID)
);

-- 12) Comments
CREATE TABLE Comments (
  ID              NUMBER(10)     PRIMARY KEY,
  User_ID          NUMBER(10)     NOT NULL,
  CommentText     NVARCHAR2(300)  NOT NULL, 
  ModificationTim DATE           NOT NULL,
  ParentComment   NUMBER(10)      NULL,
  Video_ID        NUMBER(10)      NOT NULL,
  CONSTRAINT FK_Comments_User FOREIGN KEY (User_ID) REFERENCES "User"(ID),
  CONSTRAINT FK_Comments_Video FOREIGN KEY (Video_ID) REFERENCES Video(ID),
  CONSTRAINT FK_Comments_Parent FOREIGN KEY (ParentComment) REFERENCES Comments(ID)
);

-- 13) Notification
CREATE TABLE Notification (
  ID         NUMBER(10)     PRIMARY KEY,
  User_ID    NUMBER(10)     NOT NULL,
  Message    NVARCHAR2(500) NOT NULL, 
  CreateTime DATE           NOT NULL,
  CONSTRAINT FK_Notification_User FOREIGN KEY (User_ID) REFERENCES "User"(ID)
);

-- 14) Report
CREATE TABLE Report (
  ID               NUMBER(10)     PRIMARY KEY,
  Reporter_User_ID NUMBER(10)     NOT NULL,
  Video_ID         NUMBER(10)     NOT NULL,
  Reason           NVARCHAR2(700) NOT NULL, 
  ReportTime       DATE           NOT NULL,
  CONSTRAINT FK_Report_User FOREIGN KEY (Reporter_User_ID) REFERENCES "User"(ID),
  CONSTRAINT FK_Report_Video FOREIGN KEY (Video_ID) REFERENCES Video(ID)
);
