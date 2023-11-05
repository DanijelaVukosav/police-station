CREATE DEFINER=`root`@`localhost` PROCEDURE `trenutno_aktivna_registracijska_tablica`(in tablica varchar(10))
BEGIN
	select RegistracijskeTablice,TipVozila,DatumRegistracije,RokIstekaRegistracije,Ime,Prezime from registracijavozila 
    left  join osoba on osoba.JMB=registracijavozila.JMB
    where RegistracijskeTablice=tablica and RokIstekaRegistracije>=curdate() ;
END