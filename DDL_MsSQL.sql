CREATE TABLE Advertisement (
  ID        INT            NOT NULL,
  Title     NVARCHAR(210)  NOT NULL,
  AdType    NVARCHAR(220)  NOT NULL,
  TargetUrl NVARCHAR(200)  NOT NULL,
  StartDate DATE           NOT NULL,
  EndDate   DATE           NOT NULL,
  CONSTRAINT PK_Advertisement PRIMARY KEY (ID),
  CONSTRAINT CK_Advertisement_Dates CHECK (EndDate >= StartDate)
);

CREATE TABLE Userauth (
  ID            INT           NOT NULL,
  Name          NVARCHAR(210) NOT NULL,
  PasswordHash  NVARCHAR(210) NOT NULL,
  CONSTRAINT PK_Userauth PRIMARY KEY (ID),
  CONSTRAINT UQ_Userauth_Name UNIQUE (Name)
);

CREATE TABLE Users (
  ID           INT           NOT NULL,
  FirstName    NVARCHAR(220) NOT NULL,
  LastName     NVARCHAR(220) NOT NULL,
  BirthDate    DATE          NOT NULL,
  Gender       NVARCHAR(220) NULL,
  Email        NVARCHAR(220) NOT NULL,
  Phone        VARCHAR(220)  NULL,
  CreationTime DATE          NOT NULL,
  Userauth_ID  INT           NOT NULL,
  CONSTRAINT PK_Users PRIMARY KEY (ID),
  CONSTRAINT UQ_Users_Email UNIQUE (Email),
  CONSTRAINT CK_Users_Gender CHECK (Gender IN ('M','F','O') OR Gender IS NULL),
  CONSTRAINT FK_Users_Userauth FOREIGN KEY (Userauth_ID) REFERENCES Userauth(ID)
);

CREATE TABLE Channel (
  ID         INT           NOT NULL,
  Name       NVARCHAR(240) NOT NULL,
  User_ID    INT           NOT NULL,
  CreationTI DATETIME2(0)  NOT NULL,
  CONSTRAINT PK_Channel PRIMARY KEY (ID),
  CONSTRAINT FK_Channel_Users FOREIGN KEY (User_ID) REFERENCES Users(ID)
);


CREATE TABLE Video (
  ID               INT           NOT NULL,
  Title            NVARCHAR(230) NOT NULL,
  FileType         NVARCHAR(25)  NOT NULL,
  Channel_ID       INT           NOT NULL,
  AgeRestriction   INT           NULL,
  Advertisement_ID INT           NULL,
  CONSTRAINT PK_Video PRIMARY KEY (ID),
  CONSTRAINT CK_Video_AgeRestriction CHECK (AgeRestriction IS NULL OR AgeRestriction >= 0),
  CONSTRAINT FK_Video_Channel FOREIGN KEY (Channel_ID) REFERENCES Channel(ID),
  CONSTRAINT FK_Video_Advertisement FOREIGN KEY (Advertisement_ID) REFERENCES Advertisement(ID)
);

CREATE TABLE VideoStats (
  Video_ID     INT NOT NULL,
  ViewCount    INT NOT NULL,
  LikeCount    INT NOT NULL,
  DislikeCount INT NOT NULL,
  CONSTRAINT PK_VideoStats PRIMARY KEY (Video_ID),
  CONSTRAINT CK_VideoStats_Counts CHECK (ViewCount >= 0 AND LikeCount >= 0 AND DislikeCount >= 0),
  CONSTRAINT FK_VideoStats_Video FOREIGN KEY (Video_ID) REFERENCES Video(ID)
);

CREATE TABLE Tag (
  ID INT           NOT NULL,
  Na NVARCHAR(230) NOT NULL,
  CONSTRAINT PK_Tag PRIMARY KEY (ID),
  CONSTRAINT UQ_Tag_Na UNIQUE (Na)
);

CREATE TABLE VideoTag (
  Video_ID INT NOT NULL,
  Tag_ID   INT NOT NULL,
  CONSTRAINT PK_VideoTag PRIMARY KEY (Video_ID, Tag_ID),
  CONSTRAINT FK_VideoTag_Video FOREIGN KEY (Video_ID) REFERENCES Video(ID),
  CONSTRAINT FK_VideoTag_Tag FOREIGN KEY (Tag_ID) REFERENCES Tag(ID)
);

CREATE TABLE Subscriber (
  Channel_ID INT          NOT NULL,
  User_ID    INT          NOT NULL,
  CreationT  DATETIME2(0) NOT NULL,
  CONSTRAINT PK_Subscriber PRIMARY KEY (Channel_ID, User_ID),
  CONSTRAINT FK_Subscriber_Channel FOREIGN KEY (Channel_ID) REFERENCES Channel(ID),
  CONSTRAINT FK_Subscriber_Users FOREIGN KEY (User_ID) REFERENCES Users(ID)
);

CREATE TABLE Playlist (
  ID            INT           NOT NULL,
  Name          NVARCHAR(250) NOT NULL,
  Description   NVARCHAR(200) NULL,
  User_ID       INT           NOT NULL,
  CreateTime    DATE          NOT NULL,
  Video_ID      INT           NOT NULL,
  CONSTRAINT PK_Playlist PRIMARY KEY (ID),
  CONSTRAINT FK_Playlist_Users FOREIGN KEY (User_ID) REFERENCES Users(ID),
  CONSTRAINT FK_Playlist_Video FOREIGN KEY (Video_ID) REFERENCES Video(ID)
);

CREATE TABLE WatchLaterVideo (
  ID       INT  NOT NULL,
  User_ID  INT  NOT NULL,
  Video_ID INT  NOT NULL,
  AddedTI  DATE NOT NULL,
  CONSTRAINT PK_WatchLaterVideo PRIMARY KEY (ID),
  CONSTRAINT FK_WatchLater_Users FOREIGN KEY (User_ID) REFERENCES Users(ID),
  CONSTRAINT FK_WatchLater_Video FOREIGN KEY (Video_ID) REFERENCES Video(ID)
);

CREATE TABLE Comments (
  ID              INT           NOT NULL,
  User_ID         INT           NOT NULL,
  CommentText     NVARCHAR(300) NOT NULL,
  ModificationTim DATE          NOT NULL,
  ParentComment   INT           NULL,
  Video_ID        INT           NOT NULL,
  CONSTRAINT PK_Comments PRIMARY KEY (ID),
  CONSTRAINT FK_Comments_Users FOREIGN KEY (User_ID) REFERENCES Users(ID),
  CONSTRAINT FK_Comments_Video FOREIGN KEY (Video_ID) REFERENCES Video(ID),
  CONSTRAINT FK_Comments_Parent FOREIGN KEY (ParentComment) REFERENCES Comments(ID)
);

CREATE TABLE Notification (
  ID         INT           NOT NULL,
  User_ID    INT           NOT NULL,
  Message    NVARCHAR(500) NOT NULL,
  CreateTime DATE          NOT NULL,
  CONSTRAINT PK_Notification PRIMARY KEY (ID),
  CONSTRAINT FK_Notification_Users FOREIGN KEY (User_ID) REFERENCES Users(ID)
);

CREATE TABLE Report (
  ID               INT           NOT NULL,
  Reporter_User_ID INT           NOT NULL,
  Video_ID         INT           NOT NULL,
  Reason           NVARCHAR(700) NOT NULL,
  ReportTime       DATE          NOT NULL,
  CONSTRAINT PK_Report PRIMARY KEY (ID),
  CONSTRAINT FK_Report_Users FOREIGN KEY (Reporter_User_ID) REFERENCES Users(ID),
  CONSTRAINT FK_Report_Video FOREIGN KEY (Video_ID) REFERENCES Video(ID)
);
