CREATE DEFINER=`root`@`localhost` PROCEDURE `registracije_vozila`(in IDVozila int)
BEGIN
	select RegistracijskeTablice,TipVozila,DatumRegistracije,RokIstekaRegistracije,idUprava,idOrganizacionaJedinica from registracijavozila 
    inner join prevoznosredstvo on prevoznosredstvo.idPrevoznoSredstvo=registracijavozila.idPrevoznoSredstvo
    where registracijavozila.idPrevoznoSredstvo=IDVozila;
END