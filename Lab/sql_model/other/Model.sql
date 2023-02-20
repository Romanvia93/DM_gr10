-- MySQL Script generated by MySQL Workbench
-- Wed Feb 15 16:52:03 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dm_course
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dm_course
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dm_course` DEFAULT CHARACTER SET utf8 ;
USE `dm_course` ;

-- -----------------------------------------------------
-- Table `dm_course`.`segment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dm_course`.`segment` (
  `Segment` VARCHAR(50) NOT NULL,
  `segment_id` INT NOT NULL,
  PRIMARY KEY (`segment_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dm_course`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dm_course`.`city` (
  `city` VARCHAR(100) NOT NULL,
  `Country_Region` VARCHAR(100) NOT NULL,
  `State` VARCHAR(100) NOT NULL,
  `Region` VARCHAR(100) NULL,
  `city_id` INT NOT NULL,
  UNIQUE INDEX `State_UNIQUE` (`State` ASC) VISIBLE,
  PRIMARY KEY (`city_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dm_course`.`adress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dm_course`.`adress` (
  `Postal Code` INT NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`Postal Code`),
  INDEX `city_id_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `city_id`
    FOREIGN KEY (`city_id`)
    REFERENCES `dm_course`.`city` (`city_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dm_course`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dm_course`.`customer` (
  `Customer ID` VARCHAR(45) NOT NULL,
  `Customer Name` VARCHAR(45) NOT NULL,
  `segment_id` INT NOT NULL,
  `Postal Code` INT NOT NULL,
  PRIMARY KEY (`Customer ID`),
  INDEX `segment_id_idx` (`segment_id` ASC) VISIBLE,
  INDEX `Postal Code_idx` (`Postal Code` ASC) VISIBLE,
  CONSTRAINT `segment_id`
    FOREIGN KEY (`segment_id`)
    REFERENCES `dm_course`.`segment` (`segment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Postal Code`
    FOREIGN KEY (`Postal Code`)
    REFERENCES `dm_course`.`adress` (`Postal Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dm_course`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dm_course`.`order` (
  `Order ID` VARCHAR(45) NOT NULL,
  `Order Date` DATE NULL,
  `Ship Date` DATE NULL,
  `Ship Mode` VARCHAR(45) NULL,
  `Customer ID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Order ID`),
  INDEX `Customer ID_idx` (`Customer ID` ASC) VISIBLE,
  CONSTRAINT `Customer ID`
    FOREIGN KEY (`Customer ID`)
    REFERENCES `dm_course`.`customer` (`Customer ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dm_course`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dm_course`.`category` (
  `Category` VARCHAR(45) NOT NULL,
  `Sub_Category` VARCHAR(45) NOT NULL,
  `Sub_Category_id` INT NOT NULL,
  PRIMARY KEY (`Sub_Category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dm_course`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dm_course`.`product` (
  `Product ID` VARCHAR(45) NOT NULL,
  `Product Name` VARCHAR(45) NOT NULL,
  `sub_category_id` INT NOT NULL,
  PRIMARY KEY (`Product ID`),
  INDEX `sub_category_id_idx` (`sub_category_id` ASC) VISIBLE,
  CONSTRAINT `sub_category_id`
    FOREIGN KEY (`sub_category_id`)
    REFERENCES `dm_course`.`category` (`Sub_Category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dm_course`.`product_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dm_course`.`product_order` (
  `Order ID` VARCHAR(45) NOT NULL,
  `Product ID` VARCHAR(45) NOT NULL,
  `Sales` FLOAT NOT NULL,
  `Quantity` INT NOT NULL,
  `Discount` FLOAT NOT NULL,
  `Profit` FLOAT NULL,
  `product_order_id` INT NOT NULL,
  PRIMARY KEY (`product_order_id`),
  INDEX `Order ID_idx` (`Order ID` ASC) VISIBLE,
  INDEX `Product ID_idx` (`Product ID` ASC) VISIBLE,
  CONSTRAINT `Order ID`
    FOREIGN KEY (`Order ID`)
    REFERENCES `dm_course`.`order` (`Order ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Product ID`
    FOREIGN KEY (`Product ID`)
    REFERENCES `dm_course`.`product` (`Product ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
