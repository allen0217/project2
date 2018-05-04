CREATE TABLE `airplane` (
  `Airplane_id` varchar(15) NOT NULL,
  `Total_number_of_seats` int(11) DEFAULT NULL,
  `Airplane_type` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Airplane_id`),
  KEY `Airplane_type_idx` (`Airplane_type`),
  CONSTRAINT `Airplane_type` FOREIGN KEY (`Airplane_type`) REFERENCES `airplane_type` (`Airplane_type_name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `airplane_type` (
  `Airplane_type_name` varchar(15) NOT NULL,
  `Max_seats` int(11) DEFAULT NULL,
  `Company` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Airplane_type_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `airport` (
  `Airport_code` varchar(15) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `City` varchar(30) DEFAULT NULL,
  `State` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`Airport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `can_land` (
  `Airplane_type_name` varchar(15) NOT NULL,
  `Airport_code` varchar(15) NOT NULL,
  PRIMARY KEY (`Airport_code`,`Airplane_type_name`),
  KEY `Airplane_type_name` (`Airplane_type_name`),
  CONSTRAINT `airport_code` FOREIGN KEY (`Airport_code`) REFERENCES `airport` (`Airport_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `can_land_ibfk_1` FOREIGN KEY (`Airplane_type_name`) REFERENCES `airplane_type` (`Airplane_type_name`),
  CONSTRAINT `can_land_ibfk_2` FOREIGN KEY (`Airport_code`) REFERENCES `airport` (`Airport_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `fare` (
  `Flight_number` int(11) NOT NULL,
  `Fare_Code` varchar(15) NOT NULL,
  `Amount` int(11) DEFAULT NULL,
  `Restrictions` varchar(15) NOT NULL,
  PRIMARY KEY (`Fare_Code`,`Restrictions`,`Flight_number`),
  KEY `Flight_number` (`Flight_number`),
  CONSTRAINT `fare_ibfk_1` FOREIGN KEY (`Flight_number`) REFERENCES `flight` (`Flight_number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `flight` (
  `Flight_number` int(11) NOT NULL,
  `Airline` varchar(30) DEFAULT NULL,
  `Weekdays` varchar(50) DEFAULT NULL,
  `Departure_airport_code` varchar(15) NOT NULL,
  `Scheduled_departure_time` time DEFAULT NULL,
  `Arrival_airport_code` varchar(15) NOT NULL,
  `Scheduled_arrival_time` time DEFAULT NULL,
  `Timecost` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Flight_number`),
  KEY `fl1_idx` (`Departure_airport_code`),
  KEY `fl2_idx` (`Arrival_airport_code`),
  CONSTRAINT `fl1` FOREIGN KEY (`Departure_airport_code`) REFERENCES `airport` (`Airport_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fl2` FOREIGN KEY (`Arrival_airport_code`) REFERENCES `airport` (`Airport_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `flight_instance` (
  `Flight_number` int(11) NOT NULL,
  `Date` varchar(15) NOT NULL,
  `Airplane_id` varchar(15) DEFAULT NULL,
  `Departure_time` time DEFAULT NULL,
  `Arrival_time` time DEFAULT NULL,
  PRIMARY KEY (`Flight_number`,`Date`),
  KEY `fk2_idx` (`Airplane_id`),
  CONSTRAINT `fk1` FOREIGN KEY (`Flight_number`) REFERENCES `flight` (`Flight_number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk2` FOREIGN KEY (`Airplane_id`) REFERENCES `airplane` (`Airplane_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `seat_reservation` (
  `Flight_number` int(11) NOT NULL,
  `Date` varchar(15) NOT NULL,
  `Seat_number` varchar(15) NOT NULL,
  `Customer_name` varchar(40) DEFAULT NULL,
  `Customer_phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Seat_number`,`Date`,`Flight_number`),
  KEY `seat_reservation_ibfk_1_idx` (`Flight_number`,`Date`),
  CONSTRAINT `seat_reservation_ibfk_1` FOREIGN KEY (`Flight_number`, `Date`) REFERENCES `flight_instance` (`Flight_number`, `Date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

