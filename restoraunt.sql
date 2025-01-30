-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8mb3 ;
-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customer` (
  `customerId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `phone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customerId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Employee` (
  `employeeId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  `salary` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`employeeId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `bookingsId` INT NOT NULL,
  `table` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  `numberOfGuests` INT NOT NULL,
  `employeeId` INT NOT NULL,
  `customerId` INT NOT NULL,
  PRIMARY KEY (`bookingsId`),
  INDEX `fk_Bookings_Employee1_idx` (`employeeId` ASC) VISIBLE,
  INDEX `fk_Bookings_Customer1_idx` (`customerId` ASC) VISIBLE,
  CONSTRAINT `fk_Bookings_Customer1`
    FOREIGN KEY (`customerId`)
    REFERENCES `LittleLemonDB`.`Customer` (`customerId`),
  CONSTRAINT `fk_Bookings_Employee1`
    FOREIGN KEY (`employeeId`)
    REFERENCES `LittleLemonDB`.`Employee` (`employeeId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`DeliveryStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`DeliveryStatus` (
  `deliveryStatusId` INT NOT NULL,
  `date` DATE NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`deliveryStatusId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `MenuItemsId` INT NOT NULL,
  `CourseName` VARCHAR(45) NULL DEFAULT NULL,
  `StarterName` VARCHAR(45) NULL DEFAULT NULL,
  `DesertName` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`MenuItemsId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menus` (
  `menuId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `cusineType` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`menuId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`ItemsInMenu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`ItemsInMenu` (
  `Menus_menuId` INT NOT NULL,
  `MenuItems_MenuItemsId` INT NOT NULL,
  PRIMARY KEY (`Menus_menuId`, `MenuItems_MenuItemsId`),
  INDEX `fk_Menus_has_MenuItems_MenuItems1_idx` (`MenuItems_MenuItemsId` ASC) VISIBLE,
  INDEX `fk_Menus_has_MenuItems_Menus1_idx` (`Menus_menuId` ASC) VISIBLE,
  CONSTRAINT `fk_Menus_has_MenuItems_MenuItems1`
    FOREIGN KEY (`MenuItems_MenuItemsId`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`MenuItemsId`),
  CONSTRAINT `fk_Menus_has_MenuItems_Menus1`
    FOREIGN KEY (`Menus_menuId`)
    REFERENCES `LittleLemonDB`.`Menus` (`menuId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `orderId` INT NOT NULL,
  `totalAmount` DECIMAL(10,2) NOT NULL,
  `paid` VARCHAR(45) NOT NULL,
  `paymenyMethod` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  `quantity` VARCHAR(45) NOT NULL,
  `customerId` INT NOT NULL,
  `deliveryStatusId` INT NOT NULL,
  `employeeId` INT NOT NULL,
  `menuId` INT NOT NULL,
  PRIMARY KEY (`orderId`),
  INDEX `fk_Orders_Customer_idx` (`customerId` ASC) VISIBLE,
  INDEX `fk_Orders_DeliveryStatus1_idx` (`deliveryStatusId` ASC) VISIBLE,
  INDEX `fk_Orders_Employee1_idx` (`employeeId` ASC) VISIBLE,
  INDEX `fk_Orders_Menus1_idx` (`menuId` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Customer`
    FOREIGN KEY (`customerId`)
    REFERENCES `LittleLemonDB`.`Customer` (`customerId`),
  CONSTRAINT `fk_Orders_DeliveryStatus1`
    FOREIGN KEY (`deliveryStatusId`)
    REFERENCES `LittleLemonDB`.`DeliveryStatus` (`deliveryStatusId`),
  CONSTRAINT `fk_Orders_Employee1`
    FOREIGN KEY (`employeeId`)
    REFERENCES `LittleLemonDB`.`Employee` (`employeeId`),
  CONSTRAINT `fk_Orders_Menus1`
    FOREIGN KEY (`menuId`)
    REFERENCES `LittleLemonDB`.`Menus` (`menuId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- procedure AddBooking
-- -----------------------------------------------------

DELIMITER $$
USE `LittleLemonDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddBooking`(
in bookingsId int, in customerId int,
in bookingDate date, in table_number varchar(45)
)
begin 
start transaction;
insert into Bookings values (bookingsId, table_number, bookingDate, 2, 1, customerId);
select concat("The booking : ",bookingsId, " was added :)");
commit;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddValidBooking
-- -----------------------------------------------------

DELIMITER $$
USE `LittleLemonDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddValidBooking`(
    IN booking_date DATE, 
    IN table_number VARCHAR(45), 
    IN numberOfGuests INT,
    IN employeeId INT, 
    IN customerId INT
)
BEGIN 
    DECLARE id_number INT;
    DECLARE number_of_guest INT;
    
    SELECT COUNT(bookingsId) + 1 INTO  id_number
    FROM Bookings;
    
    select numberOfGuests into number_of_guest from Bookings where `table` = table_number AND date = booking_date;
    
    START TRANSACTION;

    IF number_of_guest > 0 THEN 
        SELECT CONCAT("The table ", table_number, " is already booked on ", booking_date) AS BookingStatus;
        ROLLBACK;
    ELSE 

        INSERT INTO Bookings (bookingsId, `table`, date, numberOfGuests, employeeId, customerId) 
        VALUES (id_number, table_number, booking_date, numberOfGuests, employeeId, customerId);

        COMMIT;
        
        SELECT CONCAT("Booking added for table ", table_number, " on ", booking_date) AS BookingStatus;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CancelBooking
-- -----------------------------------------------------

DELIMITER $$
USE `LittleLemonDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CancelBooking`(in booking_id int)
begin
declare booking_exist int;

select count(*) into booking_exist from Bookings where booking_id = bookingsId;

start transaction;

if booking_exist > 0 
then delete from Bookings where booking_id = bookingsId;
select concat("The booking: ", booking_id, " is deleted :)");
commit;

else
select concat("The booking: ", booking_id, " doesn't exist");
rollback;

end if;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CancelOrder
-- -----------------------------------------------------

DELIMITER $$
USE `LittleLemonDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CancelOrder`(in orderId int)
begin
select concat("Order ", orderId, " is cancelled");
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CheckBooking
-- -----------------------------------------------------

DELIMITER $$
USE `LittleLemonDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckBooking`(in booking_date date, in table_nubmer varchar(45))
begin
select if (numberOfGuests > 0, 
concat("Table ", table_nubmer, " is booked"), 
concat("Table ", `table`, " is free to book")) as Booking_status
from Bookings where `table` = table_nubmer and date = booking_date;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GetMaxQuantity
-- -----------------------------------------------------

DELIMITER $$
USE `LittleLemonDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMaxQuantity`()
BEGIN
    SELECT MAX(quantity)  FROM Orders;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UpdateBooking
-- -----------------------------------------------------

DELIMITER $$
USE `LittleLemonDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateBooking`(in booking_id int, in booking_date date)
begin
update Bookings set date = booking_date where bookingsId = booking_id;
select concat("The booking's: ", booking_id, " time is updated");
end$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
