CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `policija`.`radarske_kontrole` AS
    SELECT 
        `policija`.`adresa`.`Ulica` AS `Ulica`,
        `policija`.`adresa`.`Mjesto` AS `Mjesto`,
        `policija`.`radarskakontrola`.`Datum` AS `Datum`,
        `policija`.`kamera`.`Tip` AS `TipKamere`
    FROM
        ((`policija`.`radarskakontrola`
        JOIN `policija`.`adresa` ON ((`policija`.`radarskakontrola`.`idAdrese` = `policija`.`adresa`.`idAdrese`)))
        JOIN `policija`.`kamera` ON ((`policija`.`radarskakontrola`.`idKamere` = `policija`.`kamera`.`idKamere`)))