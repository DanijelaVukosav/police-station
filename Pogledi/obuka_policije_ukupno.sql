CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `policija`.`obuka_policije_ukupno` AS
    SELECT 
        `policija`.`obuka`.`Naziv` AS `Naziv`,
        `policija`.`obuka`.`PocetakObuke` AS `PocetakObuke`,
        `policija`.`obuka`.`KrajObuke` AS `KrajObuke`,
        `policija`.`uprava`.`NazivUprave` AS `NazivUprave`,
        GROUP_CONCAT(DISTINCT `adr`.`Adresa`
            SEPARATOR ',') AS `AdreseObuke`
    FROM
        (((`policija`.`obuka`
        JOIN `policija`.`uprava` ON ((`policija`.`obuka`.`idUprava` = `policija`.`uprava`.`idUprava`)))
        JOIN `policija`.`adrese_obuke` ON ((`policija`.`obuka`.`idObuka` = `policija`.`adrese_obuke`.`idObuka`)))
        JOIN (SELECT 
            `policija`.`adresa`.`idAdrese` AS `idAdrese`,
                CONCAT(`policija`.`adresa`.`Ulica`, ' ', `policija`.`adresa`.`Mjesto`) AS `Adresa`
        FROM
            `policija`.`adresa`) `adr` ON ((`policija`.`adrese_obuke`.`idAdrese` = `adr`.`idAdrese`)))
    GROUP BY `policija`.`obuka`.`idObuka`