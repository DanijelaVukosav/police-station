CREATE DEFINER=`root`@`localhost` PROCEDURE `intervencije_zandarmerije_organizacione_jedinice`(in org int)
BEGIN
	select * from intervencijazandarmerije natural join adresa where IdOrganizacionaJedinica=org;
END