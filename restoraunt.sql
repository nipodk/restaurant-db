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
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

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
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customer` (
  `customerId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customerId`))
ENGINE = InnoDB;


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
  CONSTRAINT `fk_Bookings_Employee1`
    FOREIGN KEY (`employeeId`)
    REFERENCES `LittleLemonDB`.`Employee` (`employeeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bookings_Customer1`
    FOREIGN KEY (`customerId`)
    REFERENCES `LittleLemonDB`.`Customer` (`customerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `dishId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `cusineType` VARCHAR(45) NOT NULL,
  `foodType` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`dishId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`DeliveryStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`DeliveryStatus` (
  `deliveryStatusId` INT NOT NULL,
  `date` DATE NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`deliveryStatusId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `orderId` INT NOT NULL,
  `totalAmount` DECIMAL(10,2) NOT NULL,
  `paid` VARCHAR(45) NOT NULL,
  `paymenyMethod` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  `customerId` INT NOT NULL,
  `dishId` INT NOT NULL,
  `deliveryStatusId` INT NOT NULL,
  `employeeId` INT NOT NULL,
  PRIMARY KEY (`orderId`),
  INDEX `fk_Orders_Customer_idx` (`customerId` ASC) VISIBLE,
  INDEX `fk_Orders_Menu1_idx` (`dishId` ASC) VISIBLE,
  INDEX `fk_Orders_DeliveryStatus1_idx` (`deliveryStatusId` ASC) VISIBLE,
  INDEX `fk_Orders_Employee1_idx` (`employeeId` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Customer`
    FOREIGN KEY (`customerId`)
    REFERENCES `LittleLemonDB`.`Customer` (`customerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Menu1`
    FOREIGN KEY (`dishId`)
    REFERENCES `LittleLemonDB`.`Menu` (`dishId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_DeliveryStatus1`
    FOREIGN KEY (`deliveryStatusId`)
    REFERENCES `LittleLemonDB`.`DeliveryStatus` (`deliveryStatusId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Employee1`
    FOREIGN KEY (`employeeId`)
    REFERENCES `LittleLemonDB`.`Employee` (`employeeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
