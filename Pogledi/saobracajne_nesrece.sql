CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `policija`.`saobracajne_nesrece` AS
    SELECT 
        CONCAT(`policija`.`osoba`.`Ime`,
                ' ',
                `policija`.`osoba`.`Prezime`) AS `Ucesnik`,
        `policija`.`adresa`.`Ulica` AS `Ulica`,
        `policija`.`adresa`.`Mjesto` AS `Mjesto`,
        `tabela`.`Vrijeme` AS `Vrijeme`,
        `tabela`.`Datum` AS `Datum`
    FROM
        (((SELECT 
            `policija`.`ucesniciusaobracajnojnesreci`.`idSaobracajnaNesreca` AS `idSaobracajnaNesreca`,
                `policija`.`ucesniciusaobracajnojnesreci`.`JMB` AS `JMB`,
                `policija`.`saobracajnanesreca`.`Vrijeme` AS `Vrijeme`,
                `policija`.`saobracajnanesreca`.`Datum` AS `Datum`,
                `policija`.`saobracajnanesreca`.`Izvjestaj` AS `Izvjestaj`,
                `policija`.`saobracajnanesreca`.`idAdrese` AS `idAdrese`
        FROM
            (`policija`.`ucesniciusaobracajnojnesreci`
        JOIN `policija`.`saobracajnanesreca` ON ((`policija`.`ucesniciusaobracajnojnesreci`.`idSaobracajnaNesreca` = `policija`.`saobracajnanesreca`.`idSaobracajnaNesreca`)))) `tabela`
        JOIN `policija`.`adresa` ON ((`tabela`.`idAdrese` = `policija`.`adresa`.`idAdrese`)))
        JOIN `policija`.`osoba` ON ((`policija`.`osoba`.`JMB` = `tabela`.`JMB`)))