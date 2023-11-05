CREATE DEFINER=`root`@`localhost` PROCEDURE `trenutno_registrovana_vozila`()
BEGIN
	select RegistracijskeTablice,TipVozila,DatumRegistracije,RokIstekaRegistracije,Ime,Prezime,idUprava,idOrganizacionaJedinica from registracijavozila 
    left join osoba on osoba.JMB=registracijavozila.JMB
    left join prevoznosredstvo on prevoznosredstvo.idPrevoznoSredstvo=registracijavozila.idPrevoznoSredstvo
    where RokIstekaRegistracije>=current_date();
END