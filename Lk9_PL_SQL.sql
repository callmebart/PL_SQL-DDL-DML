PROMPT ------------------------------------------------------
PROMPT   BAZY DANYCH I - Lk_09
PROMPT        
PROMPT   Zakres SQL - DDL
PROMPT  
PROMPT   DB server: Oracle 12
PROMPT 
PROMPT   Script v. 1.1
PROMPT 
PROMPT   Copyright (c)Bart³omiej Soœniak 
PROMPT ------------------------------------------------------

PROMPT   LK09
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
PROMPT -- ## -- ## LAB 09 - PL-SQL   
PROMPT -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ##
/*
create table bd1_DOSTAWCY_TEST(
DO_ID_DOSTAWCY		number(8)		NOT NULL,
DO_NAZWA_FIRMY		varchar2(30),
DO_NIP		varchar2(13),
DO_KONTAKT	varchar2(30)
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
*/

---------------------------
--  PROCEDURE bd1_pINSERT_DOSTAWCY_FOR
---------------------------
column DO_ID_DOSTAWCY HEADING 'ID' for 9999
	column DO_NAZWA_FIRMY HEADING 'NAZWA FIRMY' for A20
	column DO_NIP HEADING 'NIP' for A20
	column DO_KONTAKT HEADING 'KONTAKT'  for A20
	
select * from bd1_DOSTAWCY;

CREATE OR REPLACE PROCEDURE bd1_pINSERT_DOSTAWCY_FOR(
						inDO_NAZWA_FIRMY IN bd1_DOSTAWCY.DO_NAZWA_FIRMY%TYPE, 
						inDO_NIP IN bd1_DOSTAWCY.DO_NIP%TYPE,
						inDO_KONTAKT IN bd1_DOSTAWCY.DO_KONTAKT%TYPE,
						inMnoznik IN number,
						ile IN number)
IS
	mnoznik number;
BEGIN
	IF inMnoznik < 50 THEN 
		mnoznik := 50;
	ELSIF inMnoznik > 100 and inMnoznik < 200 THEN 
		mnoznik := 100;
	ELSE 
		mnoznik := 200;
	END IF;
	--
	for licznikPETLI IN 1 .. ile
	loop
		insert into bd1_DOSTAWCY(DO_NAZWA_FIRMY,DO_NIP,DO_KONTAKT) 
		values (inDO_NAZWA_FIRMY||licznikPETLI, inDO_NIP||licznikPETLI||licznikPETLI||'-00-00', inDO_KONTAKT||licznikPETLI*mnoznik||'@gmail.com');
	end loop;
END;
/


	exec  bd1_pINSERT_DOSTAWCY_FOR('BIKES','300-','contact',45, 2);

	
/*select * from bd1_DOSTAWCY;*/

/*
   ID NAZWA FIRMY          NIP                  KONTAKT
----- -------------------- -------------------- --------------------
   21 BIKES                01                   contact
   22 BIKES                02                   contact
   23 BIKES                03                   contact
   24 BIKES                04                   contact
   25 BIKES                05                   contact
   26 BIKES1               3001                 contact1@gmail.com
   27 BIKES1               300-11-00-00         contact50@gmail.com
   28 BIKES2               300-22-00-00         contact100@gmail.com
    1 SPECJALIZED          106-00-00-062        specjalized.contact@
                                                gmail.com
*/

---------------------------
--  FUNCTION bd1_fINSERT_DOSTAWCY_FOR
---------------------------	
CREATE OR REPLACE FUNCTION bd1_fINSERT_DOSTAWCY_FOR(
						inDO_NAZWA_FIRMY IN bd1_DOSTAWCY.DO_NAZWA_FIRMY%TYPE, 
						inDO_NIP IN bd1_DOSTAWCY.DO_NIP%TYPE,
						inDO_KONTAKT IN bd1_DOSTAWCY.DO_KONTAKT%TYPE,
						inMnoznik IN number,
						ile IN number)
RETURN varchar2
IS
	mnoznik number;
	newDO_ID_DOSTAWCY bd1_DOSTAWCY.DO_ID_DOSTAWCY%TYPE;
BEGIN
	IF inMnoznik < 50 THEN 
		mnoznik := 50;
	ELSIF inMnoznik > 100 and inMnoznik < 200 THEN 
		mnoznik := 100;
	ELSE 
		mnoznik := 200;
	END IF;
	--
	for licznikPETLI IN 1 .. ile
	loop
		insert into bd1_DOSTAWCY(DO_NAZWA_FIRMY,DO_NIP,DO_KONTAKT) 
		values (inDO_NAZWA_FIRMY||licznikPETLI, inDO_NIP||licznikPETLI||licznikPETLI||'-00-00', inDO_KONTAKT||licznikPETLI*mnoznik||'@gmail.com');
		--
		SELECT SEQ_bd1_DOSTAWCY.CURRVAL INTO newDO_ID_DOSTAWCY FROM DUAL; 
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_DOSTAWCY ID='||newDO_ID_DOSTAWCY);
		--
	end loop;
	--
	RETURN 'Dodano '||ile||' wierszy';
END;
/
BEGIN
		DBMS_OUTPUT.PUT_LINE(bd1_fINSERT_DOSTAWCY_FOR('LUNA','400-','contact',45, 2));
	END;
	/

	/*
		select * from bd1_DOSTAWCY 
	*/
/*
 ID NAZWA FIRMY          NIP                  KONTAKT
--- -------------------- -------------------- --------------------
 21 BIKES                01                   contact
 22 BIKES                02                   contact
 23 BIKES                03                   contact
 24 BIKES                04                   contact
 25 BIKES                05                   contact
 26 BIKES1               3001                 contact1@gmail.com
 27 BIKES1               300-11-00-00         contact50@gmail.com
 28 BIKES2               300-22-00-00         contact100@gmail.com
 29 LUNA1                400-11-00-00         contact50@gmail.com
 30 LUNA2                400-22-00-00         contact100@gmail.com
  1 SPECJALIZED          106-00-00-062        specjalized.contact@

*/

-- ## -- ## -- ## -- ## -- ## -- ## --
-- zatwierdzenie pracy w sesji
commit work;