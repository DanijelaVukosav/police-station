CREATE DEFINER=`root`@`localhost` PROCEDURE `dobavljanje_kazni_na_osnovu_registracije`(in registracija varchar(10))
BEGIN
	select idRadarskaKazna,idRadarskaKontrola,Vrijeme,Datum,NovcanaKazna,PrekoracenjeBrzine,RegistracijskeTablice,concat(Ulica,' ',Mjesto) as Adresa
    from radarskakazna natural join radarskakontrola natural join adresa where registracijskeTablice=registracija;
END