CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `policija`.`obuka_helikopterske_jedinice` AS
    SELECT 
        `policija`.`obuka`.`Naziv` AS `Naziv`,
        `policija`.`obuka`.`PocetakObuke` AS `PocetakObuke`,
        `policija`.`obuka`.`KrajObuke` AS `KrajObuke`,
        GROUP_CONCAT(DISTINCT `adr`.`Adresa`
            SEPARATOR ',') AS `AdreseObuke`,
        GROUP_CONCAT(DISTINCT `ucesnici`.`Osoba`
            SEPARATOR ',') AS `Ucesnici`
    FROM
        (((((`policija`.`obuka`
        JOIN `policija`.`uprava` ON ((`policija`.`obuka`.`idUprava` = `policija`.`uprava`.`idUprava`)))
        JOIN `policija`.`adrese_obuke` ON ((`policija`.`obuka`.`idObuka` = `policija`.`adrese_obuke`.`idObuka`)))
        JOIN (SELECT 
            `policija`.`adresa`.`idAdrese` AS `idAdrese`,
                CONCAT(`policija`.`adresa`.`Ulica`, ' ', `policija`.`adresa`.`Mjesto`) AS `Adresa`
        FROM
            `policija`.`adresa`) `adr` ON ((`policija`.`adrese_obuke`.`idAdrese` = `adr`.`idAdrese`)))
        JOIN `policija`.`ucesniciuobuci` ON ((`policija`.`obuka`.`idObuka` = `policija`.`ucesniciuobuci`.`idObuka`)))
        JOIN (SELECT 
            `policija`.`osoba`.`JMB` AS `JMB`,
                CONCAT(`policija`.`osoba`.`Ime`, ' ', `policija`.`osoba`.`Prezime`) AS `Osoba`
        FROM
            `policija`.`osoba`) `ucesnici` ON ((`policija`.`ucesniciuobuci`.`JMB` = `ucesnici`.`JMB`)))
    WHERE
        (`policija`.`obuka`.`idUprava` = 'HJ')
    GROUP BY `policija`.`obuka`.`idObuka`