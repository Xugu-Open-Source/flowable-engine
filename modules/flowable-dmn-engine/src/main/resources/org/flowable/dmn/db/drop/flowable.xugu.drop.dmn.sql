drop index ACT_DMN_HI_DECISION_EXECUTION.ACT_IDX_DMN_INSTANCE_ID;
drop index ACT_DMN_DECISION.ACT_IDX_DMN_DEC_UNIQ;

drop table if exists ACT_DMN_HI_DECISION_EXECUTION cascade;
drop table if exists ACT_DMN_DECISION cascade;
drop table if exists ACT_DMN_DEPLOYMENT_RESOURCE cascade;
drop table if exists ACT_DMN_DEPLOYMENT cascade;
