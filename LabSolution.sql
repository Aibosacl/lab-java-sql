# Exercise 2

CREATE DATABASE airline_db;

USE airline_db;

CREATE TABLE Customers (
                           Customer_id INT PRIMARY KEY,
                           Name VARCHAR(100),
                           Status VARCHAR(20),
                           Mileage INT
);

CREATE TABLE Flights (
                         Flight_id INT PRIMARY KEY,
                         Flight_Number VARCHAR(50),
                         Aircraft VARCHAR(50),
                         Aircraft_seats INT,
                         Flight_Mileage INT
);


CREATE TABLE Aircraft (
                          AircraftID INT AUTO_INCREMENT PRIMARY KEY,
                          AircraftName VARCHAR(100),
                          TotalSeats INT
);



CREATE TABLE CustomerFlights (
                                 CustomerFlightID INT AUTO_INCREMENT PRIMARY KEY,
                                 FlightID INT,
                                 AircraftID INT,
                                 FOREIGN KEY (FlightID) REFERENCES Flights(Flight_id),
                                 FOREIGN KEY (AircraftID) REFERENCES Aircraft(AircraftID)
);



CREATE TABLE Bookings (
                          Booking_id int PRIMARY KEY,
                          Customer_id INT,
                          Flight_id INT,
                          FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id),
                          FOREIGN KEY (Flight_id) REFERENCES Flights(Flight_id)
);

INSERT INTO Customers (Customer_id, Name, Status, Mileage)
VALUES
    ('1', 'Agustine Riviera', 'Silver', 115235),
    ('2', 'Alaina Sepulvida', 'None', 6008),
    ('3', 'Tom Jones', 'Gold', 205767),
    ('4', 'Sam Rio', 'None', 2653),
    ('5', 'Jessica James', 'Silver', 127656),
    ('6', 'Ana Janco', 'Silver', 136773),
    ('7', 'Jennifer Cortez', 'Gold', 300582),
    ('8', 'Christian Janco', 'Silver', 14642);

INSERT INTO Flights (Flight_id, Flight_Number, Aircraft, Aircraft_seats, Flight_Mileage)
VALUES
    ('1', 'DL143', 'Boeing 747', 400, 135),
    ('2', 'DL122', 'Airbus A330', 236, 4370),
    ('3','DL53', 'Boeing 777', 264, 2078),
    ('4', 'DL222', 'Boeing 777', 264, 1765),
    ('5', 'DL37', 'Boeing 747', 400, 531);



INSERT INTO Aircraft (AircraftName, TotalSeats)
VALUES
    ('Boeing 747', 400),
    ('Airbus A330', 236),
    ('Boeing 777', 264);



INSERT INTO Bookings (Booking_id, Customer_id, Flight_id)
VALUES
    ('1', '1', '1'),
    ('2', '1', '2'),
    ('3','2', '2'),
    ('4', '3', '2'),
    ('5', '3', '3'),
    ('6', '3', '4'),
    ('7', '4', '1'),
    ('8', '5', '1'),
    ('9', '5', '2'),
    ('10', '6', '4'),
    ('11', '7', '4'),
    ('12', '8', '4');

# exercise 3
SELECT COUNT(*) AS TotalFlights FROM Flights;
# exercise 4
SELECT AVG(Flight_Mileage) AS AverageFlightDistance FROM Flights;

SELECT AVG(Aircraft_seats) AS AverageSeats FROM Flights;

SELECT Status, AVG(Mileage) AS AverageMileage
FROM Customers
GROUP BY Status;

SELECT Status, MAX(Mileage) AS MaxMileage
FROM Customers
GROUP BY Status;

SELECT COUNT(*) AS TotalBoeingAircraft
FROM Flights
WHERE Aircraft LIKE '%Boeing%';

SELECT *
FROM Flights
WHERE Flights.Flight_Mileage BETWEEN 300 AND 2000;

SELECT c.Status, AVG(f.Flight_Mileage) AS AverageFlightDistance
FROM Customers c
         JOIN Bookings b ON c.Customer_id = b.Customer_id
         JOIN Flights f ON b.Flight_id = f.Flight_id
GROUP BY c.Status;


SELECT f.Aircraft, COUNT(*) AS BookingCount
FROM Customers c
         JOIN Bookings b ON c.Customer_id = b.Customer_id
         JOIN Flights f ON b.Flight_id = f.Flight_id
WHERE c.Status = 'Gold'
GROUP BY f.Aircraft
ORDER BY BookingCount DESC
LIMIT 1;
