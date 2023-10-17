create database dev_webinar_common_db;
create schema util;
use database dev_webinar_common_db;
use schema util;
use warehouse dev_webinar_wh;
CREATE TABLE dw_delta_date (
    event_dt DATE,
    dw_load_ts TIMESTAMP
);
insert overwrite into dw_delta_date
with l_delta_date as
(
    select distinct
        o_orderdate as event_dt
    from
        dev_webinar_orders_rl_db.tpch.line_item_stg 
)
select
     event_dt
    ,current_timestamp()            as dw_load_ts
from
    l_delta_date
order by
    1
;
select * 
from dev_webinar_common_db.util.dw_delta_date
order by event_dt;