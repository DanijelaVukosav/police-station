CREATE DEFINER=`root`@`localhost` PROCEDURE `provjera_ucesca_u_obuci`(in jmb decimal(13),in obuka int,out rezultat boolean)
BEGIN
	declare pom int default 0;
	select count(*) into pom from ucesniciuobuci where (ucesniciuobuci.JMB=jmb and ucesniciuobuci.idObuka=obuka);
    if pom=0 then 
		set rezultat=false;
    else 
		set rezultat=true;
	end if;
END