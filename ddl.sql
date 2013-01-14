CREATE TABLE conversion (
  transaction_id varchar(255) NOT NULL,
  date timestamp NOT NULL,
  date_interval timestamp NOT NULL,
  cost decimal(10,2) NOT NULL,
  revenue decimal(10,2) NOT NULL,
  customer_id varchar(255) ,
  sale_amount decimal(10,2),
  is_valid tinyint,
  is_dynamic_revenue tinyint NOT NULL,
  CONSTRAINT PK_conversion PRIMARY KEY (transaction_id)
);

CREATE UNIQUE index conversion_transaction_id ON conversion (transaction_id);
CREATE INDEX conversion_date ON conversion (date);
CREATE INDEX conversion_date_interval ON conversion (date_interval,cost,revenue);

CREATE TABLE click (
  transaction_id varchar(255) NOT NULL,
  click_date timestamp NOT NULL ,
  click_date_interval timestamp NOT NULL ,
  related_click varchar(255) ,
  is_unique tinyint ,
  offer_id integer NOT NULL,
  aff_id integer,
  aff_id_new_old varchar(32),
  aff_id_new integer,
  url_id integer,
  finance_rule_id integer NOT NULL,
  ad_id integer,
  campaign_id integer ,
  creative_id integer ,
  placement_id integer ,
  dma integer ,
  city varchar(255) ,
  state varchar(50) ,
  zip varchar(11) ,
  country varchar(20) ,
  latitude decimal(9,6) ,
  longitude decimal(10,6) ,
  image varchar(10) ,
  text varchar(10) ,
  dynamic_location_text varchar(10) ,
  callout varchar(10) ,
  callout_text varchar(10) ,
  animation varchar(10) ,
  time_of_day integer ,
  source varchar(255) ,
  sub1 varchar(255) ,
  sub2 varchar(255) ,
  sub3 varchar(255) ,
  sub4 varchar(255) ,
  sub5 varchar(255) ,
  params varchar(255) ,
  impression_cost decimal(10,6) ,
  cost decimal(10,2) NOT NULL,
  revenue decimal(10,2) NOT NULL,
  referrer varchar(255) ,
  browser varchar(255) ,
  os varchar(255) ,
  ip varchar(15)	
);

CREATE UNIQUE index click_transaction_id ON click (transaction_id);
CREATE INDEX click_search1 ON click (click_date_interval,offer_id,aff_id,url_id,cost,revenue,is_unique);
CREATE INDEX click_search2 ON click (click_date_interval,offer_id,source,cost,revenue,is_unique);
CREATE INDEX click_perm1 ON click (click_date_interval,offer_id,ad_id,dma,image,animation,callout,text,callout_text,is_unique);
CREATE INDEX click_perm2 ON click (click_date_interval,offer_id,sub1,sub2,sub3,sub4,sub5,is_unique);
CREATE INDEX click_ip ON click (ip);
CREATE INDEX click_aff_id ON click (aff_id);


PARTITION TABLE click ON COLUMN offer_id;
PARTITION TABLE conversion ON COLUMN transaction_id;

CREATE TABLE test (
  transaction_id varchar(255) NOT NULL,
  related_click varchar(255) ,
  is_unique tinyint ,
  offer_id integer NOT NULL,
  aff_id integer,
  aff_id_new_old varchar(32),
  aff_id_new integer,
  url_id integer,
  finance_rule_id integer NOT NULL,
  ad_id integer,
  campaign_id integer ,
  creative_id integer ,
  placement_id integer ,
  dma integer ,
  city varchar(255) ,
  state varchar(50) ,
  zip varchar(11) ,
  country varchar(20) ,
  latitude decimal(9,6) ,
  longitude decimal(10,6) ,
  image varchar(10) ,
  text varchar(10) ,
  dynamic_location_text varchar(10) ,
  callout varchar(10) ,
  callout_text varchar(10) ,
  animation varchar(10) ,
  time_of_day integer ,
  source varchar(255) ,
  sub1 varchar(255) ,
  sub2 varchar(255) ,
  sub3 varchar(255) ,
  sub4 varchar(255) ,
  sub5 varchar(255) ,
  params varchar(255) ,
  impression_cost decimal(10,6) ,
  cost decimal(10,2) NOT NULL,
  revenue decimal(10,2) NOT NULL,
  referrer varchar(255) ,
  browser varchar(255) ,
  os varchar(255) ,
  ip varchar(15)	
);

CREATE UNIQUE index test_transaction_id ON test (transaction_id);
PARTITION TABLE test ON COLUMN offer_id;