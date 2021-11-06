create schema Assignemnt2;
use Assignemnt2;

-- SECTION 1 Tables
-- Task 1 -- **

CREATE TABLE TruckMake(
TruckMakeID varchar(3),
TruckMakeName char(20),
PRIMARY KEY(TruckMakeID)
);

CREATE TABLE TruckModel(
TruckMakeID varchar(3),
TruckModelID varchar(3),
TruckModelName varchar(5),
PRIMARY KEY(TruckModelID, TruckMakeID),
FOREIGN KEY(TruckMakeID) REFERENCES TruckMake(TruckMakeID)
);

CREATE TABLE Truck(
TruckVINNum varchar(4),
TruckMakeID varchar(3),
TruckModelID varchar(3),
TruckColour char(10),
TruckPurchaseDate date,
TruckCost varchar(15),
PRIMARY KEY(TruckVINNum),
FOREIGN KEY(TruckMakeID) REFERENCES TruckMake(TruckMakeID),
FOREIGN KEY(TruckModelID) REFERENCES TruckModel(TruckModelID)
);

CREATE TABLE Service(
TransportID varchar(2),
TransportName char(15),
TransportCost varchar(10),
TransportMaxDist decimal(6,2),
PRIMARY KEY (TransportID)
);

CREATE TABLE Allocation(
TruckVINNum varchar(4),
TransportID varchar(2),
FromDate date ,
ToDate date ,
PRIMARY KEY(TruckVINNum, TransportID),
FOREIGN KEY(TruckVINNum) REFERENCES Truck(TruckVINNum),
FOREIGN KEY(TransportID) REFERENCES Service(TransportID)
);

-- SECTION 2 Tables:
CREATE TABLE Customer(
CustomerID varchar(4),
CustomerName char(20),
CustomerPhNum int,
PRIMARY KEY(CustomerID)
);

CREATE TABLE BookingReq(
RequestID varchar(4),
CustomerID varchar(4),
RequestDate date,
RequestText char(50),
PRIMARY KEY(RequestID),
FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Invoice(
InvoiceNum varchar(3),
RequestID varchar(4),
InvoiceDate date,
InvoiceAmount int,
PRIMARY KEY(InvoiceNum),
FOREIGN KEY(RequestID) REFERENCES BookingReq(RequestID)
);


CREATE TABLE Payment(
PaymentID varchar(4),
InvoiceID varchar(3),
PaymentDate date,
PaymentAmount int,
PRIMARY KEY(PaymentID),
FOREIGN KEY(InvoiceID) REFERENCES Invoice(InvoiceNum) 
);


-- SECTION 3 Tables
CREATE TABLE Staff(
StaffID varchar(4),
StaffName char(20),
ManagerID varchar(2) null,
PRIMARY KEY (StaffID),
FOREIGN KEY (ManagerID) REFERENCES Staff(StaffID)
);

CREATE TABLE Location(
LocationID varchar(3),
LocationName char(20),
LocationState char(3),
LocationPostCode int,
PRIMARY KEY(LocationID)
);

CREATE TABLE TripSchedule(
ScheduleID varchar(3),
StartLoc varchar(3),
EndLoc varchar(3),
RequestID varchar(4),
TruckVINNum varchar(4),
TransportID varchar(2),
StaffID varchar(2),
TripStart datetime,
TripEnd datetime,
PRIMARY KEY(ScheduleID),
FOREIGN KEY(StartLoc) REFERENCES Location(LocationID),
FOREIGN KEY(EndLoc) REFERENCES Location(LocationID),
FOREIGN KEY(RequestID) REFERENCES BookingReq(RequestID),
FOREIGN KEY(TruckVINNum) REFERENCES Allocation(TruckVINNum),
FOREIGN KEY(TransportID) REFERENCES Allocation(TransportID),
FOREIGN KEY(StaffID) REFERENCES Staff(StaffID)
);

-- Section 4
CREATE TABLE SupportStaff(
ScheduleID varchar(3),
StaffID varchar(2),
HoursNeeded int,
PRIMARY KEY(StaffID, ScheduleID),
FOREIGN KEY(ScheduleID) REFERENCES TripSchedule(ScheduleID),
FOREIGN KEY(StaffID) REFERENCES Staff(StaffID)
);


-- Section 1 INSERT INTO
INSERT INTO TruckMake values ('TM1', 'Volvo');
INSERT INTO TruckMake values ('TM2', 'Volkswagen');
INSERT INTO TruckMake values ('TM3', 'BMW');
INSERT INTO TruckMake values ('TM4', 'Audi');
INSERT INTO TruckMake values ('TM5', 'Toyota');
INSERT INTO TruckMake values ('TM6', 'Volvo');
INSERT INTO TruckMake values ('TM7', 'Holden');
INSERT INTO TruckMake values ('TM8', 'Subaru'); 

INSERT INTO TruckModel values ('TM1','MO1','FH16');
INSERT INTO TruckModel values ('TM2','MO2','FH17');
INSERT INTO TruckModel values ('TM3','MO3','FH18');
INSERT INTO TruckModel values ('TM4','MO4','FH19');
INSERT INTO TruckModel values ('TM5','MO5','FH20');
INSERT INTO TruckModel values ('TM6','MO6','FH21');
INSERT INTO TruckModel values ('TM7','MO7','FH22');
INSERT INTO TruckModel values ('TM8','MO8','FH23');

INSERT INTO Truck values ('V023','TM1','MO1','Red','2015-04-01','$4000');
INSERT INTO Truck values ('V024','TM2','MO2','Orange','2015-06-01','$1550');
INSERT INTO Truck values ('V025','TM3','MO3','Red','2015-08-01','$2000');
INSERT INTO Truck values ('V026','TM4','MO4','Blue','2015-10-01','$2000');
INSERT INTO Truck values ('V027','TM5','MO5','Red','2015-12-01','$2500');
INSERT INTO Truck values ('V028','TM6','MO6','Brown','2015-07-01','$6000');
INSERT INTO Truck values ('V029','TM7','MO7','Red','2015-07-23','$2900');
INSERT INTO Truck values ('V030','TM8','MO8','Orange','2015-07-15','$3600');


INSERT INTO Service values ('T1','Removalist','$5000','1000.56');
INSERT INTO Service values ('T2','Carpenter','$6000','2000.56');
INSERT INTO Service values ('T3','Tiler','$7000','3000.56');
INSERT INTO Service values ('T4','Excavator','$8000','4000.56');
INSERT INTO Service values ('T5','Plumbing','$9000','5000.56');
INSERT INTO Service values ('T6','Roofing','$6000','6000.56');
INSERT INTO Service values ('T7','Tiler','$2000','7000.56');
INSERT INTO Service values ('T8','Electrician','$4000','8000.56');

INSERT INTO Allocation values ('V023','T1', '2020-04-01', '2020-04-04');
INSERT INTO Allocation values ('V024','T2',DEFAULT, DEFAULT);
INSERT INTO Allocation values ('V025','T3', '2021-08-01', '2021-08-12');
INSERT INTO Allocation values ('V026','T4', DEFAULT, DEFAULT);
INSERT INTO Allocation values ('V027','T5', '2020-12-01', '2020-12-15');
INSERT INTO Allocation values ('V028','T6', '2021-09-01', '2021-10-06');
INSERT INTO Allocation values ('V029','T7', DEFAULT ,DEFAULT);
INSERT INTO Allocation values ('V030','T8', '2017-06-01', '2019-06-22');

ALTER TABLE Allocation
ALTER FromDate SET DEFAULT '1900-01-01';
ALTER TABLE Allocation
ALTER ToDate SET DEFAULT '1900-01-01';

-- SECTION 2 Insert into:
INSERT INTO Customer values ('C345', 'Hugh Jackman', '0415871256');
INSERT INTO Customer values ('C346', 'Zac Efron', '0415235256');
INSERT INTO Customer values ('C347', 'Michael Jordan', '0415825256');
INSERT INTO Customer values ('C348', 'Will Smith', '0415871815');
INSERT INTO Customer values ('C349', 'Margot Robbie', '0442571256');
INSERT INTO Customer values ('C350', 'Chris Hemsworth', '0415857956');
INSERT INTO Customer values ('C351', 'Charlie Hunnam', '0415828956');
INSERT INTO Customer values ('C352', 'Mark Ruffalo', '0415845956');

INSERT INTO BookingReq values ('R101', 'C345', '2020-11-25', 'Request for Removalist service');
INSERT INTO BookingReq values ('R102', 'C346', '2020-09-23', 'Request for Removalist service');
INSERT INTO BookingReq values ('R103', 'C347', '2020-04-22', 'Request for Removalist service');
INSERT INTO BookingReq values ('R104', 'C348', '2020-07-18', 'Request for Removalist service');
INSERT INTO BookingReq values ('R105', 'C349', '2020-11-15', 'Request for Removalist service');
INSERT INTO BookingReq values ('R106', 'C350', '2020-01-25', 'Request for Removalist service');
INSERT INTO BookingReq values ('R107', 'C351', '2020-04-29', 'Request for Removalist service');
INSERT INTO BookingReq values ('R108', 'C352', '2020-07-30', 'Request for Removalist service');

INSERT INTO Invoice values ('I35', 'R101', '2020-11-27', '3000');
INSERT INTO Invoice values ('I36', 'R102', '2020-08-23', '8000');
INSERT INTO Invoice values ('I37', 'R102', '2020-03-21', '9000');
INSERT INTO Invoice values ('I38', 'R104', '2020-05-17', '4000');
INSERT INTO Invoice values ('I39', 'R105', '2020-08-23', '6000');
INSERT INTO Invoice values ('I40', 'R106', '2020-12-30', '9500');


INSERT INTO Payment values ('P300', 'I35', '2020-11-30', '4000');
INSERT INTO Payment values ('P301', 'I36', '2020-08-24', '3000');
INSERT INTO Payment values ('P302', 'I37', '2020-09-23', '3000');
INSERT INTO Payment values ('P303', 'I38', '2020-10-19', '3000');
INSERT INTO Payment values ('P304', 'I39', '2020-11-26', '3000');
INSERT INTO Payment values ('P305', 'I40', '2021-01-01', '3000');


-- Section 3 INSERT INTO
INSERT INTO Staff values ('S1', 'Chris Hemsworth', null);
INSERT INTO Staff values ('S2', 'Luke Hemsworth', 'S1');
INSERT INTO Staff values ('S3', 'Taylor Swift', 'S1');
INSERT INTO Staff values ('S4', 'Morgan Freeman', 'S1');
INSERT INTO Staff values ('S5', 'Leonardo Dicaprio', null);
INSERT INTO Staff values ('S6', 'Tom Holland', 'S5');
INSERT INTO Staff values ('S7', 'Mark Ruffalo', 'S5');
INSERT INTO Staff values ('S8', 'Anthony Mackie', 'S5');

INSERT INTO Location values ('L10', 'Norwood', 'TAS', '7250');
INSERT INTO Location values ('L11', 'Oak Park', 'VIC', '3046');
INSERT INTO Location values ('L12', 'Broadmeadows', 'VIC', '3047');
INSERT INTO Location values ('L13', 'Forestville', 'NSW', '2087');
INSERT INTO Location values ('L14', 'Frenchs Forest', 'NSW', '2086');
INSERT INTO Location values ('L15', 'North Ryde', 'NSW', '2113');
INSERT INTO Location values ('L16', 'Killarney Heights', 'NSW', '2087');
INSERT INTO Location values ('L17', 'Coogee', 'NSW', '2034');
INSERT INTO Location values ('L18', 'Norwood', 'TAS', '7250');
INSERT INTO Location values ('L19', 'North Ryde', 'NSW', '2113');

INSERT INTO TripSchedule values ('S23', 'L11', 'L10', 'R101', 'V023', 'T1', 'S1', '2020-12-06 13-30-00', '2021-12-07 13-30-00');
INSERT INTO TripSchedule values ('S24', 'L12', 'L11', 'R102', 'V024', 'T2', 'S2', '2020-11-06 14-30-00', '2021-11-07 14-30-00');
INSERT INTO TripSchedule values ('S25', 'L13', 'L12', 'R103', 'V025', 'T3', 'S3', '2020-10-06 15-30-00', '2021-10-07 15-30-00');
INSERT INTO TripSchedule values ('S26', 'L14', 'L13', 'R104', 'V026', 'T4', 'S4', '2020-09-06 16-30-00', '2021-09-07 16-30-00');
INSERT INTO TripSchedule values ('S27', 'L15', 'L14', 'R105', 'V027', 'T5', 'S5', '2020-08-06 17-30-00', '2021-08-07 17-30-00');
INSERT INTO TripSchedule values ('S28', 'L16', 'L15', 'R106', 'V028', 'T6', 'S6', '2020-03-05 12-30-00', '2020-03-12 06-30-00');
INSERT INTO TripSchedule values ('S29', 'L17', 'L16', 'R107', 'V029', 'T7', 'S7', '2020-01-14 13-30-00', '2020-01-18 07-30-00');
INSERT INTO TripSchedule values ('S30', 'L18', 'L17', 'R108', 'V030', 'T8', 'S8', '2020-11-26 14-30-00', '2020-11-30 08-30-00');

INSERT INTO SupportStaff values ('S23', 'S2', '15');
INSERT INTO SupportStaff values ('S24', 'S3', '20');
INSERT INTO SupportStaff values ('S25', 'S4', '10');
INSERT INTO SupportStaff values ('S26', 'S5', '35');
INSERT INTO SupportStaff values ('S27', 'S6', '40');
INSERT INTO SupportStaff values ('S28', 'S7', '34');
INSERT INTO SupportStaff values ('S29', 'S8', '45');
INSERT INTO SupportStaff values ('S30', 'S9', '12');




-- Task 2 -- **
SELECT TruckVINNum, TruckColour, TruckCost
FROM Truck
ORDER BY TruckCost DESC;

-- Task 3 -- **
SELECT *, (ToDate - FromDate) AS Days_Reserved
FROM Allocation;

-- Task 4 -- **
SELECT TruckMakeName, TruckVINNum
FROM Truck t
JOIN TruckMake tm
ON t.TruckMakeID = tm.TruckMakeID
WHERE TruckMakeName = 'Volvo';

-- Task 5 -- **
SELECT TruckVINNum
FROM Truck t
INNER JOIN Allocation a
USING (TruckVINNum)
WHERE TruckCost BETWEEN '$1500' AND '$2500'
AND (ToDate - FromDate) >= 3;

-- Task 6 -- **
SELECT TransportName, TransportCost, TransportMaxDist
FROM Service
	WHERE TransportID IN (
	SELECT (TransportID)
    FROM Allocation
    WHERE FromDate BETWEEN current_date() - INTERVAL 6 MONTH AND current_date()); -- calculated as eg. BETWEEN CurrentDate((2021-10-16) - 6 months) AND CurrentDate;
    
-- Task 7 -- **
SELECT s.TransportName, s.TransportCost, s.TransportMaxDist
FROM Service s
INNER JOIN Allocation a
ON a.TransportID = s.TransportID
WHERE FromDate BETWEEN current_date() - INTERVAL 6 MONTH AND current_date();

-- Task 8 -- **
SELECT TransportName, TransportMaxDist AS 'Kilometres', ROUND(TransportMaxDist / 1.6103, 2) AS 'Miles'
FROM Service s
INNER JOIN Allocation a
ON s.TransportID=a.TransportID
INNER JOIN Truck t
ON a.TruckVINNum=t.TruckVINNum
WHERE TruckColour = 'Red';

-- Task 9 -- **
SELECT count(TruckVINNum) AS NumOfTrucks, TruckColour
FROM Truck
GROUP BY TruckColour
ORDER BY count(TruckVINNum) DESC;

-- Task 10 -- **
SELECT  TruckMakeName, count(TruckModelID) AS NumOfModels
FROM  TruckModel, TruckMake
group by TruckMakeName
HAVING count(TruckModelID) > 1;


-- Task 11 -- **
SELECT *
FROM Truck t
JOIN Allocation a
ON a.TruckVINNum = t.TruckVINNum
WHERE FromDate = '1900-01-01' -- assumption: DEFAULT date value represents no booking
AND ToDate = '1900-01-01';

-- Task 12 -- **
SELECT *
FROM Service s
INNER JOIN Allocation a
ON s.TransportID = a.TransportID
WHERE MONTH(FromDate) AND MONTH(ToDate) = 1
OR YEAR(FromDate) AND YEAR(ToDate) = 2020
OR YEAR(FromDate) AND YEAR(ToDate) = 2021
AND TransportCost > '$5000'
ORDER BY TransportCost DESC;
-- assumption: return everything from Service table WHERE cost is more than $5000 AND
-- BOTH todate and fromdate are either in the month of January OR any month of 2020 OR any month of 2021

-- Task 13 -- *****
SELECT tm.TruckMakeName, tmo.TruckModelName
FROM Truck t
INNER JOIN TruckMake tm
ON t.TruckMakeID = tm.TruckMakeID
INNER JOIN TruckModel tmo
ON t.TruckModelID = tmo.TruckModelID
INNER JOIN Allocation a
ON t.TruckVINNum = a.TruckVINNum
WHERE TruckColour = 'Red'
AND FromDate IS NOT NULL
AND ToDate IS NOT NULL;


-- SECTION 2
-- Task 14
SELECT b.RequestID, b.CustomerID, b.RequestDate, b.RequestText , CONCAT('$', InvoiceAmount + InvoiceAmount * 0.10) AS InvoiceAmountwTax
FROM BookingReq b
JOIN Invoice i
ON b.RequestID = i.RequestID
WHERE (InvoiceAmount + InvoiceAmount * 0.10) > 7000;

-- Task 15 !incomplete!

SELECT c.CustomerName
FROM Customer c
INNER JOIN BookingReq b
ON c.CustomerID=b.CustomerID
INNER JOIN Invoice i
ON b.RequestID=i.RequestID
	WHERE InvoiceNum IN(
    SELECT InvoiceID iid
    FROM Payment p
    WHERE p.PaymentAmount < 3166 -- average amount of all columns
    AND QUARTER(PaymentDate) = 4
    );

-- SECTION 3
-- Task 16 
	SELECT ManagerID, Count(ManagerID) AS 'Manages'
    FROM Staff s
    WHERE ManagerID IS NOT NULL
    GROUP BY ManagerID
    HAVING COUNT(ManagerID) >= 2


-- Task 17 assumption staff = manager
SELECT c.CustomerName, ss.StaffName, TripStart, TripEnd
FROM Customer c
JOIN BookingReq b
ON c.CustomerID=b.CustomerID
JOIN TripSchedule t
ON b.RequestID=t.RequestID
JOIN SupportStaff s
ON t.ScheduleID=s.ScheduleID
JOIN Staff ss
ON s.StaffID=ss.StaffID
WHERE HOUR(TripStart) BETWEEN '12:00:00' AND '15:00:00'
AND HOUR(TripEnd) BETWEEN '06:00:00' AND '12:00:00';

-- SECTION 4
-- Task 18
SELECT LocationName, StaffName, TransportName
FROM TripSchedule t
JOIN Staff s
ON t.StaffID=s.StaffID
JOIN Service ss
ON t.TransportID=ss.TransportID
JOIN Location l
ON t.StartLoc=l.LocationID;

-- Task 19
SELECT LocationID, StartLoc, LocationName, EndLoc, LocationName
FROM TripSchedule t
LEFT JOIN Location l
ON t.StartLoc=l.LocationID;

-- Task 20
SELECT ScheduleID, SUM(InvoiceAmount + PaymentAmount) AS 'Total Cost'
FROM TripSchedule ts
JOIN Invoice i
ON ts.RequestID=i.RequestID
JOIN Payment p
ON i.InvoiceNum=p.InvoiceID
GROUP BY ScheduleID















