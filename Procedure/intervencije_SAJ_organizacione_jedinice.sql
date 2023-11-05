CREATE DEFINER=`root`@`localhost` PROCEDURE `intervencije_SAJ_organizacione_jedinice`(in  org int)
BEGIN
	select * from intervencijaSAJ where IdOrganizacionaJedinica=org;
END