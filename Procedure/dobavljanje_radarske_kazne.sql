CREATE DEFINER=`root`@`localhost` PROCEDURE `dobavljanje_radarske_kazne`(in idKazna int)
BEGIN
	select idRadarskaKazna,idRadarskaKontrola,Vrijeme,Datum,NovcanaKazna,PrekoracenjeBrzine,RegistracijskeTablice,concat(Ulica,' ',Mjesto) as Adresa
    from radarskakazna natural join radarskakontrola natural join adresa where idRadarskaKazna=idKazna;
END