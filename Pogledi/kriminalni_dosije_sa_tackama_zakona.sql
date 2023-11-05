CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `policija`.`kriminalni_dosije_sa_tackama_zakona` AS
    SELECT 
        `policija`.`kriminalnidosije`.`Izvjestaj` AS `Izvjestaj`,
        GROUP_CONCAT(`podaciosobe`.`Osoba`
            SEPARATOR ',') AS `Pocionioci`,
        GROUP_CONCAT(DISTINCT `policija`.`zakon`.`nazivTackeZakona`
            SEPARATOR ',') AS `PrekrseneTackeZakona`
    FROM
        ((((`policija`.`kriminalnidosije`
        JOIN `policija`.`kriminalnipocinioci` ON ((`policija`.`kriminalnidosije`.`idKriminalniDosije` = `policija`.`kriminalnipocinioci`.`idKriminalniDosije`)))
        JOIN (SELECT 
            `policija`.`osoba`.`JMB` AS `JMB`,
                CONCAT(`policija`.`osoba`.`Ime`, ' ', `policija`.`osoba`.`Prezime`) AS `Osoba`
        FROM
            `policija`.`osoba`) `podaciosobe` ON ((`policija`.`kriminalnipocinioci`.`JMB` = `podaciosobe`.`JMB`)))
        JOIN `policija`.`prekrsenetackezakona` ON ((`policija`.`kriminalnidosije`.`idKriminalniDosije` = `policija`.`prekrsenetackezakona`.`idKriminalniDosije`)))
        JOIN `policija`.`zakon` ON ((`policija`.`prekrsenetackezakona`.`tackaZakona` = `policija`.`zakon`.`tackaZakona`)))
    GROUP BY `policija`.`kriminalnidosije`.`idKriminalniDosije`