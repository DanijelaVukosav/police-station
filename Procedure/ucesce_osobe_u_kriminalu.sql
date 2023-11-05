CREATE DEFINER=`root`@`localhost` PROCEDURE `ucesce_osobe_u_kriminalu`(in jmb decimal(13))
BEGIN
	select osoba.JMB,Ime,Prezime,Izvjestaj from kriminalnipocinioci 
    inner join osoba on osoba.JMB= kriminalnipocinioci.JMB
    natural join kriminalnidosije
    where osoba.JMB=jmb;
END