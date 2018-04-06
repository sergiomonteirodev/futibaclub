SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `futibaclub` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `futibaclub` ;

-- -----------------------------------------------------
-- Table `futibaclub`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futibaclub`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(245) NULL,
  `email` VARCHAR(245) NULL,
  `passwd` VARCHAR(245) NULL,
  `role` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futibaclub`.`groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futibaclub`.`groups` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(245) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futibaclub`.`groups_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futibaclub`.`groups_users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `group_id` INT NOT NULL,
  `role` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_groups_users_users_idx` (`user_id` ASC),
  INDEX `fk_groups_users_groups1_idx` (`group_id` ASC),
  CONSTRAINT `fk_groups_users_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `futibaclub`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_groups_users_groups1`
    FOREIGN KEY (`group_id`)
    REFERENCES `futibaclub`.`groups` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futibaclub`.`games`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futibaclub`.`games` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `team_a` VARCHAR(425) NULL,
  `team_b` VARCHAR(245) NULL,
  `result_a` INT NULL,
  `result_b` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futibaclub`.`guessings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futibaclub`.`guessings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `result_a` INT NULL,
  `result_b` INT NULL,
  `score` INT NULL,
  `game_id` INT NOT NULL,
  `group_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_guessings_games1_idx` (`game_id` ASC),
  INDEX `fk_guessings_groups1_idx` (`group_id` ASC),
  INDEX `fk_guessings_users1_idx` (`user_id` ASC),
  CONSTRAINT `fk_guessings_games1`
    FOREIGN KEY (`game_id`)
    REFERENCES `futibaclub`.`games` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_guessings_groups1`
    FOREIGN KEY (`group_id`)
    REFERENCES `futibaclub`.`groups` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_guessings_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `futibaclub`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futibaclub`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futibaclub`.`comments` (
  `id` INT NOT NULL,
  `comment` TEXT NULL,
  `guessing_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comments_guessings1_idx` (`guessing_id` ASC),
  INDEX `fk_comments_users1_idx` (`user_id` ASC),
  CONSTRAINT `fk_comments_guessings1`
    FOREIGN KEY (`guessing_id`)
    REFERENCES `futibaclub`.`guessings` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comments_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `futibaclub`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
