PROMPT ------------------------------------------------------
PROMPT   BAZY DANYCH I - Lk_03
PROMPT        
PROMPT   Zakres SQL - DDL
PROMPT  
PROMPT   DB server: Oracle 12c
PROMPT 
PROMPT   Script v. 1.1
PROMPT 
PROMPT   Copyright (c)Bartłomiej Sośniak 
PROMPT ------------------------------------------------------

PROMPT   LK05
PROMPT ------------------------------------------------------

CLEAR SCREEN;
--
SET LINESIZE 350;
SET PAGESIZE 300;


SPOOL "D:\Student\BartekSosniak 13K3\Lk_03.out.txt"

show user;

-- wyswietla komunikaty zwrotne z Oracle
SET SERVEROUTPUT ON;

-- zmień format daty
alter session set 
	nls_date_format = 'YYYY-MM-DD HH24:MI';

--
select sysdate from dual;
--



---------------------------
PROMPT   sekwencja kasowania
---------------------------
drop table bd1_ROWERY;
drop table bd1_RAMY;
drop table bd1_AMORTYZATORY;
drop table bd1_KIEROWNICE;
drop table bd1_OBRECZE;
drop table bd1_OPONY;
drop table bd1_MANETKI;
drop table bd1_KASETY;
drop table bd1_ZEBATKI;
drop table bd1_LANCUCHY;
drop table bd1_SIODELKA;
drop table bd1_SZTYCE;
drop table bd1_DOSTAWCY;


PROMPT ---------------------------
PROMPT   DDL create table
PROMPT ---------------------------	

---------------------------
PROMPT   table bd1_DOSTAWCY
---------------------------	
create table bd1_DOSTAWCY (
DO_ID_DOSTAWCY		number(8)		NOT NULL,
DO_NAZWA_FIRMY		varchar2(30),
DO_NIP		varchar2(13),
DO_KONTAKT	varchar2(30)
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_DOSTAWCY
		ADD CONSTRAINT PK_bd1_DOSTAWCY	
		PRIMARY KEY (DO_ID_DOSTAWCY) ;
		
------------------------
-- SEQUENCE
------------------------		
	drop sequence SEQ_bd1_DOSTAWCY;
	
	CREATE SEQUENCE SEQ_bd1_DOSTAWCY
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
------------------------
-- TRIGGER
------------------------
	CREATE OR REPLACE TRIGGER T_BI_bd1_DOSTAWCY
	BEFORE INSERT ON bd1_DOSTAWCY
	FOR EACH ROW
	BEGIN
		IF :NEW.DO_ID_DOSTAWCY IS NULL THEN
			SELECT SEQ_bd1_DOSTAWCY.NEXTVAL 
				INTO :NEW.DO_ID_DOSTAWCY FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_DOSTAWCY - DO_ID_DOSTAWCY='||:NEW.DO_ID_DOSTAWCY);
		--
	END;
	/
------------------------
-- DML bd1_DOSTAWCY
------------------------
	insert into bd1_DOSTAWCY (DO_NAZWA_FIRMY,DO_NIP,DO_KONTAKT)
	values ('SPECJALIZED','106-00-00-062','specjalized.contact@gmail.com');
	
	insert into bd1_DOSTAWCY (DO_NAZWA_FIRMY,DO_NIP,DO_KONTAKT)
	values ('NSBIKES','107-00-11-034','NSBIKES.contact@gmail.com');
	
	insert into bd1_DOSTAWCY (DO_NAZWA_FIRMY,DO_NIP,DO_KONTAKT)
	values ('KONA','190-34-22-035','KONA.contact@gmail.com');
	
	insert into bd1_DOSTAWCY (DO_NAZWA_FIRMY,DO_NIP,DO_KONTAKT)
	values ('Kross','190-34-22-035','');
	
	column DO_ID_DOSTAWCY HEADING 'ID' for 999999
	column DO_NAZWA HEADING 'NAZWA FIRMY' for A20
	column DO_NIP HEADING 'NIP' for 999999
	column DO_KONTAKT HEADING 'NUMER TEL.' for 999999 
	
	-- ile wierszy
	select count(*) from bd1_DOSTAWCY;

	-- szybciej:
	select count(DO_ID_DOSTAWCY) from bd1_DOSTAWCY;

	select * from bd1_DOSTAWCY;
	
	/*
	 ID DO_NAZWA_FIRMY                 NIP           NUMER TEL.
------- ------------------------------ ------------- ------------------------------
      1 SPECJALIZED                    106-00-00-062 specjalized.contact@gmail.com
	*/
	
---------------------------
PROMPT   table bd1_SZTYCE
---------------------------	
create table bd1_SZTYCE (
SZ_ID_SZTYCY			number(8)		NOT NULL,
SZ_NAZWA		varchar2(30)	,
DO_ID_DOSTAWCY 	number(8)	NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_SZTYCE
		ADD CONSTRAINT PK_bd1_SZTYCY	
		PRIMARY KEY (SZ_ID_SZTYCY) ;
	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_SZTYCE
		ADD CONSTRAINT FK1_bd1_DOSTAWCY
		FOREIGN KEY(DO_ID_DOSTAWCY) 
		REFERENCES bd1_DOSTAWCY(DO_ID_DOSTAWCY) ENABLE;

------------------------
-- SEQUENCE
------------------------		
	drop sequence SEQ_bd1_SZTYCE;
	
	CREATE SEQUENCE SEQ_bd1_SZTYCE
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
------------------------
-- TRIGGER
------------------------
	CREATE OR REPLACE TRIGGER T_BI_bd1_SZTYCE
	BEFORE INSERT ON bd1_SZTYCE
	FOR EACH ROW
	BEGIN
		IF :NEW.SZ_ID_SZTYCY IS NULL THEN
			SELECT SEQ_bd1_SZTYCE.NEXTVAL 
				INTO :NEW.SZ_ID_SZTYCY FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_SZTYCE - SZ_ID_SZTYCY='||:NEW.SZ_ID_SZTYCY);
		--
	END;
	/
------------------------
-- DML bd1_SZTYCE
------------------------
	insert into bd1_SZTYCE (SZ_NAZWA,DO_ID_DOSTAWCY)
	values ('13K3ULTRA_WNEOM',1);
	
		insert into bd1_SZTYCE (SZ_NAZWA,DO_ID_DOSTAWCY)
	values ('softRide',2);
	
		insert into bd1_SZTYCE (SZ_NAZWA,DO_ID_DOSTAWCY)
	values ('alturaS',3);
	
	column SZ_ID_SZTYCY HEADING 'ID' for 999999
	column SZ_NAZWA HEADING 'NAZWA SZTYCY' for A20
	column DO_ID_DOSTAWCY HEADING 'DOSTAWCA ID' for 999999
	
	-- ile wierszy
	select count(*) from bd1_SZTYCE;

	-- szybciej:
	select count(SZ_ID_SZTYCY) from bd1_SZTYCE;

	select * from bd1_SZTYCE;
		
	/*
ID NAZWA SZTYCY         DOSTAWCA ID
------- -------------------- -----------
      1 13K3ULTRA_WNEOM                1


	*/	
		
---------------------------
PROMPT   table bd1_SIODELKA
---------------------------	
create table bd1_SIODELKA (
SI_ID_SIODELKA			number(8)		NOT NULL,
SI_NAZWA		varchar2(30)	,
DO_ID_DOSTAWCY 	number(8)	NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;

------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_SIODELKA
		ADD CONSTRAINT PK_bd1_SIODELKA	
		PRIMARY KEY (SI_ID_SIODELKA) ;
	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_SIODELKA
		ADD CONSTRAINT FK2_bd1_DOSTAWCY
		FOREIGN KEY(DO_ID_DOSTAWCY) 
		REFERENCES bd1_DOSTAWCY(DO_ID_DOSTAWCY) ENABLE;
		
------------------------
-- SEQUENCE
------------------------		
	drop sequence SEQ_bd1_SIODELKA;
	
	CREATE SEQUENCE SEQ_bd1_SIODELKA
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
------------------------
-- TRIGGER
------------------------
	CREATE OR REPLACE TRIGGER T_BI_bd1_SIODELKA
	BEFORE INSERT ON bd1_SIODELKA
	FOR EACH ROW
	BEGIN
		IF :NEW.SI_ID_SIODELKA IS NULL THEN
			SELECT SEQ_bd1_SIODELKA.NEXTVAL 
				INTO :NEW.SI_ID_SIODELKA FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_SIODELKA - SI_ID_SIODELKA='||:NEW.SI_ID_SIODELKA);
		--
	END;
	/
------------------------
-- DML bd1_SIODELKA
------------------------
	insert into bd1_SIODELKA (SI_NAZWA,DO_ID_DOSTAWCY)
	values ('SPCJALIZED_HARD_TRUCK',1);
	
	insert into bd1_SIODELKA (SI_NAZWA,DO_ID_DOSTAWCY)
	values ('SPCJALIZED_SOFT_TRUCK',1);
	
	insert into bd1_SIODELKA (SI_NAZWA,DO_ID_DOSTAWCY)
	values ('NSBIKES_RIDEME',2);
	
		insert into bd1_SIODELKA (SI_NAZWA,DO_ID_DOSTAWCY)
	values ('',2);
	
	column SI_ID_SIODELKA HEADING 'ID' for 999999
	column SI_NAZWA HEADING 'NAZWA SIODELKA' for A20
	column DO_ID_DOSTAWCY HEADING 'DOSTAWCA ID' for 999999
	
	-- ile wierszy
	select count(*) from bd1_SIODELKA;

	-- szybciej:
	select count(SI_ID_SIODELKA) from bd1_SIODELKA;

	select * from bd1_SIODELKA;

	/*
	  ID NAZWA SIODELKA      DOSTAWCA ID
------- -------------------- -----------
      1 SPCJALIZED_HARD_TRUC           1
        K
	*/
	
---------------------------
PROMPT   table bd1_LANCUCHY
---------------------------	
create table bd1_LANCUCHY (
LA_ID_LANCUCHU			number(8)		NOT NULL,
LA_NAZWA		varchar2(30)	,
DO_ID_DOSTAWCY 	number(8)	NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;


------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_LANCUCHY
		ADD CONSTRAINT PK_bd1_LANCUCHY	
		PRIMARY KEY (LA_ID_LANCUCHU) ;
	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_LANCUCHY
		ADD CONSTRAINT  FK3_bd1_DOSTAWCY
		FOREIGN KEY(DO_ID_DOSTAWCY) 
		REFERENCES bd1_DOSTAWCY(DO_ID_DOSTAWCY) ENABLE;

------------------------
-- SEQUENCE
------------------------		
	drop sequence SEQ_bd1_LANCUCHY;
	
	CREATE SEQUENCE SEQ_bd1_LANCUCHY
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
------------------------
-- TRIGGER
------------------------
	CREATE OR REPLACE TRIGGER T_BI_bd1_LANCUCHY
	BEFORE INSERT ON bd1_LANCUCHY
	FOR EACH ROW
	BEGIN
		IF :NEW.LA_ID_LANCUCHU IS NULL THEN
			SELECT SEQ_bd1_LANCUCHY.NEXTVAL 
				INTO :NEW.LA_ID_LANCUCHU FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_LANCUCHY - LA_ID_LANCUCHU='||:NEW.LA_ID_LANCUCHU);
		--
	END;
	/
------------------------
-- DML bd1_LANCUCHY
------------------------
	insert into bd1_LANCUCHY (LA_NAZWA,DO_ID_DOSTAWCY)
	values ('SPCJALIZED_TRUCK_CHAIN',1);
	
		insert into bd1_LANCUCHY (LA_NAZWA,DO_ID_DOSTAWCY)
	values ('NSBIKES_TRUCK_CHAIN',2);
	
		insert into bd1_LANCUCHY (LA_NAZWA,DO_ID_DOSTAWCY)
	values ('KONA_LONG_CHAIN',3);
	
	column LA_ID_LANCUCHU HEADING 'ID' for 999999
	column LA_NAZWA HEADING 'NAZWA LANCUCHU' for A20
	column DO_ID_DOSTAWCY HEADING 'DOSTAWCA ID' for 999999
	
	-- ile wierszy
	select count(*) from bd1_LANCUCHY;

	-- szybciej:
	select count(LA_ID_LANCUCHU) from bd1_LANCUCHY;

	select * from bd1_LANCUCHY;
		
	/*
	 ID NAZWA LANCUCHU       DOSTAWCA ID
------- -------------------- -----------
      1 SPCJALIZED_TRUCK_CHA           1
        IN
	*/	
---------------------------
PROMPT   table bd1_ZEBATKI
---------------------------	
create table bd1_ZEBATKI (
ZE_ID_ZEBATKI			number(8)		NOT NULL,
ZE_NAZWA		varchar2(30)	,
DO_ID_DOSTAWCY 	number(8)	NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_ZEBATKI
		ADD CONSTRAINT PK_bd1_ZEBATKI	
		PRIMARY KEY (ZE_ID_ZEBATKI) ;
	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_ZEBATKI
		ADD CONSTRAINT  FK4_bd1_DOSTAWCY
		FOREIGN KEY(DO_ID_DOSTAWCY) 
		REFERENCES bd1_DOSTAWCY(DO_ID_DOSTAWCY) ENABLE;

------------------------
-- SEQUENCE
------------------------		
	drop sequence SEQ_bd1_ZEBATKI;
	
	CREATE SEQUENCE SEQ_bd1_ZEBATKI
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
------------------------
-- TRIGGER
------------------------
	CREATE OR REPLACE TRIGGER T_BI_bd1_ZEBATKI
	BEFORE INSERT ON bd1_ZEBATKI
	FOR EACH ROW
	BEGIN
		IF :NEW.ZE_ID_ZEBATKI IS NULL THEN
			SELECT SEQ_bd1_ZEBATKI.NEXTVAL 
				INTO :NEW.ZE_ID_ZEBATKI FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_ZEBATKI- ZE_ID_ZEBATKI='||:NEW.ZE_ID_ZEBATKI);
		--
	END;
	/
------------------------
-- DML bd1_ZEBATKI
------------------------
	insert into bd1_ZEBATKI (ZE_NAZWA,DO_ID_DOSTAWCY)
	values ('9 k13',1);
	insert into bd1_ZEBATKI (ZE_NAZWA,DO_ID_DOSTAWCY)
	values ('9 speed',2);
	insert into bd1_ZEBATKI (ZE_NAZWA,DO_ID_DOSTAWCY)
	values ('9 grade',3);
	insert into bd1_ZEBATKI (ZE_NAZWA,DO_ID_DOSTAWCY)
	values ('',3);
	
	column ZE_ID_ZEBATKI HEADING 'ID' for 999999
	column ZE_NAZWA HEADING 'NAZWA ZEBATKI' for A20
	column DO_ID_DOSTAWCY HEADING 'DOSTAWCA ID' for 999999
	
	-- ile wierszy
	select count(*) from bd1_ZEBATKI;

	-- szybciej:
	select count(ZE_ID_ZEBATKI) from bd1_ZEBATKI;

	select * from bd1_ZEBATKI;

/*
 ID 	NAZWA ZEBATKI       DOSTAWCA ID
------- -------------------- -----------
      1 9 k13                          1

*/	
		
---------------------------
PROMPT   table bd1_KASETY
---------------------------	
create table bd1_KASETY (
KA_ID_KASETY			number(8)		NOT NULL,
KA_NAZWA		varchar2(30)	,
DO_ID_DOSTAWCY 	number(8)	NOT NULL,
KA_MAX_VALUE number(8) 
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_KASETY
		ADD CONSTRAINT PK_bd1_KASETY	
		PRIMARY KEY (KA_ID_KASETY) ;
	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_KASETY
		ADD CONSTRAINT  FK5_bd1_DOSTAWCY
		FOREIGN KEY(DO_ID_DOSTAWCY) 
		REFERENCES bd1_DOSTAWCY(DO_ID_DOSTAWCY) ENABLE;

------------------------
-- SEQUENCE
------------------------		
	drop sequence SEQ_bd1_KASETY;
	
	CREATE SEQUENCE SEQ_bd1_KASETY
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
------------------------
-- TRIGGER
------------------------
	CREATE OR REPLACE TRIGGER T_BI_bd1_KASETY
	BEFORE INSERT ON bd1_KASETY
	FOR EACH ROW
	BEGIN
		IF :NEW.KA_ID_KASETY IS NULL THEN
			SELECT SEQ_bd1_KASETY.NEXTVAL 
				INTO :NEW.KA_ID_KASETY FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_KASETY- KA_ID_KASETY='||:NEW.KA_ID_KASETY);
		--
	END;
	/
------------------------
-- DML bd1_KASETY
------------------------
	insert into bd1_KASETY (KA_NAZWA,DO_ID_DOSTAWCY,KA_MAX_VALUE)
	values ('9 BIEGOWA SPEC K13',1,9);
	
	insert into bd1_KASETY (KA_NAZWA,DO_ID_DOSTAWCY,KA_MAX_VALUE)
	values ('9 BIEGOWA NSBIKES',2,12);
	
	insert into bd1_KASETY (KA_NAZWA,DO_ID_DOSTAWCY,KA_MAX_VALUE)
	values ('9 BIEGOWA KONA ',2,9);
	
	column KA_ID_KASETY HEADING 'ID' for 999999
	column KA_NAZWA HEADING 'NAZWA KASETY' for A20
	column DO_ID_DOSTAWCY HEADING 'DOSTAWCA ID' for 999999
	
	-- ile wierszy
	select count(*) from bd1_KASETY;

	-- szybciej:
	select count(KA_ID_KASETY) from bd1_KASETY;

	select * from bd1_KASETY;
		
/*
  ID 	NAZWA KASETY         DOSTAWCA ID
------- -------------------- -----------
      1 9 BIEGOWA SPEC K13             1
*/
		
---------------------------
PROMPT   table bd1_MANETKI
---------------------------	
create table bd1_MANETKI (
MA_ID_MANETKI			number(8)		NOT NULL,
MA_NAZWA		varchar2(30)	,
DO_ID_DOSTAWCY 	number(8)	NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_MANETKI
		ADD CONSTRAINT PK_bd1_MANETKI	
		PRIMARY KEY (MA_ID_MANETKI) ;
	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_MANETKI
		ADD CONSTRAINT  FK6_bd1_DOSTAWCY
		FOREIGN KEY(DO_ID_DOSTAWCY) 
		REFERENCES bd1_DOSTAWCY(DO_ID_DOSTAWCY) ENABLE;		
		

------------------------
-- SEQUENCE
------------------------		
	drop sequence SEQ_bd1_MANETKI;
	
	CREATE SEQUENCE SEQ_bd1_MANETKI
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
------------------------
-- TRIGGER
------------------------
	CREATE OR REPLACE TRIGGER T_BI_bd1_MANETKI
	BEFORE INSERT ON bd1_MANETKI
	FOR EACH ROW
	BEGIN
		IF :NEW.MA_ID_MANETKI IS NULL THEN
			SELECT SEQ_bd1_MANETKI.NEXTVAL 
				INTO :NEW.MA_ID_MANETKI FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_MANETKI- MA_ID_MANETKI='||:NEW.MA_ID_MANETKI);
		--
	END;
	/
------------------------
-- DML bd1_MANETKI
------------------------
	insert into bd1_MANETKI (MA_NAZWA,DO_ID_DOSTAWCY)
	values ('9 BIEGOWA SPEC K13',1);
	
	insert into bd1_MANETKI (MA_NAZWA,DO_ID_DOSTAWCY)
	values ('9 BIEGOWA NSBIKES K13',2);
	
	insert into bd1_MANETKI (MA_NAZWA,DO_ID_DOSTAWCY)
	values ('9 BIEGOWA KONA K13',3);
	
	column MA_ID_MANETKI HEADING 'ID' for 999999
	column MA_NAZWA HEADING 'NAZWA MANETKI' for A20
	column DO_ID_DOSTAWCY HEADING 'DOSTAWCA ID' for 999999
	
	-- ile wierszy
	select count(*) from bd1_MANETKI;

	-- szybciej:
	select count(MA_ID_MANETKI) from bd1_MANETKI;

	select * from bd1_MANETKI;		
		
/*
 ID      NAZWA MANETKI       DOSTAWCA ID
------- -------------------- -----------
      1 9 BIEGOWA SPEC K13             1
*/
---------------------------
PROMPT   table bd1_OPONY
---------------------------	
create table bd1_OPONY (
OP_ID_OPONY			number(8)		NOT NULL,
OP_NAZWA		varchar2(30)	,
DO_ID_DOSTAWCY 	number(8)	NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_OPONY
		ADD CONSTRAINT PK_bd1_OPONY	
		PRIMARY KEY (OP_ID_OPONY) ;
	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_OPONY
		ADD CONSTRAINT  FK7_bd1_DOSTAWCY
		FOREIGN KEY(DO_ID_DOSTAWCY) 
		REFERENCES bd1_DOSTAWCY(DO_ID_DOSTAWCY) ENABLE;		
		
------------------------
-- SEQUENCE
------------------------		
	drop sequence SEQ_bd1_OPONY;
	
	CREATE SEQUENCE SEQ_bd1_OPONY
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
------------------------
-- TRIGGER
------------------------
	CREATE OR REPLACE TRIGGER T_BI_bd1_OPONY
	BEFORE INSERT ON bd1_OPONY
	FOR EACH ROW
	BEGIN
		IF :NEW.OP_ID_OPONY IS NULL THEN
			SELECT SEQ_bd1_OPONY.NEXTVAL 
				INTO :NEW.OP_ID_OPONY FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_OPONY- OP_ID_OPONY='||:NEW.OP_ID_OPONY);
		--
	END;
	/
------------------------
-- DML bd1_OPONY
------------------------
	insert into bd1_OPONY (OP_NAZWA,DO_ID_DOSTAWCY)
	values ('SPECJALIZED 29 MAX',1);
	
	insert into bd1_OPONY (OP_NAZWA,DO_ID_DOSTAWCY)
	values ('NSBIKES 26 ',2);
	
	insert into bd1_OPONY (OP_NAZWA,DO_ID_DOSTAWCY)
	values ('KONA 27.5',3);
	
	column OP_ID_OPONY HEADING 'ID' for 999999
	column OP_NAZWA HEADING 'NAZWA OPONY' for A20
	column DO_ID_DOSTAWCY HEADING 'DOSTAWCA ID' for 999999
	
	-- ile wierszy
	select count(*) from bd1_OPONY;

	-- szybciej:
	select count(OP_ID_OPONY) from bd1_OPONY;

	select * from bd1_OPONY;		
		
/*
ID       NAZWA OPONY          DOSTAWCA ID
------- -------------------- -----------
      1 SPECJALIZED 29 MAX             1
*/	
---------------------------
PROMPT   table bd1_OBRECZE
---------------------------	
create table bd1_OBRECZE (
OB_ID_OBRECZY			number(8)		NOT NULL,
OB_NAZWA		varchar2(30)	,
DO_ID_DOSTAWCY 	number(8)	NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_OBRECZE
		ADD CONSTRAINT PK_bd1_OBRECZE
		PRIMARY KEY ( OB_ID_OBRECZY) ;
	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_OBRECZE
		ADD CONSTRAINT  FK8_bd1_DOSTAWCY
		FOREIGN KEY(DO_ID_DOSTAWCY) 
		REFERENCES bd1_DOSTAWCY(DO_ID_DOSTAWCY) ENABLE;		

		------------------------
-- SEQUENCE
------------------------		
	drop sequence SEQ_bd1_OBRECZE;
	
	CREATE SEQUENCE SEQ_bd1_OBRECZE
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
------------------------
-- TRIGGER
------------------------
	CREATE OR REPLACE TRIGGER T_BI_bd1_OBRECZE
	BEFORE INSERT ON bd1_OBRECZE
	FOR EACH ROW
	BEGIN
		IF :NEW.OB_ID_OBRECZY IS NULL THEN
			SELECT SEQ_bd1_OBRECZE.NEXTVAL 
				INTO :NEW.OB_ID_OBRECZY FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_OBRECZE- OB_ID_OBRECZY='||:NEW.OB_ID_OBRECZY);
		--
	END;
	/
------------------------
-- DML bd1_OBRECZE
------------------------
	insert into bd1_OBRECZE (OB_NAZWA,DO_ID_DOSTAWCY)
	values ('SPECJALIZED 29 MAX',1);
	
	insert into bd1_OBRECZE (OB_NAZWA,DO_ID_DOSTAWCY)
	values ('NSBIKES 26 MAX',2);
	
	insert into bd1_OBRECZE (OB_NAZWA,DO_ID_DOSTAWCY)
	values ('KONA 27.5 MAX',3);
	
	column OB_ID_OBRECZY HEADING 'ID' for 999999
	column OB_NAZWA HEADING 'NAZWA OBRĘCZY' for A20
	column DO_ID_DOSTAWCY HEADING 'DOSTAWCA ID' for 999999
	
	-- ile wierszy
	select count(*) from bd1_OBRECZE;

	-- szybciej:
	select count(OB_ID_OBRECZY) from bd1_OBRECZE;

	select * from bd1_OBRECZE;	
	
	
/*
ID       NAZWA OBR─śCZY       DOSTAWCA ID
------- -------------------- -----------
      1 SPECJALIZED 29 MAX             1
*/
---------------------------
PROMPT   table bd1_KIEROWNICE
---------------------------	
create table bd1_KIEROWNICE (
KI_ID_KIEROWNICY			number(8)		NOT NULL,
KI_NAZWA		varchar2(30)	,
DO_ID_DOSTAWCY 	number(8)	NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_KIEROWNICE
		ADD CONSTRAINT PK_bd1_KIEROWNICE
		PRIMARY KEY ( KI_ID_KIEROWNICY) ;
	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_KIEROWNICE
		ADD CONSTRAINT  FK9_bd1_DOSTAWCY
		FOREIGN KEY(DO_ID_DOSTAWCY) 
		REFERENCES bd1_DOSTAWCY(DO_ID_DOSTAWCY) ENABLE;

------------------------
-- SEQUENCE
------------------------		
	drop sequence SEQ_bd1_KIEROWNICE;
	
	CREATE SEQUENCE SEQ_bd1_KIEROWNICE
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
------------------------
-- TRIGGER
------------------------
	CREATE OR REPLACE TRIGGER T_BI_bd1_KIEROWNICE
	BEFORE INSERT ON bd1_KIEROWNICE
	FOR EACH ROW
	BEGIN
		IF :NEW.KI_ID_KIEROWNICY IS NULL THEN
			SELECT SEQ_bd1_KIEROWNICE.NEXTVAL 
				INTO :NEW.KI_ID_KIEROWNICY FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_KIEROWNICE- KI_ID_KIEROWNICY='||:NEW.KI_ID_KIEROWNICY);
		--
	END;
	/
------------------------
-- DML bd1_KIEROWNICE 
------------------------
	insert into bd1_KIEROWNICE (KI_NAZWA,DO_ID_DOSTAWCY)
	values ('FATBAR 800MM',1);
	
	insert into bd1_KIEROWNICE (KI_NAZWA,DO_ID_DOSTAWCY)
	values ('NS 750MM',2);
	
		insert into bd1_KIEROWNICE (KI_NAZWA,DO_ID_DOSTAWCY)
	values ('kona 810MM',3);
	
	column KI_ID_KIEROWNICY HEADING 'ID' for 999999
	column KI_NAZWA HEADING 'NAZWA KIEROWNICY' for A20
	column DO_ID_DOSTAWCY HEADING 'DOSTAWCA ID' for 999999
	
	-- ile wierszy
	select count(*) from bd1_KIEROWNICE;

	-- szybciej:
	select count(KI_ID_KIEROWNICY) from bd1_KIEROWNICE;

	select * from bd1_KIEROWNICE;	

/*
 ID 	NAZWA KIEROWNICY     DOSTAWCA ID
------- -------------------- -----------
      1 FATBAR 800MM                   1
*/
---------------------------
PROMPT   table bd1_AMORTYZATORY
---------------------------	
create table bd1_AMORTYZATORY(
AM_ID_AMORTYZATORA			number(8)		NOT NULL,
AM_NAZWA		varchar2(30)	,
DO_ID_DOSTAWCY 	number(8)	NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_AMORTYZATORY
		ADD CONSTRAINT PK_bd1_AMORTYZATORY
		PRIMARY KEY ( AM_ID_AMORTYZATORA) ;
	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_AMORTYZATORY
		ADD CONSTRAINT  FK10_bd1_DOSTAWCY
		FOREIGN KEY(DO_ID_DOSTAWCY) 
		REFERENCES bd1_DOSTAWCY(DO_ID_DOSTAWCY) ENABLE;
		
------------------------
-- SEQUENCE
------------------------		
	drop sequence SEQ_bd1_AMORTYZATORY;
	
	CREATE SEQUENCE SEQ_bd1_AMORTYZATORY
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
------------------------
-- TRIGGER
------------------------
	CREATE OR REPLACE TRIGGER T_BI_bd1_AMORTYZATORY
	BEFORE INSERT ON bd1_AMORTYZATORY
	FOR EACH ROW
	BEGIN
		IF :NEW.AM_ID_AMORTYZATORA IS NULL THEN
			SELECT SEQ_bd1_AMORTYZATORY.NEXTVAL 
				INTO :NEW.AM_ID_AMORTYZATORA FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_AMORTYZATORY- AM_ID_AMORTYZATORA='||:NEW.AM_ID_AMORTYZATORA);
		--
	END;
	/
------------------------
-- DML bd1_AMORTYZATORY
------------------------
	insert into bd1_AMORTYZATORY (AM_NAZWA,DO_ID_DOSTAWCY)
	values ('FOX TOTEM',1);
	
	insert into bd1_AMORTYZATORY (AM_NAZWA,DO_ID_DOSTAWCY)
	values ('NS FUZZ',2);
	
	insert into bd1_AMORTYZATORY (AM_NAZWA,DO_ID_DOSTAWCY)
	values ('KONA STINKY',3);
	
	column AM_ID_AMORTYZATORA HEADING 'ID' for 999999
	column AM_NAZWA HEADING 'NAZWA AMORTYZATORA' for A20
	column DO_ID_DOSTAWCY HEADING 'DOSTAWCA ID' for 999999
	
	-- ile wierszy
	select count(*) from bd1_AMORTYZATORY;

	-- szybciej:
	select count(AM_ID_AMORTYZATORA) from bd1_AMORTYZATORY;

	select * from bd1_AMORTYZATORY;			

/*
 ID 	NAZWA AMORTYZATORA   DOSTAWCA ID
------- -------------------- -----------
      1 FOX TOTEM                      1
*/
---------------------------
PROMPT   table bd1_RAMY
---------------------------	
create table bd1_RAMY (
RA_ID_RAMY			number(8)		NOT NULL,
RA_NAZWA		varchar2(30)	,
DO_ID_DOSTAWCY 	number(8)	NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
 ------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_RAMY
		ADD CONSTRAINT PK_bd1_RAMY
		PRIMARY KEY ( RA_ID_RAMY) ;

	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_RAMY
		ADD CONSTRAINT  FK11_bd1_DOSTAWCY
		FOREIGN KEY(DO_ID_DOSTAWCY) 
		REFERENCES bd1_DOSTAWCY(DO_ID_DOSTAWCY) ENABLE;

------------------------
-- SEQUENCE
------------------------		
	drop sequence SEQ_bd1_RAMY;
	
	CREATE SEQUENCE SEQ_bd1_RAMY
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
------------------------
-- TRIGGER
------------------------
	CREATE OR REPLACE TRIGGER T_BI_bd1_RAMY
	BEFORE INSERT ON bd1_RAMY
	FOR EACH ROW
	BEGIN
		IF :NEW.RA_ID_RAMY IS NULL THEN
			SELECT SEQ_bd1_RAMY.NEXTVAL 
				INTO :NEW.RA_ID_RAMY FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_RAMY - RA_ID_RAMY='||:NEW.RA_ID_RAMY);
		--
	END;
	/
------------------------
-- DML bd1_RAMY
------------------------
	insert into bd1_RAMY(RA_NAZWA,DO_ID_DOSTAWCY)
	values ('DEMO',1);
	
	insert into bd1_RAMY(RA_NAZWA,DO_ID_DOSTAWCY)
	values ('NSFUZZ',2);
	
	insert into bd1_RAMY(RA_NAZWA,DO_ID_DOSTAWCY)
	values ('KONA STINKY',3);
	
	column RA_ID_RAMY HEADING 'ID' for 999999
	column RA_NAZWA HEADING 'NAZWA RAMY' for A20
	column DO_ID_DOSTAWCY HEADING 'DOSTAWCA ID' for 999999
	
	-- ile wierszy
	select count(*) from bd1_RAMY;

	-- szybciej:
	select count(RA_ID_RAMY) from bd1_RAMY;

	select * from bd1_RAMY;		
	
/*
     ID NAZWA RAMY           DOSTAWCA ID
------- -------------------- -----------
      1 DEMO                           1
*/
		
---------------------------
PROMPT   table bd1_ROWERY
---------------------------	
create table bd1_ROWERY(
RO_ID_ROWERU		number(8)		NOT NULL,
RO_NAZWA	varchar2(30)	,
RA_ID_RAMY		number(8)		NOT NULL,
AM_ID_AMORTYZATORA		number(8)		NOT NULL,
KI_ID_KIEROWNICY		number(8)		NOT NULL,
OB_ID_OBRECZY		number(8)		NOT NULL,
OP_ID_OPONY		number(8)		NOT NULL,
MA_ID_MANETKI		number(8)		NOT NULL,
KA_ID_KASETY		number(8)		NOT NULL,
ZE_ID_ZEBATKI		number(8)		NOT NULL,
LA_ID_LANCUCHU		number(8)		NOT NULL,
SI_ID_SIODELKA      number(8)		NOT NULL,
SZ_ID_SZTYCY 		number(8)		NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;

    ------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_ROWERY
		ADD CONSTRAINT PK_bd1_ROWERY
		PRIMARY KEY ( RO_ID_ROWERU) ;


	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_ROWERY
		ADD CONSTRAINT  FK12_bd1_DOSTAWCY
		FOREIGN KEY(SZ_ID_SZTYCY) 
		REFERENCES bd1_SZTYCE(SZ_ID_SZTYCY) ENABLE;
		
	ALTER TABLE bd1_ROWERY
		ADD CONSTRAINT FK13_bd1_SIODELKA
		FOREIGN KEY(SI_ID_SIODELKA) 
		REFERENCES bd1_SIODELKA(SI_ID_SIODELKA) ENABLE;
		
	ALTER TABLE bd1_ROWERY
		ADD CONSTRAINT FK13_bd1_LANCUCHY
		FOREIGN KEY(LA_ID_LANCUCHU) 
		REFERENCES bd1_LANCUCHY(LA_ID_LANCUCHU) ENABLE;
		
	ALTER TABLE bd1_ROWERY
		ADD CONSTRAINT FK14_bd1_ZEBATKI
		FOREIGN KEY(ZE_ID_ZEBATKI) 
		REFERENCES bd1_ZEBATKI(ZE_ID_ZEBATKI) ENABLE;
		
	ALTER TABLE bd1_ROWERY
		ADD CONSTRAINT FK15_bd1_KASETY
		FOREIGN KEY(KA_ID_KASETY) 
		REFERENCES bd1_KASETY(KA_ID_KASETY) ENABLE;
		
	ALTER TABLE bd1_ROWERY
		ADD CONSTRAINT FK16_bd1_MANETKI
		FOREIGN KEY(MA_ID_MANETKI) 
		REFERENCES bd1_MANETKI(MA_ID_MANETKI) ENABLE;	
	
	ALTER TABLE bd1_ROWERY
		ADD CONSTRAINT FK17_bd1_OPONY
		FOREIGN KEY(OP_ID_OPONY) 
		REFERENCES bd1_OPONY(OP_ID_OPONY) ENABLE;
		
	ALTER TABLE bd1_ROWERY
		ADD CONSTRAINT FK18_bd1_OBRECZE
		FOREIGN KEY(OB_ID_OBRECZY) 
		REFERENCES bd1_OBRECZE(OB_ID_OBRECZY) ENABLE;
		
	ALTER TABLE bd1_ROWERY
		ADD CONSTRAINT FK19_bd1_KIEROWNICY
		FOREIGN KEY(KI_ID_KIEROWNICY) 
		REFERENCES bd1_KIEROWNICE(KI_ID_KIEROWNICY) ENABLE;
		
	ALTER TABLE bd1_ROWERY
		ADD CONSTRAINT FK20_bd1_AMORTYZATORY
		FOREIGN KEY(AM_ID_AMORTYZATORA) 
		REFERENCES bd1_AMORTYZATORY(AM_ID_AMORTYZATORA) ENABLE;	
		
	ALTER TABLE bd1_ROWERY
		ADD CONSTRAINT FK21_bd1_RAMY
		FOREIGN KEY(RA_ID_RAMY) 
		REFERENCES bd1_RAMY(RA_ID_RAMY) ENABLE;	

------------------------
-- SEQUENCE
------------------------		
	drop sequence SEQ_bd1_ROWERY;
	
	CREATE SEQUENCE SEQ_bd1_ROWERY
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
------------------------
-- TRIGGER
------------------------
	CREATE OR REPLACE TRIGGER T_BI_bd1_ROWERY
	BEFORE INSERT ON bd1_ROWERY
	FOR EACH ROW
	BEGIN
		IF :NEW.RO_ID_ROWERU IS NULL THEN
			SELECT SEQ_bd1_ROWERY.NEXTVAL 
				INTO :NEW.RO_ID_ROWERU FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_ROWERY - RO_ID_ROWERU='||:NEW.RO_ID_ROWERU);
		--
	END;
	/
------------------------
-- DML bd1_ROWERY
------------------------
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
	values ('FULL SPEC 2021',1,1,1,1,1,1,1,1,1,1,1);
	
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
	values ('FULL NS BIKE',2,2,2,2,2,2,2,2,2,2,2);
	
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
	values ('',3,3,3,3,3,3,3,3,3,3,3);
	
	column RO_ID_ROWERU HEADING 'ID' for 999999
	column RO_NAZWA HEADING 'NAZWA ROWERU' for A20
	column RA_ID_RAMY HEADING 'RAMA' for 999999
	column AM_ID_AMORTYZATORA HEADING 'AMORTYZATOR' for 999999
	column KI_ID_KIEROWNICY HEADING 'KIEROWNICA' for 999999
	
	column OB_ID_OBRECZY HEADING 'OBRECZE' for 999999
	column OP_ID_OPONY HEADING 'OPONY' for 999999
	column MA_ID_MANETKI HEADING 'MANETKI' for 999999
	column KA_ID_KASETY HEADING 'KASETA' for 999999
	column ZE_ID_ZEBATKI HEADING 'ZEBATKA' for 999999
	
	column LA_ID_LANCUCHU HEADING 'LANCUCH' for 999999
	column SI_ID_SIODELKA HEADING 'SIODELKO' for 999999
	column SZ_ID_SZTYCY HEADING 'SZTYCA' for 999999
	
	
	-- ile wierszy
	select count(*) from bd1_ROWERY;

	-- szybciej:
	select count(RO_ID_ROWERU) from bd1_ROWERY;

	select * from bd1_ROWERY;	
/*
	     ID NAZWA ROWERU            RAMA AMORTYZATOR KIEROWNICA OBRECZE   OPONY MANETKI  KASETA ZEBATKA LANCUCH SIODELKO  SZTYCA
------- -------------------- ------- ----------- ---------- ------- ------- ------- ------- ------- ------- -------- -------
      1 FULL SPEC 2021             1           1          1       1       1       1       1       1       1        1       1
*/
	

---------------------------
PROMPT   zapytania select 
---------------------------	


		
SELECT SZ_ID_SZTYCY,SZ_NAZWA FROM bd1_SZTYCE WHERE SZ_ID_SZTYCY=2;
/*
 SZTYCA NAZWA SZTYCY
------- --------------------
      2 softRide
*/
SELECT RO_ID_ROWERU,RO_NAZWA FROM bd1_ROWERY WHERE RO_ID_ROWERU IN(1,2);
/*
ID NAZWA ROWERU
------- --------------------
      1 FULL SPEC 2021
      2 FULL NS BIKE
*/
SELECT RO_ID_ROWERU,RO_NAZWA FROM bd1_ROWERY WHERE RO_NAZWA LIKE'FULL NS%';
/*
 ID NAZWA ROWERU
------- --------------------
      2 FULL NS BIKE
*/
select * FROM bd1_DOSTAWCY WHERE DO_ID_DOSTAWCY=2 OR DO_ID_DOSTAWCY = 3;
/*
DOSTAWCA ID DO_NAZWA_FIRMY                 NIP           NUMER TEL.                     DO_NVLTEST
----------- ------------------------------ ------------- ------------------------------ ----------
          2 NSBIKES                        107-00-11-034 NSBIKES.contact@gmail.com
          3 KONA                           190-34-22-035 KONA.contact@gmail.com
*/


select * from bd1_AMORTYZATORY;
---------------------------
PROMPT   update amortyzatora 
---------------------------	
UPDATE bd1_AMORTYZATORY SET AM_NAZWA='NS DUMPER' WHERE AM_ID_AMORTYZATORA = 2;
select * from bd1_AMORTYZATORY;
/*
AMORTYZATOR NAZWA AMORTYZATORA   DOSTAWCA ID
----------- -------------------- -----------
          1 FOX TOTEM                      1
          2 NS FUZZ                        2
          3 KONA STINKY                    3

update amortyzatora

1 row updated.


AMORTYZATOR NAZWA AMORTYZATORA   DOSTAWCA ID
----------- -------------------- -----------
          1 FOX TOTEM                      1
          2 NS DUMPER                      2
          3 KONA STINKY                    3
*/


---------------------------
PROMPT   NVL FUNCTION 
---------------------------
column TOTAL HEADING 'NAZWA ROWERU' for A30
select RO_ID_ROWERU,NVL(RO_NAZWA,'rower bez nazwy') as TOTAL FROM bd1_ROWERY;

column KONTAKT HEADING 'ADRESS EMAIL' for A30
select DO_ID_DOSTAWCY,NVL(DO_KONTAKT,'brak kontaktu') as KONTAKT FROM bd1_DOSTAWCY;

column NAZWA_SIODELA HEADING 'NAZWA_SIODELA' for A30
select SI_ID_SIODELKA,NVL(SI_NAZWA,'brak nazwy') as NAZWA_SIODELA FROM bd1_SIODELKA;

column NAZWA_ZEBATKI HEADING 'NAZWA_ZEBATKI' for A30
select ZE_ID_ZEBATKI,NVL(ZE_NAZWA,'brak nazwy') as NAZWA_ZEBATKI FROM bd1_ZEBATKI;

/*
NVL FUNCTION

     ID NAZWA ROWERU
------- ------------------------------
      1 FULL SPEC 2021
      2 FULL NS BIKE
      3 rower bez nazwy


DOSTAWCA ID ADRESS EMAIL
----------- ------------------------------
          1 specjalized.contact@gmail.com
          2 NSBIKES.contact@gmail.com
          3 KONA.contact@gmail.com
          4 brak kontaktu


SIODELKO NAZWA_SIODELA
-------- ------------------------------
       1 SPCJALIZED_HARD_TRUCK
       2 SPCJALIZED_SOFT_TRUCK
       3 NSBIKES_RIDEME
       4 brak nazwy


ZEBATKA NAZWA_ZEBATKI
------- ------------------------------
      1 9 k13
      2 9 speed
      3 9 grade
      4 brak nazwy
*/	


PROMPT ---------------------------
PROMPT   Zapytania wielu tabel 
PROMPT ---------------------------



column RA_NAZWA HEADING 'RAMY DOSTAWCY' for A20
column AM_NAZWA HEADING 'AMORTYZATORY DOSTAWCY' for A21
select r.RA_NAZWA,a.AM_NAZWA from bd1_RAMY r,bd1_AMORTYZATORY a where r.DO_ID_DOSTAWCY=a.DO_ID_DOSTAWCY;
/*
RAMY DOSTAWCY        AMORTYZATORY DOSTAWC
-------------------- --------------------
DEMO                 FOX TOTEM
NSFUZZ               NS DUMPER
KONA STINKY          KONA STINKY
*/

column RO_NAZWA HEADING 'ROWER' for A20
column AM_NAZWA HEADING 'AMORTYZATOR' for A21
column AM_ID_AMORTYZATORA HEADING 'ID AMORTYZATORA' for A21
select r.RO_NAZWA,a.AM_NAZWA,a.AM_ID_AMORTYZATORA from bd1_ROWERY r,bd1_AMORTYZATORY a where r.AM_ID_AMORTYZATORA=2;

/*
NAZWA ROWERU         AMORTYZATORY DOSTAWC AMORTYZATOR
-------------------- -------------------- -----------
FULL NS BIKE         FOX TOTEM                      1
FULL NS BIKE         NS DUMPER                      2
FULL NS BIKE         KONA STINKY                    3
*/
column RA_NAZWA HEADING 'RAMA' for A20
select r.RO_NAZWA,r.RO_ID_ROWERU,a.RA_NAZWA from bd1_ROWERY r,bd1_RAMY a where a.RA_ID_RAMY=2;
/*
NAZWA ROWERU              ID RAMA
-------------------- ------- --------------------
FULL SPEC 2021             1 NSFUZZ
FULL NS BIKE               2 NSFUZZ
                           3 NSFUZZ
*/



PROMPT ---------------------------
PROMPT   Group by 
PROMPT ---------------------------
column RA_NAZWA HEADING 'RAMA' for A20
column RA_ID_RAMY HEADING 'ID' for 999999
select RA_NAZWA from bd1_RAMY GROUP BY RA_NAZWA;
/*
RAMA
--------------------
DEMO
KONA STINKY
NSFUZZ
*/
column NAME HEADING 'NAZWA ROWERU ZLOZONEGO' for A40
select RO_NAZWA as NAME from bd1_ROWERY GROUP BY RO_NAZWA HAVING RO_NAZWA LIKE 'FULL%';
/*
NAZWA ROWERU ZLOZONEGO
----------------------------------------
FULL SPEC 2021
FULL NS BIKE
*/
column IDD HEADING 'ID Amortyzatora' for A20
select AM_ID_AMORTYZATORA as IDD from bd1_AMORTYZATORY GROUP BY AM_ID_AMORTYZATORA HAVING AM_ID_AMORTYZATORA < 3;
/*
ID Amortyzatora
-----------
          1
          2
*/
column KIEROWNICA HEADING 'KIEROWNICA' for A20
SELECT KI_NAZWA as KIEROWNICA FROM bd1_KIEROWNICE group by KI_NAZWA having KI_NAZWA LIke 'F%';
/*
KIEROWNICA
--------------------
FATBAR 800MM
*/
column NAME2 HEADING 'NAZWA SIODLA' for A40
SELECT SI_NAZWA AS NAME2 FROM bd1_SIODELKA group by SI_NAZWA having SI_NAZWA LIke 'SPC%';

/*
NAZWA SIODLA
----------------------------------------
SPCJALIZED_HARD_TRUCK
SPCJALIZED_SOFT_TRUCK

*/



PROMPT -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ##
PROMPT -- ## -- ## LAB 07 - DML   
PROMPT -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ##

PROMPT---------------------------	
PROMPT----------- VIEWs	
PROMPT--------------------------- 


CREATE OR REPLACE VIEW bd1_V_KASETY_MAX_SPEED
AS
select r.RO_ID_ROWERU,r.RO_NAZWA,k.KA_ID_KASETY,k.KA_MAX_VALUE 
from bd1_ROWERY r, bd1_KASETY k
where KA_MAX_VALUE BETWEEN 10 and 14;
	/*select * from bd1_ROWERY order by RO_ID_ROWERU;*/
select * from bd1_V_KASETY_MAX_SPEED
order by KA_ID_KASETY;	
/*
    ID ROWER                 KASETA KA_MAX_VALUE
------ -------------------- ------- ------------
     1 FULL SPEC 2021             2           12
     2 FULL NS BIKE               2           12
     3                            2           12
	*/
	
CREATE OR REPLACE VIEW bd1_V_TEST
AS
select KA_NAZWA,DO_ID_DOSTAWCY,KA_MAX_VALUE
from  bd1_KASETY where KA_ID_KASETY=2;

insert into bd1_KASETY (KA_NAZWA,DO_ID_DOSTAWCY,KA_MAX_VALUE)
	select KA_NAZWA,DO_ID_DOSTAWCY,KA_MAX_VALUE from bd1_V_TEST;
	
select KA_NAZWA,DO_ID_DOSTAWCY,KA_MAX_VALUE from  bd1_KASETY;
/*
NAZWA KASETY         DOSTAWCA ID KA_MAX_VALUE
-------------------- ----------- ------------
9 BIEGOWA SPEC K13             1            9
9 BIEGOWA NSBIKES              2           12
9 BIEGOWA KONA                 2            9
9 BIEGOWA NSBIKES              2           12         skopiowany rekord o ID = 2
*/

CREATE OR REPLACE VIEW bd1_V_TEST2
AS
select KA_NAZWA
from  bd1_KASETY where KA_ID_KASETY=4;

UPDATE bd1_V_TEST2 SET KA_NAZWA='ViewUP9';
select KA_NAZWA,DO_ID_DOSTAWCY,KA_MAX_VALUE from  bd1_KASETY;
/*
NAZWA KASETY         DOSTAWCA ID KA_MAX_VALUE
-------------------- ----------- ------------
9 BIEGOWA SPEC K13             1            9
9 BIEGOWA NSBIKES              2           12
9 BIEGOWA KONA                 2            9
ViewUP9                        2           12
*/

DELETE bd1_V_TEST2;
select KA_NAZWA,DO_ID_DOSTAWCY,KA_MAX_VALUE from  bd1_KASETY;
/*
NAZWA KASETY         DOSTAWCA ID KA_MAX_VALUE
-------------------- ----------- ------------
9 BIEGOWA SPEC K13             1            9
9 BIEGOWA NSBIKES              2           12
9 BIEGOWA KONA                 2            9
*/

CREATE OR REPLACE VIEW bd1_V_UPDATE_ID
(ID_KASETY,NAZWA,DOSTAWCA,ROWER,NAZWA_ROWERU,ID_KAS_ROWERU)
AS
select  k.KA_ID_KASETY, k.KA_NAZWA,k.DO_ID_DOSTAWCY,r.RO_ID_ROWERU,r.RO_NAZWA,r.KA_ID_KASETY
from  bd1_KASETY k,bd1_ROWERY r where r.KA_ID_KASETY=1 and k.KA_ID_KASETY=1 WITH CHECK OPTION;

select * from bd1_V_UPDATE_ID;

/*UPDATE bd1_V_UPDATE_ID SET ID_KAS_ROWERU=10,ID_KASETY=10;*/
/*
*
ERROR at line 1:
ORA-01779: cannot modify a column which maps to a non key-preserved table
*/


PROMPT ---------------------------
PROMPT   PODSUMOWANIA
PROMPT ---------------------------	



-- describe USER_TABLES
	column TABLE_NAME HEADING 'NAME' for A32
	column DROPPED HEADING 'NAME' for A32

PROMPT Lista utworzonych tabel:	

SELECT TABLE_NAME FROM USER_TABLES
WHERE DROPPED='NO';

-- ## -- ## -- ## -- ## -- 
SPOOL OFF