CREATE DEFINER=`root`@`localhost` PROCEDURE `zaduzenja_oruzja_odredjenog_ID`(in id int)
BEGIN
	select Ime,Prezime,DatumZaduzenja,DatumRazduzenja,TipOruzja,StatusZaduzenja from zaduzenje
    natural join osoba
    natural join oruzje
    where idOruzje=id;
END