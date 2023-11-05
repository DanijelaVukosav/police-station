CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `policija`.`intervencija_saj` AS
    SELECT 
        `policija`.`intervencijasaj`.`Naziv` AS `Naziv`,
        `policija`.`intervencijasaj`.`Izvjestaj` AS `Izvjestaj`,
        CONCAT(`policija`.`adresa`.`Ulica`,
                ' ',
                `policija`.`adresa`.`Mjesto`) AS `Adresa`
    FROM
        (`policija`.`intervencijasaj`
        JOIN `policija`.`adresa` ON ((`policija`.`intervencijasaj`.`idAdrese` = `policija`.`adresa`.`idAdrese`)))