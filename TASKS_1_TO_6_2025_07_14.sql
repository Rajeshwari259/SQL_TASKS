--Task 1(CREATE TABLE Bank_Accounts )
CREATE TABLE Bank_Accounts (
account_id     NUMBER PRIMARY KEY,
bank_acc_no  VARCHAR2(30) UNIQUE,
recon_type      VARCHAR2(30),
cat_code        VARCHAR2(20),
sub_acc_no      VARCHAR2(30),
status          VARCHAR2(10) default 'ACTIVE');
 
 --Task 2 (CREATE TABLE Item)
CREATE TABLE Item(
item_id     NUMBER PRIMARY KEY,
bank_acc_no VARCHAR2(30),
txn_reference   VARCHAR2(50),
txn_amount      NUMBER(12, 4),
drocr            VARCHAR2(1),
txn_ccy         VARCHAR2(3),
stmt_date       DATE,
system_entry_date   TIMESTAMP,
value_date              DATE,
item_type           VARCHAR2(20),
txn_stock_code      VARCHAR2(12),
stock_id            NUMBER,
quantity            NUMBER(12, 4),
price               NUMBER(12, 4),
constraint fk_item_bankacc FOREIGN KEY (bank_acc_no) references Bank_Accounts(bank_acc_no));

--Task 3 (CREATE TABLE Asset_Register)
CREATE TABLE Asset_Register (
stock_id    NUMBER PRIMARY KEY,
stock_code      VARCHAR2(12)UNIQUE,
description     VARCHAR2(100),
asset_type      VARCHAR2(20));
 
 --TASK 4  (CREATE TABLE Closing_Balances)
CREATE TABLE Closing_Balances (
cb_id       NUMBER primary key,
bank_acc_no     VARCHAR2(30),
cbal_date       DATE,
cbal_amount     NUMBER(12, 4),
currency_code   VARCHAR2(3),
constraint fk_cb_bankacc FOREIGN KEY  (bank_Acc_no) references Bank_Accounts(bank_Acc_no) );

--Task 5 (Add column currency to tabel Bank_Accounts)
ALTER TABLE Bank_Accounts
ADD currency  VARCHAR2(3) DEFAULT 'USD' NOT NULL;

--INSERT RECORDS TO BANK_ACCOUNTS TABLE
--I HAVE USED INSERT ALL .(IT IS MANDATORY IN THE END OF THIS QUERY--> SELECT *FROM DUAL;)
 INSERT ALL 
 into BANK_ACCOUNTS  values (100001,'ACC1001','Cash','NOSTROASIA','SUB001','ACTIVE','USD')
 into BANK_ACCOUNTS  values (100002,'ACC1002','Stock','STCKEMEA','SUB002','ACTIVE','CHF')
 into BANK_ACCOUNTS  values (100003,'ACC1003','Trade','STCKAMER','SUB003','INACTIVE','NOK')
 into BANK_ACCOUNTS  values (100004,'ACC1004','Cash','NOSTROASIA','SUB004','ACTIVE','NOK')
 into BANK_ACCOUNTS  values (100005,'ACC1005','Stock','STCKEMEA','SUB005','ACTIVE','SGD')
 into BANK_ACCOUNTS  values (100006,'ACC1006','Trade','STCKAMER','SUB006','INACTIVE','PLN')
 into BANK_ACCOUNTS  values (100007,'ACC1007','Cash','NOSTROASIA','SUB007','ACTIVE','SGD')
 into BANK_ACCOUNTS  values (100008,'ACC1008','Stock','STCKEMEA','SUB008','ACTIVE','PLN')
 into BANK_ACCOUNTS  values (100009,'ACC1009','Trade','STCKAMER','SUB009','ACTIVE','SEK')
 into BANK_ACCOUNTS  values (100010,'ACC1010','Cash','NOSTROASIA','SUB010','ACTIVE','USD')
 into BANK_ACCOUNTS  values (100011,'ACC1011','Trade','STCKEMEA','SUB0011','ACTIVE','GBP')
 into BANK_ACCOUNTS  values (100012,'ACC1012','Cash','CASHAMER','SUB0012','ACTIVE','EUR')
 into BANK_ACCOUNTS  values (100013,'ACC1013','Stock','MIDDLEEAST','SUB0013','ACTIVE','GBP')
 into BANK_ACCOUNTS  values (100014,'ACC1014','Trade','INTERNAL','SUB0014','ACTIVE','INR')
 into BANK_ACCOUNTS  values (100015,'ACC1015','Cash','NOSTROASIA','SUB0015','ACTIVE','USD')
 into BANK_ACCOUNTS  values (100016,'ACC1016','Stock','STCKEMEA','SUB0016','ACTIVE','THB')
 into BANK_ACCOUNTS  values (100017,'ACC1017','Trade','STCKAMER','SUB0017','ACTIVE','THB')
 into BANK_ACCOUNTS  values (100018,'ACC1018','Cash','MIDDLEEAST','SUB0018','ACTIVE','USD')
 into BANK_ACCOUNTS  values (100019,'ACC1019','Stock','INTERNAL','SUB0019','ACTIVE','EUR')
 into BANK_ACCOUNTS  values (100020,'ACC1020','Trade','STCKASIA','SUB0020','INACTIVE','KWD')
 into BANK_ACCOUNTS  values (100021,'ACC1021','Cash','NOSTROEMEA','SUB0021','ACTIVE','EUR')
 into BANK_ACCOUNTS  values (100022,'ACC1022','Stock','STCKAMER','SUB0022','ACTIVE','CZK')
 into BANK_ACCOUNTS  values (100023,'ACC1023','Trade','MIDDLEEAST','SUB0023','ACTIVE','JPY')
 into BANK_ACCOUNTS  values (100024,'ACC1024','Cash','INTERNAL','SUB0024','ACTIVE','CZK')
 into BANK_ACCOUNTS  values (100025,'ACC1025','Stock','STCKASIA','SUB0025','ACTIVE','USD')
 into BANK_ACCOUNTS  values (100026,'ACC1026','Trade','STCKEMEA','SUB0026','ACTIVE','DKK')
 into BANK_ACCOUNTS  values (100027,'ACC1027','Cash','CASHAMER','SUB0027','ACTIVE','INR')
 into BANK_ACCOUNTS  values (100028,'ACC1028','Stock','MIDDLEEAST','SUB0028','ACTIVE','USD')
 into BANK_ACCOUNTS  values (100029,'ACC1029','Trade','INTERNAL','SUB0029','ACTIVE','AUD')
 into BANK_ACCOUNTS  values (100030,'ACC1030','Cash','CASHASIA','SUB0030','INACTIVE','SEK')
 into BANK_ACCOUNTS  values (100031,'ACC1031','Stock','STCKEMEA','SUB0031','ACTIVE','CNY')
 into BANK_ACCOUNTS  values (100032,'ACC1032','Trade','STCKAMER','SUB0032','ACTIVE','DKK')
 into BANK_ACCOUNTS  values (100033,'ACC1033','Cash','MIDDLEEAST','SUB0033','ACTIVE','EUR')
 into BANK_ACCOUNTS  values (100034,'ACC1034','Stock','INTERNAL','SUB0034','ACTIVE','USD')
 into BANK_ACCOUNTS  values (100035,'ACC1035','Trade','STCKASIA','SUB0035','ACTIVE','USD')
 into BANK_ACCOUNTS  values (100036,'ACC1036','Cash','NOSTROEMEA','SUB0036','ACTIVE','CHF')
 into BANK_ACCOUNTS  values (100037,'ACC1037','Stock','STCKAMER','SUB0037','ACTIVE','USD')
 into BANK_ACCOUNTS  values (100038,'ACC1038','Trade','MIDDLEEAST','SUB0038','ACTIVE','USD')
 into BANK_ACCOUNTS  values (100039,'ACC1039','Cash','INTERNAL','SUB0039','ACTIVE','USD')
 into BANK_ACCOUNTS  values (100040,'ACC1040','Stock','STCKASIA','SUB0040','INACTIVE','CNY')
 into BANK_ACCOUNTS  values (100041,'ACC1041','Trade','STCKEMEA','SUB0041','ACTIVE','JPY')
 into BANK_ACCOUNTS  values (100042,'ACC1042','Cash','NOSTROAMER','SUB0042','ACTIVE','CHF')
 into BANK_ACCOUNTS  values (100043,'ACC1043','Stock','MIDDLEEAST','SUB0043','ACTIVE','AED')
 into BANK_ACCOUNTS  values (100044,'ACC1044','Trade','INTERNAL','SUB0044','ACTIVE','CNY')
 into BANK_ACCOUNTS  values (100045,'ACC1045','Cash','CASHASIA','SUB0045','ACTIVE','GBP')
 into BANK_ACCOUNTS  values (100046,'ACC1046','Stock','STCKEMEA','SUB0046','ACTIVE','USD')
 into BANK_ACCOUNTS  values (100047,'ACC1047','Trade','STCKAMER','SUB0047','ACTIVE','CAD')
 into BANK_ACCOUNTS  values (100048,'ACC1048','Cash','MIDDLEEAST','SUB0048','ACTIVE','JPY')
 into BANK_ACCOUNTS  values (100049,'ACC1049','Stock','INTERNAL','SUB0049','ACTIVE','AED')
 into BANK_ACCOUNTS  values (100050,'ACC1050','Trade','STCKASIA','SUB0050','INACTIVE','CAS')
 SELECT *FROM DUAL;
COMMIT;
--Task 6(Create a SEQUENCE "item_seq" on Item Table)
CREATE SEQUENCE item_seq
START WITH 1000001
INCREMENT BY 1
NOCYCLE
NOCACHE;
--ADD COLUMN SOURCE_CODE IN BANK_ACCOUNTS
ALTER TABLE Bank_Accounts
ADD source_code VARCHAR2(30)DEFAULT 'ATYETICORP';
--UPDATE THE COLUMN SOURCE_CODE WITH CASE STATEMENT
UPDATE BANK_ACCOUNTS
SET source_code=
   CASE
       WHEN cat_code LIKE '%AMER%' THEN 'ATYETI-US'
       WHEN cat_code LIKE '%APAC%' THEN 'ATYETI-IN'
       WHEN cat_code LIKE '%EMEA%' THEN 'ATYETI-UK'
       ELSE 'ATYETI-GLOBAL'
   END;
commit; 
