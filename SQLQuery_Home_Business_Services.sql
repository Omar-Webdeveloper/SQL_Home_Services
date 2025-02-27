
create database  Home_Business_Services_Managment_Database;

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    PasswordHash VARCHAR(100),
    Role VARCHAR(20) CHECK (Role IN ('Manager', 'ServiceProvider', 'User')),
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE ServiceProviders (
    ProviderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT unique,
    BusinessName VARCHAR(100),
    ServiceType VARCHAR(50),
    Rating FLOAT,
    Achievements VARCHAR(100),
    Intro VARCHAR(2000),
    Photos VARCHAR(2000), -- URLs or paths to the provider's photos
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);
CREATE TABLE Services (
    ServiceID INT IDENTITY(1,1) PRIMARY KEY,
    ProviderID INT,
    ServiceName VARCHAR(100),
    Description VARCHAR(2000),
    Price DECIMAL(10, 2),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ProviderID) REFERENCES ServiceProviders(ProviderID) ON DELETE CASCADE
);
CREATE TABLE Bookings (
    BookingID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    ServiceID INT,
    BookingDate DATETIME,
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Confirmed', 'Completed')),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE NO ACTION,
    FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID) ON DELETE NO ACTION
);
CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    BookingID INT,
    Rating INT,
    Comment VARCHAR(2000),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID) ON DELETE CASCADE
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
    FOREIGN KEY (ProviderID) REFERENCES ServiceProviders(ProviderID) ON DELETE CASCADE
);