CREATE DEFINER=`root`@`localhost` PROCEDURE `helikopterske_intervencije_ogranizacije`(in  org int)
BEGIN
	select * from helikopterskaintervencija where IdOrganizacionaJedinica=org;
END