/*
Scott Damoo - 230088627 - ec23076@qmul.ac.uk
Nefertiti Gansallo - 230324248 - ec23256@qmul.ac.uk
Maximo Hardaker - 230523552 - ec23339@qmul.ac.uk
Emmanuel Phillips - 230355585 - ec23279@qmul.ac.uk

Scenario chosen: Eurostar2030
Specified location to run script: MySQL
*/

-- Create Database
CREATE DATABASE IF NOT EXISTS Eurostar2030;

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

-- Insert data into Route table
INSERT INTO Route (StartStationID, EndStationID, Distance, JourneyTime, Status) VALUES
(1, 2, 450, '05:00:00', 'Operational'), 
(1, 3, 320, '03:30:00', 'Operational'), 
(2, 3, 300, '03:00:00', 'Operational'), 
(3, 4, 200, '02:30:00', 'Operational'), 
(4, 5, 220, '03:00:00', 'Operational'), 
(5, 6, 300, '04:00:00', 'Operational'), 
(6, 7, 700, '08:00:00', 'Operational'), 
(8, 7, 280, '02:30:00', 'Operational'), 
(2, 8, 550, '06:00:00', 'Operational'), 
(1, 8, 700, '07:00:00', 'Operational');

-- Insert data into Trip table
INSERT INTO Trip (TrainID, RouteID, Date, DepartureTime, ArrivalTime, PassengerCount) VALUES
(1, 1, '2024-12-06', '08:00:00', '13:00:00', 150),
(2, 2, '2024-12-06', '09:00:00', '12:30:00', 120),
(3, 3, '2024-12-06', '10:00:00', '13:00:00', 200),
(4, 4, '2024-12-06', '07:30:00', '10:00:00', 80),
(5, 5, '2024-12-06', '11:00:00', '17:00:00', 250),
(6, 6, '2024-12-06', '12:00:00', '16:00:00', 100),
(7, 7, '2024-12-06', '13:00:00', '21:00:00', 180),
(8, 8, '2024-12-06', '14:00:00', '16:30:00', 90),
(9, 9, '2024-12-06', '15:00:00', '17:30:00', 170);

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
INSERT INTO CrewAssignment (TripID, EmployeeID, Role) VALUES
(1, 1, 'Train Driver'), 
(1, 2, 'Conductor'), 
(2, 1, 'Train Driver'), 
(2, 2, 'Conductor'), 
(3, 1, 'Train Driver'), 
(3, 2, 'Conductor'), 
(4, 6, 'Train Driver'), 
(4, 7, 'Conductor'), 
(5, 6, 'Train Driver'), 
(5, 7, 'Conductor');

-- Insert data into Passenger table
INSERT INTO Passenger (Name, PassengerType) VALUES
('Emily Davis', 'Adult'), 
('Michael Thompson', 'Senior'), 
('Sarah Lee', 'Student'), 
('James Wilson', 'Adult'), 
('David Clark', 'Child'),
('Isabella Turner', 'Adult'), 
('Liam Harris', 'Senior'), 
('Olivia Martinez', 'Student'), 
('Lucas Robinson', 'Adult'), 
('Mia White', 'Child');

-- Insert data into Ticket table
INSERT INTO Ticket (PassengerID, TripID, TicketType, Price) VALUES
(1, 1, 'Standard', 45.50),
(2, 1, 'First Class', 75.00),
(3, 2, 'Discounted', 35.00),
(4, 2, 'Standard', 45.50),
(5, 3, 'First Class', 80.00),
(6, 3, 'Standard', 50.00),
(7, 4, 'Discounted', 30.00),
(8, 4, 'Standard', 40.00),
(9, 5, 'First Class', 90.00),
(10, 5, 'Standard', 60.00),
(1, 6, 'Discounted', 25.00),
(2, 6, 'Standard', 40.50),
(3, 7, 'First Class', 85.00),
(4, 7, 'Standard', 55.00),
(5, 8, 'Discounted', 20.00),
(6, 8, 'Standard', 35.00),
(7, 9, 'First Class', 95.00),
(8, 9, 'Standard', 65.00);

--------------------------------------------------------------------------------------------------------------------

-------------------- TWO BASIC QUERIES --------------------

-- LIST ALL TRAINS THAT ARE CURRENTLY OPERATIONAL
SELECT TrainNumber, Type, Capacity, YearIntroduced
FROM Train
WHERE Status = 'Operational';

-- LIST NAMES OF ALL STATIONS THAT ARE INTERMEDIATE STATIONS
SELECT Name, City
FROM Station
WHERE Type = 'Intermediate';

-------------------- THREE INTERMEDIATE QUERIES --------------------

-- FIND THE TOTAL NUMBER OF PASSENGERS ON EACH TRIP
SELECT TripID, SUM(PassengerCount) AS TotalPassengers
FROM Trip
GROUP BY TripID;

--FIND ALL THE TICKET PRICES SOLD FOR ROUTEID 1, AND THE PASSENGER TYPE AND TICKET PRICE
SELECT t.TripID, p.Name AS PassengerName, p.PassengerType, ti.TicketType, ti.Price
FROM Ticket ti
JOIN Trip t ON ti.TripID = t.TripID
JOIN Passenger p ON ti.PassengerID = p.PassengerID
WHERE t.RouteID = 1; 

--LIST ALL CREW ASSIGNMENTS FOR ROUTEID 1, AND EMPLOYEE NAMES AND THEIR ROLES
SELECT ca.TripID, e.Name AS EmployeeName, ca.Role
FROM CrewAssignment ca
JOIN Employee e ON ca.EmployeeID = e.EmployeeID
WHERE ca.TripID = 1;  


-------------------- THREE ADVANCED QUERIES --------------------

--FIND THE AVERAGE DISTANCE AND JOURNEY TIME FOR ALL TRAIN ROUTES STARTING IN LONDON
SELECT AVG(Distance) AS AverageDistance, AVG(TIMESTAMPDIFF(MINUTE, '00:00:00', JourneyTime)) AS AverageJourneyTime
FROM Route r
JOIN Station s ON r.StartStationID = s.StationID
WHERE s.Name = 'London';

--FIND THE TOTAL REVENUE FOR EACH TRIP USING TICKET PRICES
SELECT t.TripID, SUM(ti.Price) AS TotalRevenue
FROM Ticket ti
JOIN Trip t ON ti.TripID = t.TripID
GROUP BY t.TripID;


--FIND THE MOST POPULAR TRAIN TYPE USING PASSENGER COUNT
SELECT tr.Type, SUM(t.PassengerCount) AS TotalPassengers
FROM Train tr
JOIN Trip t ON tr.TrainID = t.TrainID
GROUP BY tr.Type
ORDER BY TotalPassengers DESC
LIMIT 1;
