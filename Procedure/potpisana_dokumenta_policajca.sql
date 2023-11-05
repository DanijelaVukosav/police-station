CREATE DEFINER=`root`@`localhost` PROCEDURE `potpisana_dokumenta_policajca`(in jmb decimal(13))
BEGIN
	declare upravaTemp varchar(5);
    declare kraj boolean default false;
    declare kursor cursor for 
    select idUprava from policajac where policajac.JMB=jmb;
    declare continue handler for not found set kraj=true;
    
    open kursor;
    petlja: loop
		fetch kursor into upravaTemp;
		if kraj then
			leave petlja;
		end if;
        select upravaTemp;
		case upravaTemp
        when 'SP' then
			select Vrijeme,Datum,OpisPrekrsaja,concat(adresa.Ulica,' ',adresa.Mjesto) as Adresa,concat(Ime,' ',Prezime) as Kaznjeni  from kazneninalog
			inner join adresa on adresa.idAdrese=kazneninalog.idAdrese
            inner join osoba on osoba.JMB=kazneninalog.JMB
			where JMBpolicajac=jmb;

        when 'HJ' then 
			select Naziv,Vrijeme,Datum,Izvjestaj,GROUP_CONCAT(VrstaPrevoznogSredstva SEPARATOR ',') AS `MotornaVozila` from helikopterskaintervencija 
			natural join intervencijahelikoptera
			natural join prevoznosredstvo
            where JMB=jmb
			group by idHelikopterskaIntervencija;
        when 'SAJ' then
			select Naziv,Izvjestaj,concat(Ulica, ' ',Mjesto) as Adresa from intervencijasaj natural join adresa
            where JMBpolicajac=jmb;
		when 'ZAN' then
			select Naziv,Vrijeme,Datum,BezbjednosnaProcjena,PlanAktivnosti,concat(Ulica,' ',Mjesto) as Adresa from intervencijazandarmerije
            natural join adresa
            where JMBpolicajac=jmb;
		end case;
	end loop;
    close kursor;
END