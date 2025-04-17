create database  Home_Business_Services_Managment_Database;
use  Home_Business_Services_Managment_Database;
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(200) UNIQUE NOT NULL,
    PasswordHash VARCHAR(100),
    Role VARCHAR(20) CHECK (Role IN ('Manager', 'ServiceProvider', 'User')),
    CreatedAt DATETIME DEFAULT GETDATE(),
	image varchar(200)
	Address VARCHAR(255),
    DateOfBirth DATE,
    PhoneNumber VARCHAR(20),
    Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female')),
    IsActive BIT DEFAULT 1
);

CREATE TABLE ServiceProviders (
    ProviderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT unique,
    WorkerName VARCHAR(100),
    ServiceType VARCHAR(50),
    Rating FLOAT,
    Achievements VARCHAR(100),
    Intro VARCHAR(2000),
	Register_at DATETIME DEFAULT GETDATE(),
    Photos VARCHAR(2000), -- URLs or paths to the provider's photos
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);
create table service_Workers_JunctionTable_
(
ProviderID INT,
ServiceID INT,
    FOREIGN KEY (ProviderID) REFERENCES ServiceProviders(ProviderID) ON DELETE CASCADE,
    FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID) ON DELETE CASCADE
)
CREATE TABLE Services (
    ServiceID INT IDENTITY(1,1) PRIMARY KEY,
    ServiceName VARCHAR(100) unique,
    Description VARCHAR(2000),
    Starting_Price DECIMAL(10, 2),
    CreatedAt DATETIME DEFAULT GETDATE(),
	image varchar(200)
);
CREATE TABLE Bookings (
    BookingID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    ServiceID INT,
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Confirmed', 'Completed')),
    BookingDate DATETIME DEFAULT GETDATE(),
	BookingTittle varchar(2000),
	BookingMessae varchar(2000),
	BookingNotes varchar(2000),
	ImageWhereTheIssueLocated varbinary(MAX),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE NO ACTION,
    FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID) ON DELETE NO ACTION
);
CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    BookingID INT,
    Rating INT,
    Comment VARCHAR(2000),
    CreatedAt DATETIME DEFAULT GETDATE(),
	Review_Status  VARCHAR(255) CHECK (Review_Status IN ('Pending', 'Rejected_Transfer_To_Manager', 'Accepted_To_Show_All' , 'Netural')),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID) ON DELETE No Action
);
CREATE TABLE Tasks (
    TaskID INT IDENTITY(1,1) PRIMARY KEY,
    ProviderID INT,
    TaskName VARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    TaskStatus VARCHAR(20) DEFAULT 'TO DO',
    BeforePhoto VARCHAR(2000), -- URL or path to the before photo
    AfterPhoto VARCHAR(2000), -- URL or path to the after photo
	TasksDetails nvarchar(200) not null default 'waiting',
    FOREIGN KEY (ProviderID) REFERENCES ServiceProviders(ProviderID) ON DELETE CASCADE
);

CREATE TABLE ContactUs (
    ContactID INT IDENTITY(1,1) PRIMARY KEY, -- Unique identifier for each contact entry
    FirstName VARCHAR(100) NOT NULL,        -- First Name of the user
    LastName VARCHAR(100) NOT NULL,         -- Last Name of the user
    Email VARCHAR(255) NOT NULL,            -- Email address of the user
    Message VARCHAR(2000) NOT NULL,                  -- Message sent by the user
    CreatedAt DATETIME DEFAULT GETDATE(),    -- Timestamp of the form submission
	UserID INT,
	FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE No Action
);

CREATE TABLE Evaluations (
    EvaluationID INT IDENTITY(1,1) PRIMARY KEY, -- Unique ID for each evaluation
    ProviderID INT,                             -- Reference to the ServiceProvider
    AdminID INT,                                -- Reference to the Admin (UserID of the Manager)
    EvaluationYear INT,                         -- Year of the evaluation
    Score FLOAT,                                -- Evaluation score
    Comments VARCHAR(2000),                     -- Optional comments by the admin
    CreatedAt DATETIME DEFAULT GETDATE(),       -- Timestamp for the evaluation
    FOREIGN KEY (ProviderID) REFERENCES ServiceProviders(ProviderID) ON DELETE NO ACTION,
    FOREIGN KEY (AdminID) REFERENCES Users(UserID) ON DELETE NO ACTION
);

