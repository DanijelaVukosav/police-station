CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `policija`.`radarske_kazne` AS
    SELECT 
        `policija`.`radarskakazna`.`registracijskeTablice` AS `registracijskeTablice`,
        `policija`.`radarskakazna`.`PrekoracenjeBrzine` AS `PrekoracenjeBrzine`,
        `policija`.`radarskakazna`.`Vrijeme` AS `Vrijeme`,
        `policija`.`radarskakontrola`.`Datum` AS `Datum`,
        `policija`.`adresa`.`Ulica` AS `Ulica`,
        `policija`.`adresa`.`Mjesto` AS `Mjesto`
    FROM
        ((`policija`.`radarskakontrola`
        JOIN `policija`.`radarskakazna` ON ((`policija`.`radarskakontrola`.`idRadarskaKontrola` = `policija`.`radarskakazna`.`idRadarskaKontrola`)))
        JOIN `policija`.`adresa` ON ((`policija`.`radarskakontrola`.`idAdrese` = `policija`.`adresa`.`idAdrese`)))
    ORDER BY `policija`.`radarskakontrola`.`Datum` DESC