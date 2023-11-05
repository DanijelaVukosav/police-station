-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Policija
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Policija
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Policija` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `Policija` ;

-- -----------------------------------------------------
-- Table `Policija`.`Uprava`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`Uprava` (
  `idUprava` VARCHAR(10) NOT NULL,
  `NazivUprave` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUprava`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`Adresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`Adresa` (
  `idAdrese` INT NOT NULL AUTO_INCREMENT,
  `Ulica` VARCHAR(45) NOT NULL,
  `Mjesto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAdrese`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`OrganizacionaJedinica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`OrganizacionaJedinica` (
  `idOrganizacionaJedinica` INT NOT NULL,
  `idUprava` VARCHAR(10) NOT NULL,
  `idAdrese` INT NOT NULL,
  PRIMARY KEY (`idOrganizacionaJedinica`),
  INDEX `fk_OrganizacionaJedinica_Uprava1_idx` (`idUprava` ASC) VISIBLE,
  INDEX `fk_OrganizacionaJedinica_Adresa1_idx` (`idAdrese` ASC) VISIBLE,
  CONSTRAINT `fk_OrganizacionaJedinica_Uprava1`
    FOREIGN KEY (`idUprava`)
    REFERENCES `Policija`.`Uprava` (`idUprava`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrganizacionaJedinica_Adresa1`
    FOREIGN KEY (`idAdrese`)
    REFERENCES `Policija`.`Adresa` (`idAdrese`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`Kamera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`Kamera` (
  `idKamere` INT NOT NULL,
  `Tip` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idKamere`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`RadarskaKontrola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`RadarskaKontrola` (
  `idRadarskaKontrola` INT NOT NULL AUTO_INCREMENT,
  `idKamere` INT NOT NULL,
  `Datum` DATE NOT NULL,
  `idAdrese` INT NOT NULL,
  PRIMARY KEY (`idRadarskaKontrola`),
  INDEX `fk_RadarskaKontrola_Kamera1_idx` (`idKamere` ASC) VISIBLE,
  INDEX `fk_RadarskaKontrola_Adresa1_idx` (`idAdrese` ASC) VISIBLE,
  CONSTRAINT `fk_RadarskaKontrola_Kamera1`
    FOREIGN KEY (`idKamere`)
    REFERENCES `Policija`.`Kamera` (`idKamere`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RadarskaKontrola_Adresa1`
    FOREIGN KEY (`idAdrese`)
    REFERENCES `Policija`.`Adresa` (`idAdrese`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`Osoba`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`Osoba` (
  `JMB` DECIMAL(13) NOT NULL,
  `Ime` VARCHAR(25) NOT NULL,
  `Prezime` VARCHAR(25) NOT NULL,
  `idAdrese` INT NOT NULL,
  PRIMARY KEY (`JMB`),
  INDEX `fk_Osoba_Adresa1_idx` (`idAdrese` ASC) VISIBLE,
  CONSTRAINT `fk_Osoba_Adresa1`
    FOREIGN KEY (`idAdrese`)
    REFERENCES `Policija`.`Adresa` (`idAdrese`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`PrevoznoSredstvo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`PrevoznoSredstvo` (
  `idPrevoznoSredstvo` INT NOT NULL,
  `VrstaPrevoznogSredstva` VARCHAR(45) NOT NULL,
  `Opis` VARCHAR(200) NULL,
  `idUprava` VARCHAR(10) NOT NULL,
  `idOrganizacionaJedinica` INT NOT NULL,
  PRIMARY KEY (`idPrevoznoSredstvo`),
  INDEX `fk_PrevoznoSredstvo_OrganizacionaJedinica1_idx` (`idUprava` ASC, `idOrganizacionaJedinica` ASC) VISIBLE,
  CONSTRAINT `fk_PrevoznoSredstvo_OrganizacionaJedinica1`
    FOREIGN KEY (`idUprava` , `idOrganizacionaJedinica`)
    REFERENCES `Policija`.`OrganizacionaJedinica` (`idUprava` , `idOrganizacionaJedinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`RegistracijaVozila`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`RegistracijaVozila` (
  `idSaobracajneDozvole` INT NOT NULL AUTO_INCREMENT,
  `RegistracijskeTablice` VARCHAR(9) NOT NULL,
  `TipVozila` VARCHAR(45) NOT NULL,
  `DatumRegistracije` DATE NOT NULL,
  `RokIstekaRegistracije` DATE NOT NULL,
  `BojaVozila` VARCHAR(15) NULL,
  `JMB` DECIMAL(13) NULL,
  `idPrevoznoSredstvo` INT NULL,
  PRIMARY KEY (`idSaobracajneDozvole`),
  INDEX `fk_RegistracijaVozila_Osoba1_idx` (`JMB` ASC) VISIBLE,
  INDEX `fk_RegistracijaVozila_PrevoznoSredstvo1_idx` (`idPrevoznoSredstvo` ASC) VISIBLE,
  CONSTRAINT `fk_RegistracijaVozila_Osoba1`
    FOREIGN KEY (`JMB`)
    REFERENCES `Policija`.`Osoba` (`JMB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RegistracijaVozila_PrevoznoSredstvo1`
    FOREIGN KEY (`idPrevoznoSredstvo`)
    REFERENCES `Policija`.`PrevoznoSredstvo` (`idPrevoznoSredstvo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`RadarskaKazna`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`RadarskaKazna` (
  `idRadarskaKazna` INT NOT NULL AUTO_INCREMENT,
  `idRadarskaKontrola` INT NOT NULL,
  `Vrijeme` TIME NOT NULL,
  `NovcanaKazna` DOUBLE NOT NULL,
  `PrekoracenjeBrzine` INT NOT NULL,
  `registracijskeTablice` VARCHAR(9) NOT NULL,
  `idSaobracajneDozvole` INT NOT NULL,
  PRIMARY KEY (`idRadarskaKazna`),
  INDEX `fk_RadarskaKazna_RadarskaKontrola1_idx` (`idRadarskaKontrola` ASC) VISIBLE,
  INDEX `fk_RadarskaKazna_RegistracijaVozila1_idx` (`idSaobracajneDozvole` ASC) VISIBLE,
  CONSTRAINT `fk_RadarskaKazna_RadarskaKontrola1`
    FOREIGN KEY (`idRadarskaKontrola`)
    REFERENCES `Policija`.`RadarskaKontrola` (`idRadarskaKontrola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RadarskaKazna_RegistracijaVozila1`
    FOREIGN KEY (`idSaobracajneDozvole`)
    REFERENCES `Policija`.`RegistracijaVozila` (`idSaobracajneDozvole`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`Zakon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`Zakon` (
  `tackaZakona` INT NOT NULL,
  `nazivTackeZakona` VARCHAR(100) NOT NULL,
  `opisTackeZakona` VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`tackaZakona`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`Policajac`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`Policajac` (
  `JMB` DECIMAL(13) NOT NULL,
  `idOrganizacionaJedinica` INT NOT NULL,
  `idUprava` VARCHAR(10) NOT NULL,
  `Cin` VARCHAR(45) NOT NULL,
  `Plata` DOUBLE NOT NULL,
  `JMBsefa` DECIMAL(13) NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL DEFAULT 'sigurnost',
  `RadniOdnos` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`JMB`),
  INDEX `fk_Policajac_Osoba1_idx` (`JMB` ASC) VISIBLE,
  INDEX `fk_Policajac_Policajac1_idx` (`JMBsefa` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  CONSTRAINT `fk_Policajac_OrganizacionaJedinica1`
    FOREIGN KEY (`idUprava` , `idOrganizacionaJedinica`)
    REFERENCES `Policija`.`OrganizacionaJedinica` (`idUprava` , `idOrganizacionaJedinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Policajac_Osoba1`
    FOREIGN KEY (`JMB`)
    REFERENCES `Policija`.`Osoba` (`JMB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Policajac_Policajac1`
    FOREIGN KEY (`JMBsefa`)
    REFERENCES `Policija`.`Policajac` (`JMB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`KazneniNalog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`KazneniNalog` (
  `idKazneniNalog` INT NOT NULL,
  `Vrijeme` TIME NOT NULL,
  `Datum` DATE NOT NULL,
  `OpisPrekrsaja` VARCHAR(1000) NOT NULL,
  `tackaZakona` INT NULL,
  `JMBpolicajac` DECIMAL(13) NOT NULL,
  `idAdrese` INT NOT NULL,
  `JMB` DECIMAL(13) NOT NULL,
  PRIMARY KEY (`idKazneniNalog`),
  INDEX `fk_KazneniNalog_Zakon1_idx` (`tackaZakona` ASC) VISIBLE,
  INDEX `fk_KazneniNalog_Policajac1_idx` (`JMBpolicajac` ASC) VISIBLE,
  INDEX `fk_KazneniNalog_Adresa1_idx` (`idAdrese` ASC) VISIBLE,
  INDEX `fk_KazneniNalog_Osoba1_idx` (`JMB` ASC) VISIBLE,
  CONSTRAINT `fk_KazneniNalog_Zakon1`
    FOREIGN KEY (`tackaZakona`)
    REFERENCES `Policija`.`Zakon` (`tackaZakona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_KazneniNalog_Policajac1`
    FOREIGN KEY (`JMBpolicajac`)
    REFERENCES `Policija`.`Policajac` (`JMB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_KazneniNalog_Adresa1`
    FOREIGN KEY (`idAdrese`)
    REFERENCES `Policija`.`Adresa` (`idAdrese`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_KazneniNalog_Osoba1`
    FOREIGN KEY (`JMB`)
    REFERENCES `Policija`.`Osoba` (`JMB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`SaobracajnaNesreca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`SaobracajnaNesreca` (
  `idSaobracajnaNesreca` INT NOT NULL AUTO_INCREMENT,
  `Vrijeme` TIME NOT NULL,
  `Datum` DATE NOT NULL,
  `Izvjestaj` VARCHAR(1500) NOT NULL,
  `idAdrese` INT NOT NULL,
  PRIMARY KEY (`idSaobracajnaNesreca`),
  INDEX `fk_SaobracajnaNesreca_Adresa1_idx` (`idAdrese` ASC) VISIBLE,
  CONSTRAINT `fk_SaobracajnaNesreca_Adresa1`
    FOREIGN KEY (`idAdrese`)
    REFERENCES `Policija`.`Adresa` (`idAdrese`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`KriminalniDosije`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`KriminalniDosije` (
  `idKriminalniDosije` INT NOT NULL,
  `Izvjestaj` VARCHAR(4000) NOT NULL,
  PRIMARY KEY (`idKriminalniDosije`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`IntervencijaSAJ`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`IntervencijaSAJ` (
  `idIntervencija` INT NOT NULL AUTO_INCREMENT,
  `Naziv` VARCHAR(100) NOT NULL,
  `Izvjestaj` VARCHAR(5000) NOT NULL,
  `idOrganizacionaJedinica` INT NOT NULL,
  `JMBpolicajac` DECIMAL(13) NOT NULL,
  `idAdrese` INT NOT NULL,
  PRIMARY KEY (`idIntervencija`),
  INDEX `fk_IntervencijaSAJ_Policajac1_idx` (`JMBpolicajac` ASC) VISIBLE,
  INDEX `fk_IntervencijaSAJ_Adresa1_idx` (`idAdrese` ASC) VISIBLE,
  CONSTRAINT `fk_IntervencijaSAJ_Policajac1`
    FOREIGN KEY (`JMBpolicajac`)
    REFERENCES `Policija`.`Policajac` (`JMB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_IntervencijaSAJ_Adresa1`
    FOREIGN KEY (`idAdrese`)
    REFERENCES `Policija`.`Adresa` (`idAdrese`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`TeroristickiDosije`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`TeroristickiDosije` (
  `idTeroristickiDosije` INT NOT NULL AUTO_INCREMENT,
  `Naziv` VARCHAR(45) NOT NULL,
  `Opis` VARCHAR(5000) NOT NULL,
  PRIMARY KEY (`idTeroristickiDosije`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`IntervencijaZandarmerije`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`IntervencijaZandarmerije` (
  `idIntervencija` INT NOT NULL AUTO_INCREMENT,
  `Naziv` VARCHAR(45) NOT NULL,
  `Vrijeme` TIME NULL,
  `Datum` DATE NOT NULL,
  `BezbjednosnaProcjena` VARCHAR(500) NOT NULL,
  `PlanAktivnosti` VARCHAR(2000) NOT NULL,
  `idAdrese` INT NOT NULL,
  `JMBpolicajac` DECIMAL(13) NOT NULL,
  `idOrganizacionaJedinica` INT NOT NULL,
  PRIMARY KEY (`idIntervencija`),
  INDEX `fk_IntervencijaZandarmerije_Adresa1_idx` (`idAdrese` ASC) VISIBLE,
  INDEX `fk_IntervencijaZandarmerije_Policajac1_idx` (`JMBpolicajac` ASC) VISIBLE,
  CONSTRAINT `fk_IntervencijaZandarmerije_Adresa1`
    FOREIGN KEY (`idAdrese`)
    REFERENCES `Policija`.`Adresa` (`idAdrese`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_IntervencijaZandarmerije_Policajac1`
    FOREIGN KEY (`JMBpolicajac`)
    REFERENCES `Policija`.`Policajac` (`JMB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`Obuka`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`Obuka` (
  `idObuka` INT NOT NULL AUTO_INCREMENT,
  `Naziv` VARCHAR(100) NOT NULL,
  `PocetakObuke` DATE NOT NULL,
  `KrajObuke` DATE NOT NULL,
  `idUprava` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idObuka`),
  INDEX `fk_Obuka_Uprava1_idx` (`idUprava` ASC) VISIBLE,
  CONSTRAINT `fk_Obuka_Uprava1`
    FOREIGN KEY (`idUprava`)
    REFERENCES `Policija`.`Uprava` (`idUprava`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`HelikopterskaIntervencija`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`HelikopterskaIntervencija` (
  `idHelikopterskaIntervencija` INT NOT NULL AUTO_INCREMENT,
  `Naziv` VARCHAR(100) NOT NULL,
  `Vrijeme` TIME NULL,
  `Datum` DATE NOT NULL,
  `Izvjestaj` VARCHAR(1000) NOT NULL,
  `JMB` DECIMAL(13) NOT NULL,
  `IdOrganizacionaJedinica` INT NOT NULL,
  PRIMARY KEY (`idHelikopterskaIntervencija`),
  INDEX `fk_HelikopterskaIntervencija_Policajac1_idx` (`JMB` ASC) VISIBLE,
  CONSTRAINT `fk_HelikopterskaIntervencija_Policajac1`
    FOREIGN KEY (`JMB`)
    REFERENCES `Policija`.`Policajac` (`JMB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`VozackaDozvola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`VozackaDozvola` (
  `BrojVozackeDozvole` VARCHAR(10) NOT NULL,
  `DatumIzdavanja` DATE NOT NULL,
  `DatumIsteka` DATE NOT NULL,
  `PolozeneKategorije` VARCHAR(45) NOT NULL,
  `JMB` DECIMAL(13) NOT NULL,
  `KazneniBodovi` INT UNSIGNED NULL DEFAULT 0,
  `AktivnostDozvole` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`BrojVozackeDozvole`),
  INDEX `fk_VozackaDozvola_Osoba1_idx` (`JMB` ASC) VISIBLE,
  CONSTRAINT `fk_VozackaDozvola_Osoba1`
    FOREIGN KEY (`JMB`)
    REFERENCES `Policija`.`Osoba` (`JMB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`Oruzje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`Oruzje` (
  `idOruzje` INT NOT NULL,
  `TipOruzja` VARCHAR(45) NOT NULL,
  `StatusZaduzenja` TINYINT NOT NULL,
  PRIMARY KEY (`idOruzje`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`Zaduzenje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`Zaduzenje` (
  `idOruzje` INT NOT NULL,
  `JMB` DECIMAL(13) NOT NULL,
  `DatumZaduzenja` DATE NOT NULL,
  `DatumRazduzenja` DATE NULL,
  PRIMARY KEY (`idOruzje`, `JMB`, `DatumZaduzenja`),
  INDEX `fk_Oruzje_has_Policajac_Policajac1_idx` (`JMB` ASC) VISIBLE,
  INDEX `fk_Oruzje_has_Policajac_Oruzje1_idx` (`idOruzje` ASC) VISIBLE,
  CONSTRAINT `fk_Oruzje_has_Policajac_Oruzje1`
    FOREIGN KEY (`idOruzje`)
    REFERENCES `Policija`.`Oruzje` (`idOruzje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Oruzje_has_Policajac_Policajac1`
    FOREIGN KEY (`JMB`)
    REFERENCES `Policija`.`Policajac` (`JMB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`UcesniciUSaobracajnojNesreci`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`UcesniciUSaobracajnojNesreci` (
  `idSaobracajnaNesreca` INT NOT NULL,
  `JMB` DECIMAL(13) NOT NULL,
  PRIMARY KEY (`idSaobracajnaNesreca`, `JMB`),
  INDEX `fk_SaobracajnaNesreca_has_Osoba_Osoba1_idx` (`JMB` ASC) VISIBLE,
  INDEX `fk_SaobracajnaNesreca_has_Osoba_SaobracajnaNesreca1_idx` (`idSaobracajnaNesreca` ASC) VISIBLE,
  CONSTRAINT `fk_SaobracajnaNesreca_has_Osoba_SaobracajnaNesreca1`
    FOREIGN KEY (`idSaobracajnaNesreca`)
    REFERENCES `Policija`.`SaobracajnaNesreca` (`idSaobracajnaNesreca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SaobracajnaNesreca_has_Osoba_Osoba1`
    FOREIGN KEY (`JMB`)
    REFERENCES `Policija`.`Osoba` (`JMB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`PrekrseneTackeZakona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`PrekrseneTackeZakona` (
  `tackaZakona` INT NOT NULL,
  `idKriminalniDosije` INT NOT NULL,
  PRIMARY KEY (`tackaZakona`, `idKriminalniDosije`),
  INDEX `fk_Zakon_has_KriminalniDosije_KriminalniDosije1_idx` (`idKriminalniDosije` ASC) VISIBLE,
  INDEX `fk_Zakon_has_KriminalniDosije_Zakon1_idx` (`tackaZakona` ASC) VISIBLE,
  CONSTRAINT `fk_Zakon_has_KriminalniDosije_Zakon1`
    FOREIGN KEY (`tackaZakona`)
    REFERENCES `Policija`.`Zakon` (`tackaZakona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Zakon_has_KriminalniDosije_KriminalniDosije1`
    FOREIGN KEY (`idKriminalniDosije`)
    REFERENCES `Policija`.`KriminalniDosije` (`idKriminalniDosije`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`KriminalniPocinioci`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`KriminalniPocinioci` (
  `idKriminalniDosije` INT NOT NULL,
  `JMB` DECIMAL(13) NOT NULL,
  PRIMARY KEY (`idKriminalniDosije`, `JMB`),
  INDEX `fk_KriminalniDosije_has_Osoba_Osoba1_idx` (`JMB` ASC) VISIBLE,
  INDEX `fk_KriminalniDosije_has_Osoba_KriminalniDosije1_idx` (`idKriminalniDosije` ASC) VISIBLE,
  CONSTRAINT `fk_KriminalniDosije_has_Osoba_KriminalniDosije1`
    FOREIGN KEY (`idKriminalniDosije`)
    REFERENCES `Policija`.`KriminalniDosije` (`idKriminalniDosije`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_KriminalniDosije_has_Osoba_Osoba1`
    FOREIGN KEY (`JMB`)
    REFERENCES `Policija`.`Osoba` (`JMB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`UcesniciUObuci`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`UcesniciUObuci` (
  `JMB` DECIMAL(13) NOT NULL,
  `idObuka` INT NOT NULL,
  PRIMARY KEY (`JMB`, `idObuka`),
  INDEX `fk_Osoba_has_Obuka_Obuka1_idx` (`idObuka` ASC) VISIBLE,
  INDEX `fk_Osoba_has_Obuka_Osoba1_idx` (`JMB` ASC) VISIBLE,
  CONSTRAINT `fk_Osoba_has_Obuka_Osoba1`
    FOREIGN KEY (`JMB`)
    REFERENCES `Policija`.`Osoba` (`JMB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Osoba_has_Obuka_Obuka1`
    FOREIGN KEY (`idObuka`)
    REFERENCES `Policija`.`Obuka` (`idObuka`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`Pripravnik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`Pripravnik` (
  `JMB` DECIMAL(13) NOT NULL,
  `idUprava` VARCHAR(10) NOT NULL,
  `idOrganizacionaJedinica` INT NOT NULL,
  `PocetakPripravnickogStaza` DATE NOT NULL,
  `PolozenDrzavniIspit` TINYINT NULL,
  `Mentor_JMB` DECIMAL(13) NOT NULL,
  PRIMARY KEY (`JMB`),
  INDEX `fk_Pripravnik_OrganizacionaJedinica1_idx` (`idUprava` ASC, `idOrganizacionaJedinica` ASC) VISIBLE,
  INDEX `fk_Pripravnik_Policajac1_idx` (`Mentor_JMB` ASC) VISIBLE,
  CONSTRAINT `fk_Pripravnik_Osoba1`
    FOREIGN KEY (`JMB`)
    REFERENCES `Policija`.`Osoba` (`JMB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pripravnik_OrganizacionaJedinica1`
    FOREIGN KEY (`idUprava` , `idOrganizacionaJedinica`)
    REFERENCES `Policija`.`OrganizacionaJedinica` (`idUprava` , `idOrganizacionaJedinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pripravnik_Policajac1`
    FOREIGN KEY (`Mentor_JMB`)
    REFERENCES `Policija`.`Policajac` (`JMB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`IntervencijaHelikoptera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`IntervencijaHelikoptera` (
  `idPrevoznoSredstvo` INT NOT NULL,
  `idHelikopterskaIntervencija` INT NOT NULL,
  PRIMARY KEY (`idPrevoznoSredstvo`, `idHelikopterskaIntervencija`),
  INDEX `fk_PrevoznoSredstvo_has_HelikopterskaIntervencija_Helikopte_idx` (`idHelikopterskaIntervencija` ASC) VISIBLE,
  INDEX `fk_PrevoznoSredstvo_has_HelikopterskaIntervencija_PrevoznoS_idx` (`idPrevoznoSredstvo` ASC) VISIBLE,
  CONSTRAINT `fk_PrevoznoSredstvo_has_HelikopterskaIntervencija_PrevoznoSre1`
    FOREIGN KEY (`idPrevoznoSredstvo`)
    REFERENCES `Policija`.`PrevoznoSredstvo` (`idPrevoznoSredstvo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PrevoznoSredstvo_has_HelikopterskaIntervencija_Helikopters1`
    FOREIGN KEY (`idHelikopterskaIntervencija`)
    REFERENCES `Policija`.`HelikopterskaIntervencija` (`idHelikopterskaIntervencija`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Policija`.`Adrese_Obuke`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Policija`.`Adrese_Obuke` (
  `idObuka` INT NOT NULL,
  `idAdrese` INT NOT NULL,
  PRIMARY KEY (`idObuka`, `idAdrese`),
  INDEX `fk_Obuka_has_Adresa_Adresa1_idx` (`idAdrese` ASC) VISIBLE,
  INDEX `fk_Obuka_has_Adresa_Obuka1_idx` (`idObuka` ASC) VISIBLE,
  CONSTRAINT `fk_Obuka_has_Adresa_Obuka1`
    FOREIGN KEY (`idObuka`)
    REFERENCES `Policija`.`Obuka` (`idObuka`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Obuka_has_Adresa_Adresa1`
    FOREIGN KEY (`idAdrese`)
    REFERENCES `Policija`.`Adresa` (`idAdrese`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
