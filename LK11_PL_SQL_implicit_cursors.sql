PROMPT ------------------------------------------------------
PROMPT   BAZY DANYCH I - Lk_11
PROMPT        
PROMPT   Zakres SQL - DDL
PROMPT  
PROMPT   DB server: Oracle 12
PROMPT 
PROMPT   Script v. 1.1
PROMPT 
PROMPT   Copyright (c)Bart³omiej Soœniak 
PROMPT ------------------------------------------------------

PROMPT   LK11
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
PROMPT -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ##
PROMPT -- ## -- ## Lk_11 - PL-SQL3 - Kursory jawneZadanie
PROMPT -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ##

---------------------------
--  VIEW bd1_V_ROWERY_J
---------------------------	
	CREATE OR REPLACE VIEW bd1_V_ROWERY_J
	AS
	select RO_NAZWA,RO_ID_ROWERU,KA_ID_KASETY
		from bd1_ROWERY
		where RO_ID_ROWERU=2;

		column RO_NAZWA HEADING 'NAZWA ROWERU' for 9999
		column RO_ID_ROWERU HEADING 'ID ROWERU'for 9999
		column KA_ID_KASETY HEADING 'ID KASETY'for 9999

	
		
 select * from bd1_V_ROWERY_J;
/*
NAZWA ROWERU                   ID ROWERU ID KASETY
------------------------------ --------- ---------
FULL NS BIKE                           2         2

*/

---------------------------
--  VIEW bd1_V_DOSTAWCY
---------------------------	
	CREATE OR REPLACE VIEW bd1_V_DOSTAWCY_J
	AS
	select *
		from bd1_DOSTAWCY
		where DO_ID_DOSTAWCY=6;

		column DO_ID_DOSTAWCY HEADING 'ID' for 9999
	column DO_NAZWA HEADING 'NAZWA FIRMY' for A20
	column DO_NIP HEADING 'NIP' for A20
	column DO_KONTAKT HEADING 'NUMER TEL.' for A20

	
		
 select * from bd1_V_DOSTAWCY_J;

/*
 ID DO_NAZWA_FIRMY                 NIP                  NUMER TEL.
----- ------------------------------ -------------------- --------------------
    6 Orange                         121-01-22-661        orange.contact@gmail
                                                          .com
*/
---------------------------
--  PROCEDURE bd1_p_Set_ROWERY_KASETY_J
---------------------------			
CREATE OR REPLACE PROCEDURE bd1_p_Set_ROWERY_KASETY_J(
						inRO_NAZWA IN bd1_ROWERY.RO_NAZWA%TYPE, 
						inKA_ID_KASETY IN bd1_ROWERY.KA_ID_KASETY%TYPE
)
IS
	PRAGMA AUTONOMOUS_TRANSACTION; 
	--
	CURSOR curRO_NAZWA(cRO_NAZWA IN bd1_ROWERY.RO_NAZWA%TYPE)
	IS
	select * from bd1_V_ROWERY_J
		where RO_NAZWA = cRO_NAZWA
	FOR UPDATE of KA_ID_KASETY; 
	--
	wiersz bd1_V_ROWERY_J%ROWTYPE;
	--
	ile number := 0;
	status number := 0;
BEGIN
	--
	OPEN curRO_NAZWA(inRO_NAZWA);
	---
	LOOP 
	FETCH curRO_NAZWA INTO wiersz; 
		--
		-- warunek wyjœcia z pêtli
		EXIT WHEN curRO_NAZWA%NOTFOUND OR curRO_NAZWA%ROWCOUNT <1;
		--
		ile := ile + 1;
			IF wiersz.KA_ID_KASETY IS NOT NULL THEN
			--
				IF inKA_ID_KASETY IS NOT NULL then	
					--
					-- kursor niejawny
					UPDATE bd1_V_ROWERY_J set KA_ID_KASETY = inKA_ID_KASETY
					WHERE CURRENT OF curRO_NAZWA;
					-- 
					-- check update
					if SQL%FOUND THEN 
						status := status + 1; 
					ELSE 
						status := 0; 
					END IF;
				END IF;
			--
			END IF;
		--	
	END LOOP;
	--
	CLOSE curRO_NAZWA;
	--
	-- prosta obs³uga transakcji
	IF ile = status THEN
		DBMS_OUTPUT.PUT_LINE('bd1_p_Set_ROWERY_KASETY_J: COMMIT :) ');
		COMMIT;
	ELSE 
		DBMS_OUTPUT.PUT_LINE('bd1_p_Set_ROWERY_KASETY_J: ROLLBACK :( ');
		ROLLBACK;
	END IF;
END;
/

-- wywo³anie - Dodaj uwagi:
	exec bd1_p_Set_ROWERY_KASETY_J('FULL NS BIKE',21);

 select * from bd1_V_ROWERY_J;
/*
NAZWA ROWERU                   ID ROWERU ID KASETY
------------------------------ --------- ---------
FULL NS BIKE                           2         21

*/

---------------------------
--  PROCEDURE bd1_p_Set_DO_NIP
---------------------------			
CREATE OR REPLACE PROCEDURE bd1_p_Set_DO_NIP(
						inDO_ID_DOSTAWCY IN bd1_DOSTAWCY.DO_ID_DOSTAWCY%TYPE, 
						inDO_NIP IN bd1_DOSTAWCY.DO_NIP%TYPE
)
IS
	PRAGMA AUTONOMOUS_TRANSACTION; 
	--
	CURSOR curDO_ID_DOSTAWCY(cDO_ID_DOSTAWCY IN bd1_DOSTAWCY.DO_ID_DOSTAWCY%TYPE)
	IS
	select * from bd1_DOSTAWCY
		where DO_ID_DOSTAWCY = cDO_ID_DOSTAWCY
	FOR UPDATE of DO_NIP; 
	--
	wiersz bd1_DOSTAWCY%ROWTYPE;
	--
	ile number := 0;
	status number := 0;
BEGIN
	--
	OPEN curDO_ID_DOSTAWCY(inDO_ID_DOSTAWCY);
	---
	LOOP 
	FETCH curDO_ID_DOSTAWCY INTO wiersz; 
		--
		-- warunek wyjœcia z pêtli
		EXIT WHEN curDO_ID_DOSTAWCY%NOTFOUND OR curDO_ID_DOSTAWCY%ROWCOUNT <1;
		--
		ile := ile + 1;
			IF wiersz.DO_NIP IS NOT NULL THEN
			--
				IF inDO_NIP IS NOT NULL then	
					--
					-- kursor niejawny
					UPDATE bd1_DOSTAWCY set DO_NIP = inDO_NIP
					WHERE CURRENT OF curDO_ID_DOSTAWCY;
					-- 
					-- check update
					if SQL%FOUND THEN 
						status := status + 1; 
					ELSE 
						status := 0; 
					END IF;
				END IF;
			--
			END IF;
		--	
	END LOOP;
	--
	CLOSE curDO_ID_DOSTAWCY;
	--
	-- prosta obs³uga transakcji
	IF ile = status THEN
		DBMS_OUTPUT.PUT_LINE('bd1_p_Set_DO_NIP: COMMIT :) ');
		COMMIT;
	ELSE 
		DBMS_OUTPUT.PUT_LINE('bd1_p_Set_DO_NIP: ROLLBACK :( ');
		ROLLBACK;
	END IF;
END;
/
-- wywo³anie - Dodaj uwagi:
	exec bd1_p_Set_DO_NIP(6,'250-01-66-202');
	select * from bd1_V_DOSTAWCY_J;
	
	/*
   ID DO_NAZWA_FIRMY                 NIP                  NUMER TEL.
----- ------------------------------ -------------------- --------------------
    6 Orange                         250-01-66-202        orange.contact@gmail
                                                          .com
	
	*/
		
-- ## -- ## -- ## -- ## -- ## -- ## --
-- zatwierdzenie pracy w sesji
commit work;