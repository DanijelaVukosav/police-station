CREATE DEFINER=`root`@`localhost` PROCEDURE `dobavljanje_kazni_radarske_kontrole`(in idkontrole int)
BEGIN
	select idRadarskaKazna,idRadarskaKontrola,Vrijeme,Datum,NovcanaKazna,PrekoracenjeBrzine,RegistracijskeTablice,concat(Ulica,' ',Mjesto) as Adresa
    from radarskakazna natural join radarskakontrola natural join adresa where idRadarskaKontrola=idkontrole;
END