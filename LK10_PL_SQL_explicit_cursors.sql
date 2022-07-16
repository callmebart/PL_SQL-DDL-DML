PROMPT ------------------------------------------------------
PROMPT   BAZY DANYCH I - Lk_10
PROMPT        
PROMPT   Zakres SQL - DDL
PROMPT  
PROMPT   DB server: Oracle 12
PROMPT 
PROMPT   Script v. 1.1
PROMPT 
PROMPT   Copyright (c)Bart³omiej Soœniak 
PROMPT ------------------------------------------------------

PROMPT   LK10
PROMPT ------------------------------------------------------

CLEAR SCREEN;
--
SET LINESIZE 350;
SET PAGESIZE 300;

show user;

-- wyswietla komunikaty zwrotne z Oracle
SET SERVEROUTPUT ON;

-- zmieñ format daty
alter session set 
	nls_date_format = 'YYYY-MM-DD HH24:MI';
--
select sysdate from dual;
--
---------------------------
--  VIEW bd1_V_OSO_MIE 
---------------------------	
	CREATE OR REPLACE VIEW bd1_V_ROWERY_KASETY
	AS
	select r.RO_NAZWA,r.RO_ID_ROWERU,k.KA_NAZWA,k.KA_ID_KASETY,k.DO_ID_DOSTAWCY
		from bd1_ROWERY r, bd1_KASETY k
		where k.DO_ID_DOSTAWCY=2;

		column RO_NAZWA HEADING 'NAZWA ROWERU' for 9999
		column RO_ID_ROWERU HEADING 'ID ROWERU'for 9999
		column KA_NAZWA HEADING 'NAZWA KASETY' for A20
		column KA_ID_KASETY HEADING 'ID KASETY'for 9999
		column DO_ID_DOSTAWCY HEADING 'DOSTAWCA' for 9999
	
		
		select * from bd1_V_ROWERY_KASETY;
/*
NAZWA ROWERU                   ID ROWERU NAZWA KASETY         ID KASETY DOSTAWCA
------------------------------ --------- -------------------- --------- --------

FULL SPEC 2021                         1 kasetaR30                   21        2
FULL NS BIKE                           2 kasetaR30                   21        2
                                       3 kasetaR30                   21        2

FULL SPEC 2021                         1 9 BIEGOWA NSBIKES            2        2
FULL NS BIKE                           2 9 BIEGOWA NSBIKES            2        2
                                       3 9 BIEGOWA NSBIKES            2        2

FULL SPEC 2021                         1 9 BIEGOWA KONA               3        2
FULL NS BIKE                           2 9 BIEGOWA KONA               3        2
*/
---------------------------
--  PROCEDURE bd1_p_INSERT_ROWERY_KASETY
---------------------------			
CREATE OR REPLACE PROCEDURE bd1_p_INSERT_ROWERY_KASETY(
inRO_NAZWA IN bd1_ROWERY.RO_NAZWA%TYPE,
inKA_NAZWA IN bd1_KASETY.KA_NAZWA%TYPE,
inKA_MAX_VALUE IN bd1_KASETY.KA_MAX_VALUE%TYPE,
inDO_ID_DOSTAWCY IN bd1_KASETY.DO_ID_DOSTAWCY%TYPE
)
IS
	PRAGMA AUTONOMOUS_TRANSACTION; 
	--
	RO_ID_ROWERU_curr	bd1_ROWERY.RO_ID_ROWERU%TYPE;
	KA_ID_KASETY_curr bd1_KASETY.KA_ID_KASETY%TYPE;
BEGIN
	-- kursor niejawny INSERT
	
	insert into bd1_KASETY (KA_NAZWA,DO_ID_DOSTAWCY,KA_MAX_VALUE)
	values (inKA_NAZWA,inDO_ID_DOSTAWCY,inKA_MAX_VALUE);
	--
		-- niebezpieczne jeœli na bazie pracuje wielu u¿ytkowników:
		SELECT SEQ_bd1_KASETY.CURRVAL INTO KA_ID_KASETY_curr FROM DUAL; 
	--
	-- kursor niejawny INSERT
	insert into bd1_ROWERY(
		RO_NAZWA,
		RA_ID_RAMY,
		AM_ID_AMORTYZATORA,
		KI_ID_KIEROWNICY,
		OB_ID_OBRECZY,
		OP_ID_OPONY,
		MA_ID_MANETKI,
		KA_ID_KASETY,
		ZE_ID_ZEBATKI,
		LA_ID_LANCUCHU,
		SI_ID_SIODELKA,
		SZ_ID_SZTYCY
	)
	values (inRO_NAZWA,1,1,1,1,1,1,KA_ID_KASETY_curr,1,1,1,1);
	--
		-- niebezpieczne jeœli na bazie pracuje wielu u¿ytkowników:
		SELECT SEQ_bd1_ROWERY.CURRVAL INTO RO_ID_ROWERU_curr FROM DUAL;
	--
	DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz bd1_ROWERY - ID='||RO_ID_ROWERU_curr);
	--
	DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz bd1_KASETY - ID='||KA_ID_KASETY_curr);
	--
	-- prosta obs³uga transakcji
	IF RO_ID_ROWERU_curr > 0 and KA_ID_KASETY_curr > 0 THEN 
		COMMIT;
	ELSE 
		ROLLBACK;
	END IF;
	--
END;
/

exec bd1_p_INSERT_ROWERY_KASETY('spec20','kasetaR30',8,2);

/*
NAZWA ROWERU                   ID ROWERU NAZWA KASETY         ID KASETY DOSTAWCA
------------------------------ --------- -------------------- --------- --------
spec20                                21 kasetaR30                   21        2
FULL SPEC 2021                         1 kasetaR30                   21        2
FULL NS BIKE                           2 kasetaR30                   21        2
                                       3 kasetaR30                   21        2
spec20                                21 9 BIEGOWA NSBIKES            2        2
FULL SPEC 2021                         1 9 BIEGOWA NSBIKES            2        2
FULL NS BIKE                           2 9 BIEGOWA NSBIKES            2        2
                                       3 9 BIEGOWA NSBIKES            2        2
spec20                                21 9 BIEGOWA KONA               3        2
FULL SPEC 2021                         1 9 BIEGOWA KONA               3        2
FULL NS BIKE                           2 9 BIEGOWA KONA               3        2       
*/

---------------------------
--  KURSOR NIEJAWNY
--  RETURNING
---------------------------

---------------------------
--  PROCEDURE bd1_p_INSERT_OSO_MIE_RET
---------------------------			
CREATE OR REPLACE PROCEDURE bd1_p_INSERT_ROWERY_KASETY_RET(
inRO_NAZWA IN bd1_ROWERY.RO_NAZWA%TYPE,
inKA_NAZWA IN bd1_KASETY.KA_NAZWA%TYPE,
inKA_MAX_VALUE IN bd1_KASETY.KA_MAX_VALUE%TYPE,
inDO_ID_DOSTAWCY IN bd1_KASETY.DO_ID_DOSTAWCY%TYPE
)
IS
	PRAGMA AUTONOMOUS_TRANSACTION; 
	--
	RO_ID_ROWERU_curr	bd1_ROWERY.RO_ID_ROWERU%TYPE;
	KA_ID_KASETY_curr bd1_KASETY.KA_ID_KASETY%TYPE;
BEGIN
	-- kursor niejawny INSERT
	
	insert into bd1_KASETY (KA_NAZWA,DO_ID_DOSTAWCY,KA_MAX_VALUE)
	values (inKA_NAZWA,inDO_ID_DOSTAWCY,inKA_MAX_VALUE)
	RETURNING KA_ID_KASETY
	INTO KA_ID_KASETY_curr; 
	--
	if SQL%FOUND then 
		-- kursor niejawny INSERT
		insert into bd1_ROWERY(
		RO_NAZWA,
		RA_ID_RAMY,
		AM_ID_AMORTYZATORA,
		KI_ID_KIEROWNICY,
		OB_ID_OBRECZY,
		OP_ID_OPONY,
		MA_ID_MANETKI,
		KA_ID_KASETY,
		ZE_ID_ZEBATKI,
		LA_ID_LANCUCHU,
		SI_ID_SIODELKA,
		SZ_ID_SZTYCY
	)
	values (inRO_NAZWA,2,2,2,2,2,2,KA_ID_KASETY_curr,2,2,2,2)
		RETURNING RO_ID_ROWERU
		INTO RO_ID_ROWERU_curr;
		--
			if SQL%FOUND then
				DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz bd1_ROWERY - ID='||RO_ID_ROWERU_curr);
	--
				DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz bd1_KASETY - ID='||KA_ID_KASETY_curr);
				--
				COMMIT;
			ELSE
				DBMS_OUTPUT.PUT_LINE('Procedura bd1_p_INSERT_ROWERY_KASETY_RET - ERROR!');
				ROLLBACK;
			END IF;
		--		
	ELSE
		ROLLBACK;
	END IF;	
	--
END;
/
exec bd1_p_INSERT_ROWERY_KASETY_RET('spec40_RET','kasetaA450RET',6,2);

select * from bd1_V_ROWERY_KASETY where RO_NAZWA like 'spec40_RET';
/*
NAZWA ROWERU                   ID ROWERU NAZWA KASETY         ID KASETY DOSTAWCA
------------------------------ --------- -------------------- --------- --------
spec40_RET                            22 kasetaA450RET               22        2
*/
-- ## -- ## -- ## -- ## -- ## -- ## --
-- zatwierdzenie pracy w sesji
commit work;