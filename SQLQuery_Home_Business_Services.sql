create database  Home_Business_Services_Managment_Database;
use  Home_Business_Services_Managment_Database;-- Base Users Table
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(200) UNIQUE NOT NULL,
    PasswordHash VARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE(),
    Personal_Image VARBINARY(MAX),
    Personal_Address VARCHAR(255),
    DateOfBirth DATE,
    PhoneNumber VARCHAR(20),
    Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female')),
	Location_Id INT ,
	Worker_Service_Type VARCHAR(50),
    Worker__Rating FLOAT,
    Worker__Intro VARCHAR(2000),
    IsActive BIT DEFAULT 1,
	FOREIGN KEY (Location_Id) REFERENCES Location_Areas(Location_Id) ON DELETE set null
);

-- Roles Table (to store different roles)
CREATE TABLE Roles (
    RoleID INT IDENTITY(1,1) PRIMARY KEY,
    RoleName VARCHAR(100) 
);

-- Junction Table: Many-to-Many Relationship between Users and Roles
CREATE TABLE UserRoles (
	id int IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    RoleID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE No Action,
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID) ON DELETE No Action,
    CONSTRAINT PK_UserRoles PRIMARY KEY (UserID, RoleID)  -- Composite Primary Key
);

CREATE TABLE Location_Areas(
    Location_Id INT IDENTITY(1,1) PRIMARY KEY,
	Areas_Covered Varchar(200) UNIQUE,
	ManagerID INT UNIQUE,
    FOREIGN KEY (ManagerID) REFERENCES Users(UserID) ON DELETE set null
);

CREATE TABLE Achievements (
    AchievementID INT IDENTITY(1,1) PRIMARY KEY, -- Unique achievement ID
    AchievementName VARCHAR(100) NOT NULL, -- Name or title of the achievement
	Achievement_Patch_Image VARBINARY(MAX),
    AchievementDescription VARCHAR(1000), -- Additional details about the achievement
    AchievementDate DATE -- Date when the achievement was earned
);

-- Junction Table: Many-to-Many Relationship between Workres and Roles

CREATE TABLE WorkerAchievements (
    WorkerID INT NOT NULL, -- Foreign key to Workers table
    AchievementID INT NOT NULL, -- Foreign key to Achievements table
    FOREIGN KEY (WorkerID) REFERENCES Users(UserID) ON DELETE No action,
    FOREIGN KEY (AchievementID) REFERENCES Achievements(AchievementID) ON DELETE No action
);


-- Services Table
CREATE TABLE Main_Service (
    ServiceID INT IDENTITY(1,1) PRIMARY KEY,
    ServiceName VARCHAR(100) UNIQUE,
    Description VARCHAR(2000),
    Service_Price DECIMAL(10, 2),
    CreatedAt DATETIME DEFAULT GETDATE(),
    Image VARBINARY(MAX)
);


-- Junction Table for Wroker <-> Service
CREATE TABLE Service_Workers_JunctionTable (
 ID INT IDENTITY(1,1) PRIMARY KEY,
    WrokerID INT,
    ServiceID INT,
	 Status VARCHAR(20) DEFAULT 'Pending'  CHECK (Status IN ('Pending', 'Rejected', 'Accepted')),
    FOREIGN KEY (WrokerID) REFERENCES Users(UserID) ON DELETE set null,
    FOREIGN KEY (ServiceID) REFERENCES Main_Service(ServiceID) ON DELETE set null
);

-- add status
CREATE TABLE Bookings (
    BookingID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    ServiceID INT,
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Confirmed', 'Completed')),
	Booking_Start_Date DateTime DEFAULT GETDATE(),
	Booking_End_Date DateTime,
    BookingTittle VARCHAR(2000),
    BookingMessae VARCHAR(2000),
    BookingNotes VARCHAR(2000),
    ImageWhereTheIssueLocated VARBINARY(MAX),
	ImageAfterFixing VARBINARY(MAX),
	WorkerID INT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ServiceID) REFERENCES Main_Service(ServiceID),
	FOREIGN KEY (WorkerID) REFERENCES Users(UserID) ON DELETE SET NULL
);

-- Payment Table
CREATE TABLE Payment (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    BookingID INT UNIQUE NOT NULL,
	Amount Float,
    Payment_Method VARCHAR(50),
    CardNumber VARCHAR(16),
    CVC VARCHAR(4),
    ExpiryDate DATE,
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);


-- Reviews Table
CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    BookingID INT,
    Rating INT,
    Comment VARCHAR(2000),
    CreatedAt DATETIME DEFAULT GETDATE(),
    Review_Status VARCHAR(255) CHECK (Review_Status IN ('Pending', 'Rejected_Transfer_To_Manager', 'Accepted_To_Show_All', 'Netural')),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);



-- Tasks Table
CREATE TABLE Tasks (
    TaskID INT IDENTITY(1,1) PRIMARY KEY,
    WrokerID INT,
    TaskName VARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    TaskStatus VARCHAR(20) DEFAULT 'TO DO',
    BeforePhoto VARBINARY(MAX),
    AfterPhoto VARBINARY(MAX),
    TasksDetails NVARCHAR(200) NOT NULL DEFAULT 'waiting',
    FOREIGN KEY (WrokerID) REFERENCES Users(UserID) ON DELETE set null
);

-- Contact Us Table
CREATE TABLE ContactUs (
    ContactID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    ContactUs_Message VARCHAR(2000) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
);

-- Evaluations Table
CREATE TABLE Evaluations (
    EvaluationID INT IDENTITY(1,1) PRIMARY KEY,
    WrokerID INT,
    EvaluationYear INT,
    Score FLOAT,
    Comments VARCHAR(2000),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (WrokerID) REFERENCES Users(UserID),
);



