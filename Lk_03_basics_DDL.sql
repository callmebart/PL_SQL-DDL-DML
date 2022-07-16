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

CLEAR SCREEN;
--
SET LINESIZE 350;
SET PAGESIZE 300;

SPOOL "D:\oracle\Lk_03.out.txt"

show user;

-- wyswietla komunikaty zwrotne z Oracle
SET SERVEROUTPUT ON;

-- zmień format daty
alter session set 
	nls_date_format = 'YYYY-MM-DD HH24:MI';

--
select sysdate from dual;

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
DO_NAZWA_FIRMY		varchar2(128),
DO_NIP		varchar2(10),
DO_KONTAKT	varchar2(10)
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_DOSTAWCY
		ADD CONSTRAINT PK_bd1_DOSTAWCY	
		PRIMARY KEY (DO_ID_DOSTAWCY) ;

---------------------------
PROMPT   table bd1_SZTYCE
---------------------------	
create table bd1_SZTYCE (
SZ_ID_SZTYCY			number(8)		NOT NULL,
SZ_NAZWA		varchar2(128)	,
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

---------------------------
PROMPT   table bd1_SIODELKA
---------------------------	
create table bd1_SIODELKA (
SI_ID_SIODELKA			number(8)		NOT NULL,
SI_NAZWA		varchar2(128)	,
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

---------------------------
PROMPT   table bd1_LANCUCHY
---------------------------	
create table bd1_LANCUCHY (
LA_ID_LANCUCHU			number(8)		NOT NULL,
LA_NAZWA		varchar2(128)	,
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
		
		
---------------------------
PROMPT   table bd1_ZEBATKI
---------------------------	
create table bd1_ZEBATKI (
ZE_ID_ZEBATKI			number(8)		NOT NULL,
ZE_NAZWA		varchar2(128)	,
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

---------------------------
PROMPT   table bd1_KASETY
---------------------------	
create table bd1_KASETY (
KA_ID_KASETY			number(8)		NOT NULL,
KA_NAZWA		varchar2(128)	,
DO_ID_DOSTAWCY 	number(8)	NOT NULL
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
		
---------------------------
PROMPT   table bd1_MANETKI
---------------------------	
create table bd1_MANETKI (
MA_ID_MANETKI			number(8)		NOT NULL,
MA_NAZWA		varchar2(128)	,
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
		

---------------------------
PROMPT   table bd1_OPONY
---------------------------	
create table bd1_OPONY (
OP_ID_OPONY			number(8)		NOT NULL,
OP_NAZWA		varchar2(128)	,
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
		

---------------------------
PROMPT   table bd1_OBRECZE
---------------------------	
create table bd1_OBRECZE (
OB_ID_OBRECZY			number(8)		NOT NULL,
OB_NAZWA		varchar2(128)	,
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
	
---------------------------
PROMPT   table bd1_KIEROWNICE
---------------------------	
create table bd1_KIEROWNICE (
KI_ID_KIEROWNICY			number(8)		NOT NULL,
KI_NAZWA		varchar2(128)	,
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

---------------------------
PROMPT   table bd1_AMORTYZATORY
---------------------------	
create table bd1_AMORTYZATORY(
AM_ID_AMORTYZATORA			number(8)		NOT NULL,
AM_NAZWA		varchar2(128)	,
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
---------------------------
PROMPT   table bd1_RAMY
---------------------------	
create table bd1_RAMY (
RA_ID_RAMY			number(8)		NOT NULL,
RA_NAZWA		varchar2(128)	,
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
		
---------------------------
PROMPT   table bd1_ROWERY
---------------------------	
create table bd1_ROWERY(
RO_ID_ROWERU		number(8)		NOT NULL,
RO_NAZWA	varchar2(128)	,
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