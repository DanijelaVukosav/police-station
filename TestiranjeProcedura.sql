use policija;

select * from radarske_kazne;
call radarske_kazne_registracije('B11B111');

select * from helikopterskaintervencija;
call helikopterske_intervencije_ogranizacije('51');

select * from intervencijasaj;
insert into intervencijasaj(Naziv,Izvjestaj,idOrganizacionaJedinica,JMBpolicajac,idAdrese) values('Intervencija1','Izvjestaj','31','1111111111116','10');
call intervencije_SAJ_organizacione_jedinice('32');

select * from intervencijazandarmerije;
call intervencije_zandarmerije_organizacione_jedinice('41');

call policajci_uprave('HJ');
call policajci_uprave('SP');
call policajci_uprave('KP');


call potpisana_dokumenta_policajca('1111111111112');
call potpisana_dokumenta_policajca('1111111111118');
call potpisana_dokumenta_policajca('1111111111117');


set @rezultat=null;
call provjera_ucesca_u_obuci('1111111111115','1',@rezultat);
select @rezultat;


call radarske_kazne_registracije('A11A111');

select * from registracijavozila;
call registracije_vozila('2');

call trenutno_aktivna_registracijska_tablica('A11A111');
call trenutno_aktivna_registracijska_tablica('HEL111');
call trenutno_aktivna_registracijska_tablica('B11B111');

call trenutno_registrovana_vozila();

call ucesce_osobe_u_kriminalu('1111111111121');

call ucesce_osobe_u_saobracajnim_nesrecama('1111111111111');
call ucesce_osobe_u_saobracajnim_nesrecama('1111111111122');

call zaduzenja_oruzja_odredjenog_ID('4');

select * from policajac;
call zamjena_policajca_na_vecoj_pozociji('1111111111111','1111111111112');
select * from policajac;


call dobavljanje_radarske_kazne('1');