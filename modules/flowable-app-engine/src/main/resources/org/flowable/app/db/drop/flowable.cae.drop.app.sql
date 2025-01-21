drop index ACT_APP_DEPLOYMENT_RESOURCE.ACT_IDX_APP_RSRC_DPL;
drop index ACT_APP_APPDEF.ACT_IDX_APP_DEF_DPLY;
drop index ACT_APP_APPDEF.ACT_IDX_APP_DEF_UNIQ;

alter table ACT_APP_APPDEF
    drop CONSTRAINT ACT_FK_APP_DEF_DPLY;

drop table if exists ACT_APP_APPDEF cascade;
drop table if exists ACT_APP_DEPLOYMENT_RESOURCE cascade;
drop table if exists ACT_APP_DEPLOYMENT cascade;
