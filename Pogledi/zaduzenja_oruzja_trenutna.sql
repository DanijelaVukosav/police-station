CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `policija`.`zaduzenja_oruzja_trenutna` AS
    SELECT 
        `policija`.`oruzje`.`idOruzje` AS `idOruzje`,
        `policija`.`oruzje`.`TipOruzja` AS `TipOruzja`,
        `policija`.`zaduzenje`.`JMB` AS `JMB`,
        `policija`.`osoba`.`Ime` AS `Ime`,
        `policija`.`osoba`.`Prezime` AS `Prezime`
    FROM
        ((`policija`.`oruzje`
        JOIN `policija`.`zaduzenje` ON ((`policija`.`zaduzenje`.`idOruzje` = `policija`.`oruzje`.`idOruzje`)))
        JOIN `policija`.`osoba` ON ((`policija`.`zaduzenje`.`JMB` = `policija`.`osoba`.`JMB`)))
    WHERE
        ((`policija`.`zaduzenje`.`DatumRazduzenja` IS NULL)
            AND (`policija`.`oruzje`.`StatusZaduzenja` = TRUE))
    ORDER BY `policija`.`zaduzenje`.`DatumZaduzenja` DESC