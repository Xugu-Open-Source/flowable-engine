alter table ACT_RU_VARIABLE
    drop CONSTRAINT ACT_FK_VAR_BYTEARRAY;

drop index ACT_RU_VARIABLE.ACT_IDX_RU_VAR_SCOPE_ID_TYPE;
drop index ACT_RU_VARIABLE.ACT_IDX_RU_VAR_SUB_ID_TYPE;

drop table if exists ACT_RU_VARIABLE;
