CREATE DEFINER=`root`@`localhost` PROCEDURE `radarske_kazne_registracije`(in tablice varchar(10))
BEGIN
	select * from radarske_kazne where registracijskeTablice=tablice;
END