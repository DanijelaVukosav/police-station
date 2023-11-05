use policija;

insert into adresa (Ulica,Mjesto) values ('Ulica 1', 'Nevesinje');
insert into adresa (Ulica,Mjesto) values('Ulica 2', 'Trebinje');
insert into adresa (Ulica,Mjesto) values('Ulica 3', 'Mostar'),
('Ulica 4', 'Doboj'),
('Ulica 5', 'Bijeljina'),
('Ulica 6', 'Prijedor'),
('Ulica 7', 'Gradiska'),
('Ulica 8', 'Banja Luka'),
('Ulica 9', 'Banja Luka'),
('Ulica 10', 'Banja Luka');
select * from adresa;

insert into uprava values ('SP','Saobracajna policija'),
('KP','Kriminalistička policija'),
('SAJ','Specijalna antiteroristička jedinica'),
('ZAN','Zandarmerija'),
('HJ','Helikopterska intervencija');
select * from uprava;


insert into organizacionajedinica(idUprava,idOrganizacionaJedinica,idAdrese) values ('SP', '11','1');
insert into organizacionajedinica(idUprava,idOrganizacionaJedinica,idAdrese) values ('SP', '12','2');

insert into organizacionajedinica(idUprava,idOrganizacionaJedinica,idAdrese) values ('KP', '21','3');
insert into organizacionajedinica(idUprava,idOrganizacionaJedinica,idAdrese) values ('KP', '22','4');

insert into organizacionajedinica(idUprava,idOrganizacionaJedinica,idAdrese) values ('SAJ','31','5');
insert into organizacionajedinica(idUprava,idOrganizacionaJedinica,idAdrese) values ('SAJ','32','6');

insert into organizacionajedinica(idUprava,idOrganizacionaJedinica,idAdrese) values ('ZAN','41','7');
insert into organizacionajedinica(idUprava,idOrganizacionaJedinica,idAdrese) values ('ZAN','42','8');

insert into organizacionajedinica(idUprava,idOrganizacionaJedinica,idAdrese) values ('HJ','51','9');
insert into organizacionajedinica(idUprava,idOrganizacionaJedinica,idAdrese) values ('HJ','52','10');


select * from organizacionajedinica;



insert into osoba (JMB, Prezime, Ime,idAdrese) values ('1111111111111', 'Popović', 'Slavko', '1');
insert into osoba (JMB, Prezime, Ime,idAdrese) values ('1111111111112', 'Stojanović', 'Danijel','2');
insert into osoba  (JMB, Prezime, Ime,idAdrese) values ('1111111111113', 'Gavrić', 'Mirjana','3');
insert into osoba  (JMB, Prezime, Ime,idAdrese) values ('1111111111114', 'Mitrović', 'Nikola', '4');
insert into osoba  (JMB, Prezime, Ime,idAdrese) values ('1111111111115', 'Soldat', 'Stanko', '5');
insert into osoba  (JMB, Prezime, Ime,idAdrese) values ('1111111111116', 'Babić', 'Dejan','6');
insert into osoba (JMB, Prezime, Ime,idAdrese) values ('1111111111117', 'Mirković', 'Marko','7');
insert into osoba  (JMB, Prezime, Ime,idAdrese) values ('1111111111118', 'Janković', 'Petar','8');
insert into osoba  (JMB, Prezime, Ime,idAdrese) values ('1111111111119', 'Filipović', 'Mirko', '9');

insert into osoba  (JMB, Prezime, Ime,idAdrese) values ('1111111111120', 'Marković', 'Jovan', '1');
insert into osoba  (JMB, Prezime, Ime,idAdrese) values ('1111111111121', 'Kandić', 'Milica', '1');
insert into osoba  (JMB, Prezime, Ime,idAdrese) values ('1111111111122', 'Vujadinović', 'Daniel', '2');
insert into osoba  (JMB, Prezime, Ime,idAdrese) values ('1111111111123', 'Mitrović', 'Filip', '3');
insert into osoba  (JMB, Prezime, Ime,idAdrese) values ('1111111111124', 'Kovačević', 'Aleksa', '4');
insert into osoba  (JMB, Prezime, Ime,idAdrese) values ('1111111111125', 'Šarenac', 'Jakov', '5');

select * from osoba;


insert into vozackadozvola(JMB,BrojVozackeDozvole,DatumIzdavanja,PolozeneKategorije) values  ('1111111111120','11111120A','2018-08-10','B'),
('1111111111121','11111121B','2018-08-10','B'),
('1111111111122','11111122C','2011-09-14','AB'),
('1111111111123','11111123C','2012-11-17','ABD'),
('1111111111124','11111124B','2015-03-19','BCD'),
('1111111111125','11111125A','2016-01-25','BC');
select * from vozackadozvola;

insert into vozackadozvola(JMB,BrojVozackeDozvole,DatumIzdavanja,PolozeneKategorije) values  ('1111111111120','11111120A','2024-08-10','B');
insert into vozackadozvola(JMB,BrojVozackeDozvole,DatumIzdavanja,PolozeneKategorije) values  ('1111111111120','S1111120A','2010-08-10','B');

insert into policajac(JMB,idOrganizacionaJedinica,idUprava,Cin,Plata,JMBsefa,username) values ('1111111111111','11','SP','komadant','1500',null,'slavko');
insert into policajac(JMB,idOrganizacionaJedinica,idUprava,Cin,Plata,JMBsefa,username) values ('1111111111112','11','SP','saobracajac','1000','1111111111111','danijel');
insert into policajac(JMB,idOrganizacionaJedinica,idUprava,Cin,Plata,JMBsefa,username) values ('1111111111113','11','SP','saobracajac','1000','1111111111111','mirjana');
insert into policajac(JMB,idOrganizacionaJedinica,idUprava,Cin,Plata,JMBsefa,username) values ('1111111111114','21','KP','major','1800',null,'nikola');
insert into policajac(JMB,idOrganizacionaJedinica,idUprava,Cin,Plata,JMBsefa,username) values ('1111111111115','21','KP','major','1800','1111111111114','stanko');
insert into policajac(JMB,idOrganizacionaJedinica,idUprava,Cin,Plata,JMBsefa,username) values ('1111111111116','31','SAJ','major','1800',null,'dejan');
insert into policajac(JMB,idOrganizacionaJedinica,idUprava,Cin,Plata,username) values ('1111111111117','51','HJ','kapetan','1800','mitar');
insert into policajac(JMB,idOrganizacionaJedinica,idUprava,Cin,Plata,username) values ('1111111111118','41','ZAN','kapetan','1800','maja');

select * from policajac;
delete from oruzje where idOruzje>0;
insert into oruzje values ('1','pistolj revolver',false),
('2','poluautomatski pistolj',false),
('3','automatska puska',false),
('4','poluautomatska puska',false),
('5','puskomitraljez',false);
select * from oruzje;

insert into zaduzenje values ('1','1111111111111','2020-01-01',null);
insert into zaduzenje values ('2','1111111111111','2010-01-01','2015-01-01');
insert into zaduzenje values ('2','1111111111112','2018-01-01',null);
insert into zaduzenje values ('3','1111111111113','2019-01-01','2020-09-13');
insert into zaduzenje values ('4','1111111111114','2015-01-01',null);
insert into zaduzenje values ('3','1111111111115','2016-01-01',null);
insert into zaduzenje values ('4','1111111111116','2010-01-01','2015-01-01');
delete from zaduzenje where idOruzje>0;
select * from zaduzenje;
select * from oruzje;

insert into zaduzenje values ('1','1111111111117','2018-01-01',null);
insert into zaduzenje values ('2','1111111111118','2021-01-01','2015-01-01');



insert into kamera values ('1','Tip1'),
('2','Tip2'),
('3','Tip3'),
('4','Tip4'),
('5','Tip5');
select * from kamera;

insert into radarskakontrola(idKamere,idAdrese,Datum) values ('1','1','2021-06-06'),
('2','2','2021-03-16'),
('3','3','2021-01-23');
select * from radarskakontrola;
select * from radarskakazna;

insert into radarskakontrola(idKamere,idAdrese,Datum) values ('4','1','2022-06-06');


insert into registracijavozila(JMB,RegistracijskeTablice,TipVozila,DatumRegistracije) values('1111111111121','A11A111','Golf 4','2021-05-21'),
('1111111111122','B11B111','Mercedes c220','2021-03-29'),
('1111111111123','C11C111','Peugeot 307','2020-09-13'),
('1111111111124','A22A222','Mercedes e290','2020-12-09'),
('1111111111125','B22B222','Hyundai galloper','2021-02-11');

select * from registracijavozila;

insert into registracijavozila(JMB,RegistracijskeTablice,TipVozila,DatumRegistracije) values('1111111111123','A14A111','Golf 4','2022-06-21');
insert into registracijavozila(JMB,RegistracijskeTablice,TipVozila,DatumRegistracije) values('1111111111121','A11A111','Golf 4','2021-05-21');


insert into radarskakazna(idRadarskaKontrola,RegistracijskeTablice,Vrijeme,PrekoracenjeBrzine) values ('1','A11A111',TIME_FORMAT ('14:35', '%H:%i'),15);
insert into radarskakazna(idRadarskaKontrola,RegistracijskeTablice,Vrijeme,PrekoracenjeBrzine) values ('1','B11B111',TIME_FORMAT ('14:25', '%H:%i'),25);
insert into radarskakazna(idRadarskaKontrola,RegistracijskeTablice,Vrijeme,PrekoracenjeBrzine) values('1','C11C111',TIME_FORMAT ('14:42', '%H:%i'),30),
 ('3','A22A222',TIME_FORMAT ('09:03', '%H:%i'),18),
 ('3','B22B222',TIME_FORMAT ('09:17', '%H:%i'),21),
 ('3','B11B111',TIME_FORMAT ('09:03', '%H:%i'),11);
 insert into radarskakazna(idRadarskaKontrola,RegistracijskeTablice,Vrijeme,PrekoracenjeBrzine) values('1','C11C111',TIME_FORMAT ('15:42', '%H:%i'),20);

select * from radarskakazna;
select * from registracijavozila;
select * from vozackadozvola natural join registracijavozila;


insert into saobracajnanesreca(Vrijeme,Datum,Izvjestaj,idAdrese) values (TIME_FORMAT ('11:15', '%H:%i'),'2021-01-11','SAOBRACAJNA NESRECA 1 NA ADRESI 1','1');
insert into ucesniciusaobracajnojnesreci values ('1','1111111111111'),
('1','1111111111121');

select * from ucesniciusaobracajnojnesreci;

insert into registracijavozila(RegistracijskeTablice,TipVozila,DatumRegistracije,idPrevoznoSredstvo) values ('HEL111','Helikopter','2021-04-04','1');
insert into registracijavozila(RegistracijskeTablice,TipVozila,DatumRegistracije,idPrevoznoSredstvo) values ('HEL111','Helikopter2','2010-04-04','1');

insert into kazneninalog values ('1',TIME_FORMAT ('23:44', '%H:%i'),'2021-06-21','Prekrsaj 1 na adresi 5.','1','1111111111112','5','1111111111124');

select * from oruzje;
update zaduzenje set  DatumRazduzenja=curdate() where idOruzje='4' and DatumRazduzenja is null;
select * from zaduzenje;