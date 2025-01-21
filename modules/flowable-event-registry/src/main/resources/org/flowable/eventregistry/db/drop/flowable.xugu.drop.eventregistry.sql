drop index FLW_CHANNEL_DEFINITION.ACT_IDX_CHANNEL_DEF_UNIQ;
drop index FLW_EVENT_DEFINITION.ACT_IDX_EVENT_DEF_UNIQ;

drop table if exists FLW_CHANNEL_DEFINITION cascade;
drop table if exists FLW_EVENT_DEFINITION cascade;
drop table if exists FLW_EVENT_RESOURCE cascade;
drop table if exists FLW_EVENT_DEPLOYMENT cascade;
