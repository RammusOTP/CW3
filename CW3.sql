/*
Scott Damoo - 
Maximo Hardaker - 
Emmanuel Phillips - 230355585 - ec23279@qmul.ac.uk

Scenario chosen: Eurostar2030
Specified location to run script: MySQL
*/

-- Create Database
CREATE DATABASE Eurostar2030;

-- Select Database
USE Eurostar2030;

-- Create Train table
CREATE TABLE Train (
    TrainID INT PRIMARY KEY AUTO_INCREMENT,
    TrainNumber VARCHAR(20) NOT NULL,
    Type VARCHAR(50),
    Status VARCHAR(20) CHECK (Status IN ('Operational', 'Under Maintenance', 'Retired')),
    Capacity INT NOT NULL,
    YearIntroduced YEAR
);

-- Create Station table
CREATE TABLE Station (
    StationID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Country VARCHAR(50),
    City VARCHAR(50),
    Type VARCHAR(20) CHECK (Type IN ('Start', 'Intermediate', 'End'))
);

-- Create Route table
CREATE TABLE Route (
    RouteID INT PRIMARY KEY AUTO_INCREMENT,
    StartStationID INT NOT NULL,
    EndStationID INT NOT NULL,
    Distance FLOAT NOT NULL,
    JourneyTime TIME NOT NULL,
    Status VARCHAR(20) CHECK (Status IN ('Operational', 'Planned')),
    FOREIGN KEY (StartStationID) REFERENCES Station(StationID),
    FOREIGN KEY (EndStationID) REFERENCES Station(StationID)
);

-- Create IntermediateStop table
CREATE TABLE IntermediateStop (
    StopID INT PRIMARY KEY AUTO_INCREMENT,
    RouteID INT NOT NULL,
    StationID INT NOT NULL,
    StopOrder INT NOT NULL,
    FOREIGN KEY (RouteID) REFERENCES Route(RouteID),
    FOREIGN KEY (StationID) REFERENCES Station(StationID)
);

-- Create Trip table
CREATE TABLE Trip (
    TripID INT PRIMARY KEY AUTO_INCREMENT,
    TrainID INT NOT NULL,
    RouteID INT NOT NULL,
    Date DATE NOT NULL,
    DepartureTime TIME NOT NULL,
    ArrivalTime TIME NOT NULL,
    PassengerCount INT DEFAULT 0,
    FOREIGN KEY (TrainID) REFERENCES Train(TrainID),
    FOREIGN KEY (RouteID) REFERENCES Route(RouteID)
);

-- Create Employee table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Role VARCHAR(50),
    HireDate DATE,
    Status VARCHAR(20) CHECK (Status IN ('Active', 'Inactive'))
);

-- Create CrewAssignment table
CREATE TABLE CrewAssignment (
    AssignmentID INT PRIMARY KEY AUTO_INCREMENT,
    TripID INT NOT NULL,
    EmployeeID INT NOT NULL,
    Role VARCHAR(50),
    FOREIGN KEY (TripID) REFERENCES Trip(TripID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create Passenger table
CREATE TABLE Passenger (
    PassengerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    PassengerType VARCHAR(20) CHECK (PassengerType IN ('Adult', 'Student', 'Senior', 'Child'))
);

-- Create Ticket table
CREATE TABLE Ticket (
    TicketID INT PRIMARY KEY AUTO_INCREMENT,
    TripID INT NOT NULL,
    PassengerID INT NOT NULL,
    TicketType VARCHAR(20) CHECK (TicketType IN ('Standard', 'First Class', 'Discounted')),
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (TripID) REFERENCES Trip(TripID),
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
);

--------------------------------------------------------------------------------------------------------------------

-- Insert data into Train table
INSERT INTO Train (TrainNumber, Type, Status, Capacity, YearIntroduced) VALUES
('E01', 'Express', 'Operational', 200, 2020),
('E02', 'Freight', 'Not Operational', 150, 2018),
('E03', 'High-Speed', 'Operational', 300, 2022),
('E04', 'Express', 'Operational', 250, 2021),
('E05', 'Freight', 'Retired', 100, 2015),
('E06', 'High-Speed', 'Operational', 350, 2023),
('E07', 'Freight', 'Not Operational', 200, 2019),
('E08', 'Express', 'Operational', 180, 2020),
('E09', 'High-Speed', 'Retired', 300, 2017),
('E10', 'Freight', 'Operational', 150, 2022);

-- Insert data into Station table
INSERT INTO Station (Name, Country, City, Type) VALUES
('London', 'UK', 'London', 'Start'),
('Paris', 'France', 'Paris', 'End'),
('Brussels', 'Belgium', 'Brussels', 'Intermediate'),
('Amsterdam', 'Netherlands', 'Amsterdam', 'Intermediate'),
('Cologne', 'Germany', 'Cologne', 'Intermediate'),
('Berlin', 'Germany', 'Berlin', 'Intermediate'),
('Geneva', 'Switzerland', 'Geneva', 'Start'),
('Zurich', 'Switzerland', 'Zurich', 'End'),
('Rome', 'Italy', 'Rome', 'Intermediate'),
('Madrid', 'Spain', 'Madrid', 'End');

-- Insert data into Route table
-- Insert data into Trip table
-- Insert data into Employee table
-- Insert data into CrewAssignment table
-- Insert data into Passenger table
-- Insert data into Ticket table

--------------------------------------------------------------------------------------------------------------------

-- Create 2 simple queries
-- Create 3 intermediate queries
-- Create 3 advanced queries
