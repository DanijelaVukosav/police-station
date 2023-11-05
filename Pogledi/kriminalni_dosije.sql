CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `policija`.`kriminalni_dosije` AS
    SELECT 
        `policija`.`kriminalnidosije`.`Izvjestaj` AS `Izvjestaj`,
        GROUP_CONCAT(`podaciosobe`.`Osoba`
            SEPARATOR ',') AS `Pocionioci`
    FROM
        ((`policija`.`kriminalnidosije`
        JOIN `policija`.`kriminalnipocinioci` ON ((`policija`.`kriminalnidosije`.`idKriminalniDosije` = `policija`.`kriminalnipocinioci`.`idKriminalniDosije`)))
        JOIN (SELECT 
            `policija`.`osoba`.`JMB` AS `JMB`,
                CONCAT(`policija`.`osoba`.`Ime`, ' ', `policija`.`osoba`.`Prezime`) AS `Osoba`
        FROM
            `policija`.`osoba`) `podaciosobe` ON ((`policija`.`kriminalnipocinioci`.`JMB` = `podaciosobe`.`JMB`)))
    GROUP BY `policija`.`kriminalnidosije`.`idKriminalniDosije`