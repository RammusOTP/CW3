/*
Scott Damoo - 230088627 - ec23076@qmul.ac.uk
Nefertiti Gansallo - 
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
('E02', 'Freight', 'Under Maintenance', 150, 2018),
('E03', 'High-Speed', 'Operational', 300, 2022),
('E04', 'Express', 'Operational', 250, 2021),
('E05', 'Freight', 'Retired', 100, 2015),
('E06', 'High-Speed', 'Operational', 350, 2023),
('E07', 'Freight', 'Under Maintenance', 200, 2019),
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

-- Insert data into Route tableS
INSERT INTO Route (StartStation, EndStation, Distance, JourneyTime, Status) VALUES ('London', 'Paris', 450, 5, 'Operational'), 
('London', 'Brussels', 320, 3.5, 'Operational'), 
('Paris', 'Brussels', 300, 3, 'Operational'), 
('Brussels', 'Amsterdam', 200, 2.5, 'Operational'), 
('Amsterdam', 'Cologne', 220, 3, 'Operational'), 
('Cologne', 'Berlin', 300, 4, 'Operational'), 
('Berlin', 'Geneva', 700, 8, 'Operational'), 
('Zurich', 'Geneva', 280, 2.5, 'Operational'), 
('Paris', 'Zurich', 550, 6, 'Operational'), 
('London', 'Zurich', 700, 7, 'Operational');

-- Insert data into Trip table
INSERT INTO Trip (Date, DepartureTime, ArrivalTime, PassengerCount) VALUES ('2024-12-06', '08:00:00', '13:00:00', 150), 
('2024-12-06', '09:00:00', '12:30:00', 120), 
('2024-12-06', '10:00:00', '13:00:00', 200), 
('2024-12-06', '07:30:00', '10:00:00', 80), 
('2024-12-06', '11:00:00', '17:00:00', 250), 
('2024-12-06', '12:00:00', '16:00:00', 100), 
('2024-12-06', '13:00:00', '21:00:00', 180), 
('2024-12-06', '14:00:00', '16:30:00', 90), 
('2024-12-06', '15:00:00', '17:30:00', 170);


-- Insert data into Employee table
INSERT INTO Employee (Name, Role, HireDate, Status) VALUES 
('John Doe', 'Train Driver', '2015-06-20', 'Active'), 
('Jane Smith', 'Conductor', '2017-03-15', 'Active'), 
('Alice Johnson', 'Station Manager', '2016-05-10', 'Active'), 
('Bob Brown', 'Engineer', '2018-08-25', 'Active'), 
('Charlie Davis', 'Ticketing Officer', '2019-01-30', 'Active'), 
('Eve Wilson', 'Train Driver', '2020-04-10', 'Active'), 
('Liam Lee', 'Conductor', '2021-11-05', 'Active'), 
('Sophia King', 'Engineer', '2022-02-15', 'Active'), 
('Mason Clark', 'Station Attendant', '2020-07-25', 'Active'), 
('Olivia Adams', 'Customer Service Representative', '2021-06-20', 'Active');



-- Insert data into CrewAssignment table
('T01', 'E001', 'Train Driver'), 
('T01', 'E002', 'Conductor'), 
('T03', 'E001', 'Train Driver'), 
('T03', 'E002', 'Conductor'), 
('T04', 'E001', 'Train Driver'), 
('T04', 'E002', 'Conductor'), 
('T05', 'E001', 'Train Driver'), 
('T05', 'E002', 'Conductor'), 
('T06', 'E006', 'Train Driver'), 
('T06', 'E007', 'Conductor');

-- Insert data into Passenger table
INSERT INTO Passenger (Name) VALUES 
('Emily Davis'), 
('Michael Thompson'), 
('Sarah Lee'), 
('James Wilson'), 
('David Clark'),
('Isabella Turner'), 
('Liam Harris'), 
('Olivia Martinez'), 
('Lucas Robinson'), 
('Mia White');

-- Insert data into Ticket table
INSERT INTO Ticket (PassengerID, TripID) VALUES 
('001', '01'), 
('002', '03'), 
('003', '05'), 
('004', '04'), 
('005', '06'), 
('006', '08'), 
('007', '02'), 
('008', '07'), 
('009', '09'), 
('010', '01');

--------------------------------------------------------------------------------------------------------------------

-- Create 2 simple queries
-- Create 3 intermediate queries
-- Create 3 advanced queries

