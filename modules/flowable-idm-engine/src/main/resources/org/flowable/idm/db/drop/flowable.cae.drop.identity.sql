alter table ACT_ID_MEMBERSHIP 
    drop CONSTRAINT ACT_FK_MEMB_GROUP;
    
alter table ACT_ID_MEMBERSHIP 
    drop CONSTRAINT ACT_FK_MEMB_USER;
    
alter table ACT_ID_PRIV_MAPPING
    drop CONSTRAINT ACT_FK_PRIV_MAPPING;

drop table if exists ACT_ID_PROPERTY;
drop table if exists ACT_ID_BYTEARRAY;
drop table if exists ACT_ID_INFO;
drop table if exists ACT_ID_MEMBERSHIP;
drop table if exists ACT_ID_GROUP;
drop table if exists ACT_ID_USER;
drop table if exists ACT_ID_TOKEN;
drop table if exists ACT_ID_PRIV;
drop table if exists ACT_ID_PRIV_MAPPING;
