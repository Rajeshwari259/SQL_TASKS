--TASK 7 INSERT DATA INTO ITEMS(ITEM_ID WITH SEQUENCE,SYSTEM_ENTRY_DATE=CURRENT TIME)
--CREATED TEMPORARY TABLE(Staging Table) WITHOUT ITEM_ID & SYSTEM_ENTRY_DATE To load directly FROM CSV FILE .
--IMPORT DATA FROM CSV FILE .
--THEN INSERT INTO Item table USE SEQUENCE IN ITEM_ID AND SYSTIESTAMP FOR STYSTEM_ENTRY_DATE
--COMMIT 
--DROP TEMPORARY TABLE(I_Staging)
CREATE TABLE I_Staging (
  bank_acc_no        VARCHAR2(30),
  txn_reference      VARCHAR2(50),
  txn_amount         NUMBER(12,4),
  drocr              VARCHAR2(1),
  txn_ccy            VARCHAR2(3),
  stmt_date          DATE,
  value_date         DATE,
  item_type          VARCHAR2(20),
  txn_stock_code     VARCHAR2(12),
  stock_id           NUMBER,
  quantity           NUMBER(12,4),
  price              NUMBER(12,4)
);
--INSERT INTO Item table USE SEQUENCE IN ITEM_ID AND SYSTIESTAMP FOR STYSTEM_ENTRY_DATE
INSERT INTO Item (
  item_id,bank_acc_no,txn_reference,txn_amount,drocr,txn_ccy,stmt_date,system_entry_date,value_date,item_type,txn_stock_code,stock_id,quantity,price
)
SELECT
  item_seq.NEXTVAL,bank_acc_no,txn_reference,txn_amount,drocr,txn_ccy,stmt_date,SYSTIMESTAMP,value_date,item_type,txn_stock_code,stock_id,quantity,price
FROM I_Staging;
COMMIT;

--TASK 8-INSERT DATA TO ASSET_REGISTER table
-- i)I used import data functionality to load records from a CSV file into the Asset_Register 

--ii)CREATE TABLE asset_register_links FROM ASSET _REGISTER
     --here all Data is copied from table asset_register-(note:It will not copy constraints automatically.)
CREATE TABLE Asset_Register_Links AS
SELECT *FROM ASSET_REGISTER;

--iii)RENAME COLUMN STOCK_CODE TO MASTER_STOCK_CODE
ALTER TABLE ASSET_REGISTER
RENAME COLUMN STOCK_CODE TO MASTER_STOCK_CODE;

--iv)Remove the Column “ASSET_TYPE” from table “asset_register”
ALTER TABLE ASSET_REGISTER
DROP COLUMN ASSET_TYPE;

--v)insert unknown assests using sql file
insert into asset_register_links values (-1001,'INF200K01VT4','SBI Bluechip Fund - Direct Growth - Equity â€“ Large Cap','ISIN');
insert into asset_register_links values (-1002,'INF179K01HQ4','HDFC Mid-Cap Opportunities - Direct Growth - Equity â€“ Mid Cap','ISIN');
insert into asset_register_links values (-1003,'INF846K01YV6','Axis Long Term Equity Fund - Direct Growth - ELSS (Tax Saver)','ISIN');
insert into asset_register_links values (-1004,'INF109K01YV1','ICICI Prudential Balanced Advantage - Growth - Hybrid â€“ Balanced','ISIN');
insert into asset_register_links values (-1005,'INF204K01DA9','Nippon India Small Cap Fund - Direct Growth - Equity â€“ Small Cap','ISIN');
insert into asset_register_links values (-1006,'INF174K01JP3','Kotak Standard Multicap Fund - Direct Growth - Equity â€“ Multicap','ISIN');
insert into asset_register_links values (-1007,'INF879O01017','Parag Parikh Flexi Cap Fund - Direct Growth - Equity â€“ Flexicap','ISIN');
insert into asset_register_links values (-1008,'INF769K01HG5','Mirae Asset Large Cap Fund - Direct Growth - Equity â€“ Large Cap','ISIN');
insert into asset_register_links values (-1009,'INF789F1AUN2','UTI Nifty Index Fund - Direct Growth - Index â€“ Nifty 50','ISIN');
insert into asset_register_links values (-1010,'INF843K01FW5','Edelweiss Balanced Advantage - Direct Growth - Hybrid â€“ Dynamic','ISIN');
insert into asset_register_links values (-1011,'US9229087287','Vanguard Total Stock Market Index Fund Admiral - Index Fund','ISIN');
insert into asset_register_links values (-1012,'US3160711095','Fidelity Contrafund - Large Cap Growth','ISIN');
insert into asset_register_links values (-1013,'US4642872349','iShares MSCI Emerging Markets ETF - ETF â€“ Emerging Markets','ISIN');
insert into asset_register_links values (-1014,'LU0072462426','BlackRock Global Allocation Fund A2 USD - Global Allocation','ISIN');
insert into asset_register_links values (-1015,'US72201F1030','PIMCO Income Fund Class A - Income Fund','ISIN');
insert into asset_register_links values (-1016,'LU0107398884','JPMorgan US Technology Fund A (acc) USD - US Technology','ISIN');
insert into asset_register_links values (-1017,'LU0269888503','Schroder ISF Global Sustainable Growth Fund - Sustainable Equity','ISIN');
insert into asset_register_links values (-1018,'INF090I01808','Franklin India Feeder â€“ Franklin US Opp Fund - Feeder Fund â€“ US','ISIN');
insert into asset_register_links values (-1019,'INF247L01536','Motilal Oswal Nasdaq 100 ETF - Feeder â€“ US Index','ISIN');
insert into asset_register_links values (-1020,'INF223J01AL3','PGIM India Global Equity Opp Fund - Dir Growth - Global Equity','ISIN');
COMMIT;

CREATE TABLE asset_linking_lookup(
  isin   VARCHAR2(30),
  cusip  VARCHAR2(30),
  sedol  VARCHAR2(30)
);
--INSERT CUSIP
MERGE INTO asset_register_links target
USING (
  SELECT al.cusip AS stock_code,
         ar.stock_id,
         ar.description
  FROM asset_linking_lookup al
  JOIN asset_register_links ar
    ON al.isin = ar.stock_code AND ar.asset_type = 'ISIN'
  WHERE al.cusip IS NOT NULL
) source
ON (
  target.stock_code = source.stock_code AND target.ASSET_type = 'CUSIP'
)
WHEN NOT MATCHED THEN
  INSERT (stock_id, stock_code, ASSET_type, description)
  VALUES (source.stock_id, source.stock_code, 'CUSIP', source.description);

--INSERT SEDOL
MERGE INTO asset_register_links target
USING (
  SELECT al.sedol AS stock_code,
         ar.stock_id,
         ar.description
  FROM asset_linking_lookup al
  JOIN asset_register_links ar
    ON al.isin = ar.stock_code AND ar.asset_type = 'ISIN'
  WHERE al.sedol IS NOT NULL
) source
ON (
  target.stock_code = source.stock_code AND target.asset_type = 'SEDOL'
)
WHEN NOT MATCHED THEN
  INSERT (stock_id, stock_code, asset_type, description)
  VALUES (source.stock_id, source.stock_code, 'SEDOL', source.description);
-- CHECK OUTPUT 
select * from asset_register_links
where stock_id=1;
