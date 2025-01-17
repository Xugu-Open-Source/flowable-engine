drop index ACT_RU_EXECUTION.ACT_IDX_EXEC_BUSKEY;
drop index ACT_RU_VARIABLE.ACT_IDX_VARIABLE_TASK_ID;
drop index ACT_PROCDEF_INFO.ACT_IDX_INFO_PROCDEF;

alter table ACT_GE_BYTEARRAY
    drop CONSTRAINT ACT_FK_BYTEARR_DEPL;

alter table ACT_RU_EXECUTION
    drop CONSTRAINT ACT_FK_EXE_PROCINST;

alter table ACT_RU_EXECUTION
    drop CONSTRAINT ACT_FK_EXE_PARENT;

alter table ACT_RU_EXECUTION
    drop CONSTRAINT ACT_FK_EXE_SUPER;

alter table ACT_RU_EXECUTION
    drop CONSTRAINT ACT_FK_EXE_PROCDEF;

alter table ACT_RU_IDENTITYLINK
    drop CONSTRAINT ACT_FK_TSKASS_TASK;

alter table ACT_RU_IDENTITYLINK
    drop CONSTRAINT ACT_FK_IDL_PROCINST;

alter table ACT_RU_IDENTITYLINK
    drop CONSTRAINT ACT_FK_ATHRZ_PROCEDEF;

alter table ACT_RU_TASK
	drop CONSTRAINT ACT_FK_TASK_EXE;

alter table ACT_RU_TASK
	drop CONSTRAINT ACT_FK_TASK_PROCINST;

alter table ACT_RU_TASK
	drop CONSTRAINT ACT_FK_TASK_PROCDEF;

alter table ACT_RU_VARIABLE
    drop CONSTRAINT ACT_FK_VAR_EXE;

alter table ACT_RU_VARIABLE
	drop CONSTRAINT ACT_FK_VAR_PROCINST;

alter table ACT_RU_JOB
    drop CONSTRAINT ACT_FK_JOB_EXECUTION;

alter table ACT_RU_JOB
    drop CONSTRAINT ACT_FK_JOB_PROCESS_INSTANCE;

alter table ACT_RU_JOB
    drop CONSTRAINT ACT_FK_JOB_PROC_DEF;

alter table ACT_RU_TIMER_JOB
    drop CONSTRAINT ACT_FK_TIMER_JOB_EXECUTION;

alter table ACT_RU_TIMER_JOB
    drop CONSTRAINT ACT_FK_TIMER_JOB_PROCESS_INSTANCE;

alter table ACT_RU_TIMER_JOB
    drop CONSTRAINT ACT_FK_TIMER_JOB_PROC_DEF;

alter table ACT_RU_SUSPENDED_JOB
    drop CONSTRAINT ACT_FK_SUSPENDED_JOB_EXECUTION;

alter table ACT_RU_SUSPENDED_JOB
    drop CONSTRAINT ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE;

alter table ACT_RU_SUSPENDED_JOB
    drop CONSTRAINT ACT_FK_SUSPENDED_JOB_PROC_DEF;

alter table ACT_RU_DEADLETTER_JOB
    drop CONSTRAINT ACT_FK_DEADLETTER_JOB_EXECUTION;

alter table ACT_RU_DEADLETTER_JOB
    drop CONSTRAINT ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE;

alter table ACT_RU_DEADLETTER_JOB
    drop CONSTRAINT ACT_FK_DEADLETTER_JOB_PROC_DEF;

alter table ACT_RU_EVENT_SUBSCR
    drop CONSTRAINT ACT_FK_EVENT_EXEC;

alter table ACT_RE_MODEL
    drop CONSTRAINT ACT_FK_MODEL_SOURCE;

alter table ACT_RE_MODEL
    drop CONSTRAINT ACT_FK_MODEL_SOURCE_EXTRA;

alter table ACT_RE_MODEL
    drop CONSTRAINT ACT_FK_MODEL_DEPLOYMENT;

alter table ACT_PROCDEF_INFO
    drop CONSTRAINT ACT_FK_INFO_JSON_BA;

alter table ACT_PROCDEF_INFO
    drop CONSTRAINT ACT_FK_INFO_PROCDEF;

drop index ACT_RU_IDENTITYLINK.ACT_IDX_ATHRZ_PROCEDEF;

drop index ACT_RU_ACTINST.ACT_IDX_RU_ACTI_START;
drop index ACT_RU_ACTINST.ACT_IDX_RU_ACTI_END;
drop index ACT_RU_ACTINST.ACT_IDX_RU_ACTI_PROC;
drop index ACT_RU_ACTINST.ACT_IDX_RU_ACTI_PROC_ACT;
drop index ACT_RU_ACTINST.ACT_IDX_RU_ACTI_EXEC;
drop index ACT_RU_ACTINST.ACT_IDX_RU_ACTI_EXEC_ACT;

drop table if exists ACT_RU_ACTINST cascade;
drop table if exists ACT_RE_DEPLOYMENT cascade;
drop table if exists ACT_RE_MODEL cascade;
drop table if exists ACT_RE_PROCDEF cascade;
drop table if exists ACT_RU_EXECUTION cascade;
drop table if exists ACT_EVT_LOG cascade;
drop table if exists ACT_PROCDEF_INFO cascade;