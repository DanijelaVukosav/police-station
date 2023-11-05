CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `policija`.`helikopterske_intervencije` AS
    SELECT 
        `policija`.`helikopterskaintervencija`.`Naziv` AS `Naziv`,
        `policija`.`helikopterskaintervencija`.`Vrijeme` AS `Vrijeme`,
        `policija`.`helikopterskaintervencija`.`Datum` AS `Datum`,
        `policija`.`helikopterskaintervencija`.`Izvjestaj` AS `Izvjestaj`,
        CONCAT(`policija`.`adresa`.`Ulica`,
                ' ',
                `policija`.`adresa`.`Mjesto`) AS `AdresaJedinice`,
        GROUP_CONCAT(`sredstvo`.`Sredstvo`
            SEPARATOR ',') AS `PrevoznoSredstvo`
    FROM
        ((((`policija`.`helikopterskaintervencija`
        JOIN `policija`.`organizacionajedinica` ON ((`policija`.`helikopterskaintervencija`.`IdOrganizacionaJedinica` = `policija`.`organizacionajedinica`.`idOrganizacionaJedinica`)))
        JOIN `policija`.`adresa` ON ((`policija`.`organizacionajedinica`.`idAdrese` = `policija`.`adresa`.`idAdrese`)))
        JOIN `policija`.`intervencijahelikoptera` ON ((`policija`.`helikopterskaintervencija`.`idHelikopterskaIntervencija` = `policija`.`intervencijahelikoptera`.`idHelikopterskaIntervencija`)))
        JOIN (SELECT 
            `policija`.`prevoznosredstvo`.`idPrevoznoSredstvo` AS `idPrevoznoSredstvo`,
                `policija`.`prevoznosredstvo`.`VrstaPrevoznogSredstva` AS `Sredstvo`
        FROM
            `policija`.`prevoznosredstvo`) `sredstvo` ON ((`policija`.`intervencijahelikoptera`.`idPrevoznoSredstvo` = `sredstvo`.`idPrevoznoSredstvo`)))