CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `policija`.`oruzje_policije` AS
    SELECT 
        `policija`.`oruzje`.`idOruzje` AS `idOruzje`,
        `policija`.`oruzje`.`TipOruzja` AS `TipOruzja`,
        `policija`.`oruzje`.`StatusZaduzenja` AS `StatusZaduzenja`
    FROM
        `policija`.`oruzje`