CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `policija`.`zaduzeno_oruzje` AS
    SELECT 
        `policija`.`oruzje`.`idOruzje` AS `idOruzje`,
        `policija`.`oruzje`.`TipOruzja` AS `TipOruzja`
    FROM
        (`policija`.`oruzje`
        JOIN `policija`.`zaduzenje` ON ((`policija`.`oruzje`.`idOruzje` = `policija`.`zaduzenje`.`idOruzje`)))
    WHERE
        ((`policija`.`zaduzenje`.`DatumRazduzenja` IS NULL)
            AND (`policija`.`oruzje`.`StatusZaduzenja` = TRUE))