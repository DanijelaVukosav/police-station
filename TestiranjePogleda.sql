use policija;

insert into zakon  values ('1', 'Prekoracenje brzine', 'Detaljan opis mogucih kazni prekoracenjem brzine.'),
('2', 'Provala', 'Detaljan opis mogucih kazni provale.'),
('3', 'Voznja u alkoholisanom stanju', 'Detaljan opis mogucih kazni.');
insert into zakon  values ('4', 'Organizovana pljacka objekta', 'Detaljan opis tacke zakona 4-Organizovana pljacka objekta');
select * from zakon;


insert into kriminalnidosije  values ('1','Detaljan izvjestaj kriminalnog dijesa broj 1.');
select * from kriminalnidosije;

insert into kriminalnipocinioci  values ('1','1111111111125');
insert into kriminalnipocinioci  values ('1','1111111111121');
insert into kriminalnipocinioci  values ('1','1111111111111'); -- ovo pokrece i triger prekidanja radnog odnosa policajca
select * from policajac;

insert into prekrsenetackezakona values ('2','1');
insert into prekrsenetackezakona values ('4','1');
select * from prekrsenetackezakona;


select * from kriminalni_dosije;


insert into helikopterskaintervencija(Naziv,Vrijeme,Datum,Izvjestaj,JMB)  values ('Intervencija1', TIME_FORMAT ('10:45', '%H:%i'),'2021-06-15', 'Izvjestaj helikopterske intervencije 1','1111111111112'); -- policajac koji ne pripada HJ
insert into helikopterskaintervencija(Naziv,Vrijeme,Datum,Izvjestaj,JMB)  values ('Intervencija1', TIME_FORMAT ('10:45', '%H:%i'),'2021-06-15', 'Izvjestaj helikopterske intervencije 1','1111111111117');

select * from helikopterskaintervencija;

insert into prevoznosredstvo(idPrevoznoSredstvo,VrstaPrevoznogSredstva,idUprava,idOrganizacionaJedinica) values ('1','helikopter1','HJ','51');
insert into prevoznosredstvo(idPrevoznoSredstvo,VrstaPrevoznogSredstva,idUprava,idOrganizacionaJedinica) values ('2','helikopter2','HJ','51');
select * from prevoznosredstvo;

insert into intervencijahelikoptera values ('1','1');
insert into intervencijahelikoptera values ('2','1');
select * from intervencijahelikoptera;

select * from helikopterske_intervencije;

insert into intervencijazandarmerije(Naziv,Datum,Vrijeme,BezbjednosnaProcjena,PlanAktivnosti,idAdrese,JMBpolicajac) values ('Intervencija1','2021-06-07',TIME_FORMAT ('17:38', '%H:%i'),'Bezbjedno','Plan aktivnosti..','1','1111111111118');
select * from intervencija_zandarmerije;

insert into intervencijazandarmerije(Naziv,Datum,Vrijeme,BezbjednosnaProcjena,PlanAktivnosti,idAdrese,JMBpolicajac) values ('Intervencija1','2031-06-07',TIME_FORMAT ('17:38', '%H:%i'),'Bezbjedno','Plan aktivnosti..','1','1111111111118');
 -- unos sa nekorektnim datumom
 
 
 insert into obuka(Naziv,PocetakObuke,KrajObuke,idUprava) values ('Obuka1','2021-01-01','2021-06-30','ZAN');
insert into obuka(Naziv,PocetakObuke,KrajObuke,idUprava) values ('Obuka1','2021-08-01','2021-06-30','ZAN'); -- pogresan datum
insert into obuka(Naziv,PocetakObuke,KrajObuke,idUprava) values ('Obuka1','2021-01-01','2021-06-30','SP'); -- pogresna uprava

select * from obuka;
insert into adrese_obuke values ('1','10');
insert into adrese_obuke values ('1','9');
select * from adrese_obuke;

insert into ucesniciuobuci values('1111111111113','1');
insert into ucesniciuobuci values('1111111111114','1');
insert into ucesniciuobuci values('1111111111115','1');
insert into ucesniciuobuci values('1111111111116','1');
select * from ucesniciuobuci;


select * from helikopterske_intervencije;
select * from intervencija_saj;
select * from intervencija_zandarmerije;
select * from kazneni_nalozi;
select * from kriminalni_dosije;
select * from kriminalni_dosije_sa_tackama_zakona;
select * from obuka_helikopterske_jedinice;
select * from obuka_policije_ukupno;
select * from obuka_zandarmerije;
select * from oduzete_vozacke_dozvole;
select * from oruzje_policije;
select * from oruzje_u_magacinu;
select * from radarske_kazne;
select * from radarske_kontrole;
select * from saobracajne_nesrece;
select * from zaduzenja_oruzja_trenutna;
select * from zaduzeno_oruzje;

