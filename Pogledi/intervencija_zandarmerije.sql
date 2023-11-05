CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `policija`.`intervencija_zandarmerije` AS
    SELECT 
        `policija`.`intervencijazandarmerije`.`idOrganizacionaJedinica` AS `idOrganizacionaJedinica`,
        `policija`.`intervencijazandarmerije`.`Naziv` AS `Naziv`,
        CONCAT(`policija`.`intervencijazandarmerije`.`Vrijeme`,
                ' ',
                `policija`.`intervencijazandarmerije`.`Datum`) AS `VrijemeDogadjaja`,
        `policija`.`intervencijazandarmerije`.`BezbjednosnaProcjena` AS `BezbjednosnaProcjena`,
        `policija`.`intervencijazandarmerije`.`PlanAktivnosti` AS `PlanAktivnosti`,
        CONCAT(`policija`.`adresa`.`Ulica`,
                ' ',
                `policija`.`adresa`.`Mjesto`) AS `Adresa`
    FROM
        (`policija`.`intervencijazandarmerije`
        JOIN `policija`.`adresa` ON ((`policija`.`intervencijazandarmerije`.`idAdrese` = `policija`.`adresa`.`idAdrese`)))
    GROUP BY `policija`.`intervencijazandarmerije`.`idOrganizacionaJedinica`