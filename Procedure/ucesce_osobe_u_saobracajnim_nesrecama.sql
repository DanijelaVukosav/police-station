CREATE DEFINER=`root`@`localhost` PROCEDURE `ucesce_osobe_u_saobracajnim_nesrecama`(in jmb decimal(13))
BEGIN
	select osoba.JMB,Ime,Prezime,Vrijeme,Datum,Izvjestaj from ucesniciusaobracajnojnesreci 
    natural join osoba -- on osoba.JMB=ucesniciusaobracajnojnesreci.JMB
	inner join saobracajnanesreca on saobracajnanesreca.idSaobracajnaNesreca=ucesniciusaobracajnojnesreci.idSaobracajnaNesreca
    where ucesniciusaobracajnojnesreci.JMB=jmb;
END