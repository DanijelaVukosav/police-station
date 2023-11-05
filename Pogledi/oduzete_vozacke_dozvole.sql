CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `policija`.`oduzete_vozacke_dozvole` AS
    SELECT 
        `policija`.`vozackadozvola`.`BrojVozackeDozvole` AS `BrojVozackeDozvole`,
        `policija`.`osoba`.`Ime` AS `Ime`,
        `policija`.`osoba`.`Prezime` AS `Prezime`,
        `policija`.`vozackadozvola`.`KazneniBodovi` AS `KazneniBodovi`
    FROM
        (`policija`.`vozackadozvola`
        JOIN `policija`.`osoba` ON ((`policija`.`vozackadozvola`.`JMB` = `policija`.`osoba`.`JMB`)))
    WHERE
        ((`policija`.`vozackadozvola`.`AktivnostDozvole` = FALSE)
            AND (`policija`.`vozackadozvola`.`DatumIsteka` >= CURDATE()))