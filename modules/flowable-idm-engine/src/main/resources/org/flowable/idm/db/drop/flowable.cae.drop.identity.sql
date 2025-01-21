drop index ACT_ID_PRIV_MAPPING.ACT_IDX_PRIV_USER;
drop index ACT_ID_PRIV_MAPPING.ACT_IDX_PRIV_GROUP;

alter table ACT_ID_MEMBERSHIP
    drop CONSTRAINT ACT_FK_MEMB_GROUP;
    
alter table ACT_ID_MEMBERSHIP 
    drop CONSTRAINT ACT_FK_MEMB_USER;
    
alter table ACT_ID_PRIV_MAPPING
    drop CONSTRAINT ACT_FK_PRIV_MAPPING;

drop table if exists ACT_ID_PROPERTY cascade;
drop table if exists ACT_ID_BYTEARRAY cascade;
drop table if exists ACT_ID_INFO cascade;
drop table if exists ACT_ID_MEMBERSHIP cascade;
drop table if exists ACT_ID_GROUP cascade;
drop table if exists ACT_ID_USER cascade;
drop table if exists ACT_ID_TOKEN cascade;
drop table if exists ACT_ID_PRIV cascade;
drop table if exists ACT_ID_PRIV_MAPPING cascade;
