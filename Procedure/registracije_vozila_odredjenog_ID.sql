CREATE DEFINER=`root`@`localhost` PROCEDURE `registracije_vozila_odredjenog_ID`(in IDVozila int)
BEGIN
	select RegistracijskeTablice,TipVozila,DatumRegistracije,RokIstekaRegistracije,Ime,Prezime from registracijavozila 
    natural join osoba where idPrevoznoSredstvo=IDVozila;
END