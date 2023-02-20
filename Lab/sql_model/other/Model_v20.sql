-- MySQL Script generated by MySQL Workbench
-- Sun Feb 19 17:28:36 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dm_course_v20
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dm_course_v20
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dm_course_v20` DEFAULT CHARACTER SET utf8 ;
USE `dm_course_v20` ;

-- -----------------------------------------------------
-- Table `dm_course_v20`.`Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dm_course_v20`.`Country` (
  `Country_ID` INT NOT NULL,
  `Country` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`Country_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dm_course_v20`.`Region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dm_course_v20`.`Region` (
  `Region_ID` INT NOT NULL,
  `Region_name` VARCHAR(200) NOT NULL,
  `Country_ID` INT NOT NULL,
  PRIMARY KEY (`Region_ID`),
  INDEX `Country_ID_idx` (`Country_ID` ASC) VISIBLE,
  CONSTRAINT `Country_ID`
    FOREIGN KEY (`Country_ID`)
    REFERENCES `dm_course_v20`.`Country` (`Country_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dm_course_v20`.`State`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dm_course_v20`.`State` (
  `State_ID` INT NOT NULL,
  `State` VARCHAR(200) NOT NULL,
  `Region_ID` INT NOT NULL,
  PRIMARY KEY (`State_ID`),
  INDEX `Region_ID_idx` (`Region_ID` ASC) VISIBLE,
  CONSTRAINT `Region_ID`
    FOREIGN KEY (`Region_ID`)
    REFERENCES `dm_course_v20`.`Region` (`Region_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dm_course_v20`.`City`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dm_course_v20`.`City` (
  `City_ID` INT NOT NULL,
  `City` VARCHAR(200) NOT NULL,
  `State_ID` INT NOT NULL,
  PRIMARY KEY (`City_ID`),
  INDEX `State_ID_idx` (`State_ID` ASC) VISIBLE,
  CONSTRAINT `State_ID`
    FOREIGN KEY (`State_ID`)
    REFERENCES `dm_course_v20`.`State` (`State_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dm_course_v20`.`Postal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dm_course_v20`.`Postal` (
  `Postal_Code` INT NOT NULL,
  `City_ID` INT NOT NULL,
  PRIMARY KEY (`Postal_Code`),
  INDEX `City_ID_idx` (`City_ID` ASC) VISIBLE,
  CONSTRAINT `City_ID0`
    FOREIGN KEY (`City_ID`)
    REFERENCES `dm_course_v20`.`City` (`City_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dm_course_v20`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dm_course_v20`.`Customer` (
  `Customer_ID` VARCHAR(200) NOT NULL,
  `Customer_Name` VARCHAR(200) NOT NULL,
  `Segment` VARCHAR(200) NULL,
  PRIMARY KEY (`Customer_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dm_course_v20`.`Customer_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dm_course_v20`.`Customer_address` (
  `Customer_ID` VARCHAR(200) NOT NULL,
  `Postal_Code` INT NOT NULL,
  `Customer_address_ID` INT NOT NULL,
  INDEX `Customer_ID_idx` (`Customer_ID` ASC) VISIBLE,
  INDEX `Postal_Code_idx` (`Postal_Code` ASC) VISIBLE,
  PRIMARY KEY (`Customer_address_ID`),
  CONSTRAINT `Customer_ID`
    FOREIGN KEY (`Customer_ID`)
    REFERENCES `dm_course_v20`.`Customer` (`Customer_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Postal_Code`
    FOREIGN KEY (`Postal_Code`)
    REFERENCES `dm_course_v20`.`Postal` (`Postal_Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dm_course_v20`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dm_course_v20`.`Order` (
  `Order_ID` VARCHAR(200) NOT NULL,
  `Order_Date` DATE NULL,
  `Ship_Date` DATE NULL,
  `Ship_Mode` VARCHAR(45) NULL,
  `Customer_address_ID` INT NULL,
  PRIMARY KEY (`Order_ID`),
  INDEX `Customer_address_ID_idx` (`Customer_address_ID` ASC) VISIBLE,
  CONSTRAINT `Customer_address_ID`
    FOREIGN KEY (`Customer_address_ID`)
    REFERENCES `dm_course_v20`.`Customer_address` (`Customer_address_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dm_course_v20`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dm_course_v20`.`Category` (
  `Category_ID` INT NOT NULL,
  `Category_Name` VARCHAR(200) NULL,
  PRIMARY KEY (`Category_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dm_course_v20`.`SubCategory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dm_course_v20`.`SubCategory` (
  `SubCategory_ID` INT NOT NULL,
  `SubCategory_Name` VARCHAR(45) NULL,
  `Caterogy_ID` INT NULL,
  PRIMARY KEY (`SubCategory_ID`),
  INDEX `Category_ID_idx` (`Caterogy_ID` ASC) VISIBLE,
  CONSTRAINT `Category_ID`
    FOREIGN KEY (`Caterogy_ID`)
    REFERENCES `dm_course_v20`.`Category` (`Category_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dm_course_v20`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dm_course_v20`.`Product` (
  `Product_ID` VARCHAR(200) NOT NULL,
  `Product_Name` VARCHAR(45) NULL,
  `SubCategory_ID` INT NULL,
  PRIMARY KEY (`Product_ID`),
  INDEX `SubCategory_ID_idx` (`SubCategory_ID` ASC) VISIBLE,
  CONSTRAINT `SubCategory_ID`
    FOREIGN KEY (`SubCategory_ID`)
    REFERENCES `dm_course_v20`.`SubCategory` (`SubCategory_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dm_course_v20`.`Order_Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dm_course_v20`.`Order_Product` (
  `Order_ID` VARCHAR(200) NOT NULL,
  `Product_ID` VARCHAR(200) NULL,
  `Sales` FLOAT NULL,
  `Quantity` INT NULL,
  `Profit` FLOAT NULL,
  `Discount` FLOAT NULL,
  INDEX `Product_ID_idx` (`Product_ID` ASC) VISIBLE,
  CONSTRAINT `Order_ID`
    FOREIGN KEY (`Order_ID`)
    REFERENCES `dm_course_v20`.`Order` (`Order_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Product_ID`
    FOREIGN KEY (`Product_ID`)
    REFERENCES `dm_course_v20`.`Product` (`Product_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
