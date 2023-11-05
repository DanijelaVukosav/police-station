CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `policija`.`oruzje_u_magacinu` AS
    SELECT 
        `policija`.`oruzje`.`idOruzje` AS `idOruzje`,
        `policija`.`oruzje`.`TipOruzja` AS `TipOruzja`
    FROM
        (`policija`.`oruzje`
        LEFT JOIN `policija`.`zaduzenje` ON ((`policija`.`zaduzenje`.`idOruzje` = `policija`.`oruzje`.`idOruzje`)))
    WHERE
        ((`policija`.`oruzje`.`StatusZaduzenja` = FALSE)
            AND ((`policija`.`zaduzenje`.`DatumRazduzenja` IS NULL)
            OR (`policija`.`zaduzenje`.`DatumRazduzenja` <= CURDATE())))