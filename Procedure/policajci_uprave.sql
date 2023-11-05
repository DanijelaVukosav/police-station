CREATE DEFINER=`root`@`localhost` PROCEDURE `policajci_uprave`(in uprava varchar(5))
BEGIN
	select policajac.JMB,Ime,Prezime,idOrganizacionaJedinica,Cin,Plata,Nadredjeni from policajac 
    left join (select JMB,concat(Ime,' ',Prezime) as Nadredjeni from osoba) as sef on sef.JMB=policajac.JMBsefa
    inner join osoba on osoba.JMB=policajac.JMB
    where RadniOdnos=true and idUprava=uprava;
END