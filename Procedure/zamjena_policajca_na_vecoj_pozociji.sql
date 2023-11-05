CREATE DEFINER=`root`@`localhost` PROCEDURE `zamjena_policajca_na_vecoj_pozociji`(in JMBzamijenjenog decimal(13), in JMBzamjene decimal(13))
BEGIN
		update  policajac
        set JMBsefa=JMBzamjene
        where JMBsefa=JMBzamijenjenog;
END