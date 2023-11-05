CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `policija`.`kazneni_nalozi` AS
    SELECT 
        `policija`.`osoba`.`Ime` AS `Ime`,
        `policija`.`osoba`.`Prezime` AS `Prezime`,
        CONCAT(`kazna`.`VrijemePrekrsaja`,
                ' ',
                `kazna`.`DatumPrekrsaja`) AS `VrijemeDogadjaja`,
        `kazna`.`OpisPrekrsaja` AS `OpisPrekrsaja`,
        `kazna`.`AdresaPrekrsaja` AS `AdresaPrekrsaja`,
        `kazna`.`PrekrsenaTackaZakona` AS `PrekrsenaTackaZakona`
    FROM
        ((SELECT 
            `policija`.`kazneninalog`.`Vrijeme` AS `VrijemePrekrsaja`,
                `policija`.`kazneninalog`.`Datum` AS `DatumPrekrsaja`,
                `policija`.`kazneninalog`.`OpisPrekrsaja` AS `OpisPrekrsaja`,
                CONCAT(`policija`.`adresa`.`Ulica`, ' ', `policija`.`adresa`.`Mjesto`) AS `AdresaPrekrsaja`,
                `policija`.`zakon`.`nazivTackeZakona` AS `PrekrsenaTackaZakona`
        FROM
            ((`policija`.`kazneninalog`
        JOIN `policija`.`zakon` ON ((`policija`.`kazneninalog`.`tackaZakona` = `policija`.`zakon`.`tackaZakona`)))
        JOIN `policija`.`adresa` ON ((`policija`.`kazneninalog`.`idAdrese` = `policija`.`adresa`.`idAdrese`)))) `kazna`
        JOIN `policija`.`osoba`)