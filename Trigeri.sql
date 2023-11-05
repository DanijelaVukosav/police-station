use policija;

DROP TRIGGER IF EXISTS prenosKaznenihBodova;
delimiter $$
CREATE TRIGGER prenosKaznenihBodova before insert on vozackadozvola -- ako je osoba obnavlja ili kreira novu vozacku dozvolu koja ima manje od 3 kaznena boda, bodovi ce biti preneseni
for each row
begin

set new.KazneniBodovi=
	case 
			when ((select KazneniBodovi from vozackadozvola where JMB=new.JMB order by DatumIsteka desc limit 1)<3)  then (select KazneniBodovi from vozackadozvola where JMB=new.JMB order by DatumIsteka desc limit 1)
			else 0
	end;

end $$
delimiter ;



use policija;
delimiter $$
DROP TRIGGER IF EXISTS datumIstekaVozacke; -- svaka vozacka dozvola ima rok vazenja 10 godina od datuma izdavanja
CREATE TRIGGER datumIstekaVozacke before insert on vozackadozvola
for each row
begin
	if (new.DatumIzdavanja>curdate()) then
		signal sqlstate '45000' set message_text='Datum izdavanja ne moze biti mladji od danasnjeg datuma.';
	end if;
     if (new.DatumIsteka>new.DatumIzdavanja) then
		signal sqlstate '45000' set message_text='Datum isteka ne moze biti stariji od datuma izdavanja';
	end if;
	set new.DatumIsteka=DATE_ADD(new.DatumIzdavanja,INTERVAL 10 year);
    if (new.DatumIsteka<curdate()) then 
		set new.AktivnostDozvole=false;
	end if;
end $$
delimiter ;



DROP TRIGGER IF EXISTS promjenaStatusaZaduzenjaOruzjaNakonRazduzenja; -- nakon razduzenja, oruzje postaje slobodno za zaduzivanje
CREATE TRIGGER promjenaStatusaZaduzenjaOruzjaNakonRazduzenja before update on zaduzenje
for each row
update oruzje
set StatusZaduzenja=if(new.DatumRazduzenja<=curdate(),false,true)
    where idOruzje=new.idOruzje;

    
use policija;

DROP TRIGGER IF EXISTS provjeraUslovaZaduzivanja; -- provjeravaju se uslovi, i ako su ispunjeni oruzje mijenja svoj status u zaduzeno
delimiter $$ 
CREATE TRIGGER provjeraUslovaZaduzivanja before insert on zaduzenje
for each row
begin
	if ((select count(*) from oruzje where idOruzje=new.idOruzje and StatusZaduzenja=true)>0 and new.DatumRazduzenja is null) then
		signal sqlstate '45000' set message_text='Oruzje sa datim ID je vec zaduzeno.';
	end if;
    if (new.DatumZaduzenja>curdate()) then
		signal sqlstate '45000' set message_text='Datum zaduzenja ne moze biti mladji od danasnjeg datuma.';
	end if;
     if (new.DatumRazduzenja<new.DatumZaduzenja) then
		signal sqlstate '45000' set message_text='Datum razduzivanja ne moze biti stariji od datuma zaduzivanja';
	end if;
    if(new.DatumRazduzenja is null) then 
		update oruzje
		set StatusZaduzenja=if(new.DatumRazduzenja is null,true,false)
		where idOruzje=new.idOruzje;
    end if;
end $$
delimiter ;

select curtime();
use policija;
delimiter $$
DROP TRIGGER IF EXISTS provjeraDatumaSaobracajneNesrece; -- ne mogu se unositi saobracajne nesrece unaprijed
CREATE TRIGGER provjeraDatumaSaobracajneNesrece before insert on saobracajnanesreca
for each row
begin
    if (new.Datum>curdate()) then
		signal sqlstate '45000' set message_text='Datum ne moze biti mladji od danasnjeg datuma.';
	end if;
     if (new.Datum=curdate() and new.Vrijeme>curtime()) then
		signal sqlstate '45000' set message_text='Vrijeme  ne moze biti vece od trenutnog vremena';
	end if;
end $$
delimiter ;



DROP TRIGGER IF EXISTS datumIstekaRegistracije;
CREATE TRIGGER datumIstekaRegistracije before insert on registracijavozila -- registracija vozila traje godinu dana
for each row
set new.RokIstekaRegistracije=DATE_ADD(new.DatumRegistracije,INTERVAL 1 year);

use policija;

DROP TRIGGER IF EXISTS provjeraDatumaRegistracije; -- provjera datuma registracije
delimiter $$
CREATE TRIGGER provjeraDatumaRegistracije before insert on registracijavozila
for each row
begin
    if (new.DatumRegistracije>curdate()) then
		signal sqlstate '45000' set message_text='Datum ne moze biti mladji od danasnjeg datuma.';
	end if;
    if (select count(*) from registracijavozila where RegistracijskeTablice=new.RegistracijskeTablice and RokIstekaRegistracije<new.DatumRegistracije)>0 then
    signal sqlstate '45000' set message_text='Ne mogu postojati istovremene saobracajne dozvole na iste registracijske tablice.';
	end if;
end $$
delimiter ;



DROP TRIGGER IF EXISTS provjeraDatumaRadarskeKontrole; -- ne mogu se unositi radarske kontrole unaprijed
delimiter $$
CREATE TRIGGER provjeraDatumaRadarskeKontrole before insert on radarskakontrola
for each row
begin
    if (new.Datum>curdate()) then
		signal sqlstate '45000' set message_text='Datum ne moze biti mladji od danasnjeg datuma.';
	end if;
end $$
delimiter ;

DROP TRIGGER IF EXISTS provjeraUslovaRadarskeKazne; -- kaznjiva su samo prekoracenja preko 10 km/h
delimiter $$
CREATE TRIGGER provjeraUslovaRadarskeKazne before insert on radarskakazna
for each row
begin
    if (new.PrekoracenjeBrzine<10) then
		signal sqlstate '45000' set message_text='Kaznjiva su samo prekoracenja iznad 10 km/h';
	end if;
end $$
delimiter ;


DROP TRIGGER IF EXISTS novcanaNadoknadaRadarskeKazne; -- radi demontracije, za primjer sam uzela da se automatski racuna novcana kazna
CREATE TRIGGER novcanaNadoknadaRadarskeKazne before insert on radarskakazna
for each row
set new.NovcanaKazna=new.PrekoracenjeBrzine*20;


DROP TRIGGER IF EXISTS kazneniBodoviRadarskeKazne; -- prekoracenja od 20 do 30 km/h impliciraju 1 kazneni bod, a prekoracenja veca od 30 km/h donose 2 kaznena boda( ukoliko vlasnik ima vozacku dozvolu)
CREATE TRIGGER kazneniBodoviRadarskeKazne before insert on radarskakazna
for each row
update vozackadozvola
set KazneniBodovi=
	case 
		when (NEW.PrekoracenjeBrzine>=10 and NEW.PrekoracenjeBrzine<20)  then KazneniBodovi
		when (NEW.PrekoracenjeBrzine>=20 and NEW.PrekoracenjeBrzine<30)  then KazneniBodovi+1
        else KazneniBodovi+2
	end,
    AktivnostDozvole=
    case 
		when (KazneniBodovi<3)  then true
        else false
	end
where JMB=(select JMB from registracijavozila where RegistracijskeTablice=NEW.registracijskeTablice);


DROP TRIGGER IF EXISTS DohvatanjeIdSaobracajneDozvole; -- automatsko upisivanja saobracajne dozvole na osnovu unesene registracijske tablice
CREATE TRIGGER DohvatanjeIdSaobracajneDozvole before insert on radarskakazna
for each row
set new.idSaobracajneDozvole= (select idSaobracajneDozvole from registracijavozila where RegistracijskeTablice=new.registracijskeTablice and registracijavozila.RokIstekaRegistracije>=CURDATE());
	

DROP TRIGGER IF EXISTS postavljanje_null_vrijednosti_sefa; -- policajac ne moze biti sam sebi sef, pa se ponistava JMB sefa
CREATE TRIGGER postavljanje_null_vrijednosti_sefa before update on policajac
for each row
set new.JMBsefa=
	case 
			when (new.JMBsefa=old.JMB)  then null
			else new.JMBsefa
	end;

DROP TRIGGER IF EXISTS provjeraUslovaPolicajca; -- plata mora biti pozitivan broj
delimiter $$
CREATE TRIGGER provjeraUslovaPolicajca before insert on policajac
for each row
begin
    if (new.Plata<0) then
		signal sqlstate '45000' set message_text='Plata mora biti pozitivan broj.';
	end if;
end $$
delimiter ;


DROP TRIGGER IF EXISTS provjeraUslovaObuke; -- obukue mogu vrsiti zandarmerija i helikopterska jedinica
delimiter $$
CREATE TRIGGER provjeraUslovaObuke before insert on obuka
for each row
begin
    if (new.idUprava<>'HJ' and new.idUprava<>'ZAN') then
		signal sqlstate '45000' set message_text='Obuku mogu vrsiti samo helikopterske jedinice ili zandarmerija';
	end if;
     if (new.PocetakObuke>curdate()) then
		signal sqlstate '45000' set message_text='Pocetak obuke mora biti stariji od danasnjeg datuma.';
	end if;
     if (new.KrajObuke<new.PocetakObuke) then
		signal sqlstate '45000' set message_text='Pocetak obuke mora biti prije kraja obuke.';
	end if;
end $$
delimiter ;

DROP TRIGGER IF EXISTS prekidRadnogOdnosaPolicajcaUcestvujuciUKriminalu;
CREATE TRIGGER prekidRadnogOdnosaPolicajcaUcestvujuciUKriminalu before insert on kriminalnipocinioci
for each row
update policajac
set RadniOdnos=false 
where JMB=new.JMB;


DROP TRIGGER IF EXISTS provjeraUslovaKaznenogNaloga; -- obukue mogu vrsiti zandarmerija i helikopterska jedinica
delimiter $$
CREATE TRIGGER provjeraUslovaKaznenogNaloga before insert on kazneninalog
for each row
begin
     if (new.Datum>curdate()) then
		signal sqlstate '45000' set message_text='Datum mora biti stariji ili trenutni.';
	end if;
     if (new.Datum=curdate() and new.Vrijeme>curtime()) then
		signal sqlstate '45000' set message_text='Vrijeme je vece od trenutng-ne mozete unositi buduce dogadjaje.';
	end if;
    if ((select idUprava from policajac where JMB=new.JMBpolicajac limit 1)<>'SP') then 
		signal sqlstate '45000' set message_text='Samo saobracajni policajac moze da unosi kaznene naloge.';
	end if;
end $$
delimiter ;



DROP TRIGGER IF EXISTS provjeraUslovaZandarmerijskeIntervencije;
delimiter $$
CREATE TRIGGER provjeraUslovaZandarmerijskeIntervencije before insert on intervencijazandarmerije
for each row
begin
	set new.IdOrganizacionaJedinica=(select idOrganizacionaJedinica from policajac where JMB=new.JMBpolicajac);
     if (new.Datum>curdate()) then
		signal sqlstate '45000' set message_text='Datum mora biti stariji ili trenutni.';
	end if;
     if (new.Datum=curdate() and new.Vrijeme>curtime()) then
		signal sqlstate '45000' set message_text='Vrijeme je vece od trenutng-ne mozete unositi buduce dogadjaje.';
	end if;
    if ((select idUprava from policajac where JMB=new.JMBpolicajac limit 1)<>'ZAN') then 
		signal sqlstate '45000' set message_text='Samo policajac zandarmerije moze da unosi intervencije zandarmerije.';
	end if;
end$$
delimiter ;
    

DROP TRIGGER IF EXISTS provjeraUslovaSAJIntervencije;
delimiter $$
CREATE TRIGGER provjeraUslovaSAJIntervencije before insert on intervencijasaj
for each row
begin
	set new.IdOrganizacionaJedinica=(select idOrganizacionaJedinica from policajac where JMB=new.JMBpolicajac);
    if ((select idUprava from policajac where JMB=new.JMBpolicajac limit 1)<>'SAJ') then 
		signal sqlstate '45000' set message_text='Samo policajac antiteroristicke jedinice moze da unosi intervencije SAJ-a.';
	end if;
end$$
delimiter ;
    

DROP TRIGGER IF EXISTS provjeraUslovaHelikopterskeIntervencije;
delimiter $$
CREATE TRIGGER provjeraUslovaHelikopterskeIntervencije before insert on helikopterskaintervencija
for each row
begin
	set new.IdOrganizacionaJedinica=(select idOrganizacionaJedinica from policajac where JMB=new.JMB);
     if (new.Datum>curdate()) then
		signal sqlstate '45000' set message_text='Datum mora biti stariji ili trenutni.';
	end if;
     if (new.Datum=curdate() and new.Vrijeme>curtime()) then
		signal sqlstate '45000' set message_text='Vrijeme je vece od trenutng-ne mozete unositi buduce dogadjaje.';
	end if;
    if ((select idUprava from policajac where JMB=new.JMB limit 1)<>'HJ') then 
		signal sqlstate '45000' set message_text='Samo policajac helikopterske jedinice moze da unosi intervencije helikopterske jedinice.';
	end if;
end$$
delimiter ;
    











