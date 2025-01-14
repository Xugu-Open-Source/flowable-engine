alter table ACT_RE_PROCDEF add column ENGINE_VERSION_ varchar(255);
update ACT_RE_PROCDEF set ENGINE_VERSION_ = 'v5';

alter table ACT_RE_DEPLOYMENT add column ENGINE_VERSION_ varchar(255);
update ACT_RE_DEPLOYMENT set ENGINE_VERSION_ = 'v5';

alter table ACT_RU_EXECUTION add column ROOT_PROC_INST_ID_ varchar(64);
create index ACT_IDX_EXEC_ROOT on ACT_RU_EXECUTION(ROOT_PROC_INST_ID_);

alter table ACT_RU_EXECUTION  drop CONSTRAINT ACT_FK_EXE_PARENT;
alter table ACT_RU_EXECUTION add constraint ACT_FK_EXE_PARENT foreign key (PARENT_ID_) references ACT_RU_EXECUTION (ID_) on delete cascade; 

alter table ACT_RU_EXECUTION drop CONSTRAINT ACT_FK_EXE_SUPER;
alter table ACT_RU_EXECUTION add constraint ACT_FK_EXE_SUPER foreign key (SUPER_EXEC_) references ACT_RU_EXECUTION (ID_) on delete cascade;

alter table ACT_RU_EXECUTION add column IS_MI_ROOT_ TINYINT;

create table ACT_RU_TIMER_JOB (
    ID_ varchar(64) NOT NULL,
    REV_ integer,
    TYPE_ varchar(255) NOT NULL,
    LOCK_EXP_TIME_ timestamp(3) NULL,
    LOCK_OWNER_ varchar(255),
    EXCLUSIVE_ boolean,
    EXECUTION_ID_ varchar(64),
    PROCESS_INSTANCE_ID_ varchar(64),
    PROC_DEF_ID_ varchar(64),
    RETRIES_ integer,
    EXCEPTION_STACK_ID_ varchar(64),
    EXCEPTION_MSG_ varchar(4000),
    DUEDATE_ timestamp(3) NULL,
    REPEAT_ varchar(255),
    HANDLER_TYPE_ varchar(255),
    HANDLER_CFG_ varchar(4000),
    TENANT_ID_ varchar(255) default '',
    primary key (ID_)
) ;

create table ACT_RU_SUSPENDED_JOB (
    ID_ varchar(64) NOT NULL,
    REV_ integer,
    TYPE_ varchar(255) NOT NULL,
    EXCLUSIVE_ boolean,
    EXECUTION_ID_ varchar(64),
    PROCESS_INSTANCE_ID_ varchar(64),
    PROC_DEF_ID_ varchar(64),
    RETRIES_ integer,
    EXCEPTION_STACK_ID_ varchar(64),
    EXCEPTION_MSG_ varchar(4000),
    DUEDATE_ timestamp(3) NULL,
    REPEAT_ varchar(255),
    HANDLER_TYPE_ varchar(255),
    HANDLER_CFG_ varchar(4000),
    TENANT_ID_ varchar(255) default '',
    primary key (ID_)
) ;

create table ACT_RU_DEADLETTER_JOB (
    ID_ varchar(64) NOT NULL,
    REV_ integer,
    TYPE_ varchar(255) NOT NULL,
    EXCLUSIVE_ boolean,
    EXECUTION_ID_ varchar(64),
    PROCESS_INSTANCE_ID_ varchar(64),
    PROC_DEF_ID_ varchar(64),
    EXCEPTION_STACK_ID_ varchar(64),
    EXCEPTION_MSG_ varchar(4000),
    DUEDATE_ timestamp(3) NULL,
    REPEAT_ varchar(255),
    HANDLER_TYPE_ varchar(255),
    HANDLER_CFG_ varchar(4000),
    TENANT_ID_ varchar(255) default '',
    primary key (ID_)
) ;

alter table ACT_RU_JOB 
    add constraint ACT_FK_JOB_EXECUTION 
    foreign key (EXECUTION_ID_) 
    references ACT_RU_EXECUTION (ID_);
    
alter table ACT_RU_JOB 
    add constraint ACT_FK_JOB_PROCESS_INSTANCE 
    foreign key (PROCESS_INSTANCE_ID_) 
    references ACT_RU_EXECUTION (ID_);
    
alter table ACT_RU_JOB 
    add constraint ACT_FK_JOB_PROC_DEF
    foreign key (PROC_DEF_ID_) 
    references ACT_RE_PROCDEF (ID_);
    
alter table ACT_RU_TIMER_JOB 
    add constraint ACT_FK_TIMER_JOB_EXECUTION 
    foreign key (EXECUTION_ID_) 
    references ACT_RU_EXECUTION (ID_);
    
alter table ACT_RU_TIMER_JOB 
    add constraint ACT_FK_TIMER_JOB_PROCESS_INSTANCE 
    foreign key (PROCESS_INSTANCE_ID_) 
    references ACT_RU_EXECUTION (ID_);
    
alter table ACT_RU_TIMER_JOB 
    add constraint ACT_FK_TIMER_JOB_PROC_DEF
    foreign key (PROC_DEF_ID_) 
    references ACT_RE_PROCDEF (ID_);
    
alter table ACT_RU_TIMER_JOB 
    add constraint ACT_FK_TIMER_JOB_EXCEPTION 
    foreign key (EXCEPTION_STACK_ID_) 
    references ACT_GE_BYTEARRAY (ID_);
    
alter table ACT_RU_SUSPENDED_JOB 
    add constraint ACT_FK_SUSPENDED_JOB_EXECUTION 
    foreign key (EXECUTION_ID_) 
    references ACT_RU_EXECUTION (ID_);
    
alter table ACT_RU_SUSPENDED_JOB 
    add constraint ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE 
    foreign key (PROCESS_INSTANCE_ID_) 
    references ACT_RU_EXECUTION (ID_);
    
alter table ACT_RU_SUSPENDED_JOB 
    add constraint ACT_FK_SUSPENDED_JOB_PROC_DEF
    foreign key (PROC_DEF_ID_) 
    references ACT_RE_PROCDEF (ID_);
    
alter table ACT_RU_SUSPENDED_JOB 
    add constraint ACT_FK_SUSPENDED_JOB_EXCEPTION 
    foreign key (EXCEPTION_STACK_ID_) 
    references ACT_GE_BYTEARRAY (ID_);
    
alter table ACT_RU_DEADLETTER_JOB 
    add constraint ACT_FK_DEADLETTER_JOB_EXECUTION 
    foreign key (EXECUTION_ID_) 
    references ACT_RU_EXECUTION (ID_);
    
alter table ACT_RU_DEADLETTER_JOB 
    add constraint ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE 
    foreign key (PROCESS_INSTANCE_ID_) 
    references ACT_RU_EXECUTION (ID_);
    
alter table ACT_RU_DEADLETTER_JOB 
    add constraint ACT_FK_DEADLETTER_JOB_PROC_DEF
    foreign key (PROC_DEF_ID_) 
    references ACT_RE_PROCDEF (ID_);
    
alter table ACT_RU_DEADLETTER_JOB 
    add constraint ACT_FK_DEADLETTER_JOB_EXCEPTION 
    foreign key (EXCEPTION_STACK_ID_) 
    references ACT_GE_BYTEARRAY (ID_);
    
    
-- Moving jobs with retries <= 0 to ACT_RU_DEADLETTER_JOB

INSERT INTO ACT_RU_DEADLETTER_JOB (ID_, REV_, TYPE_, EXCLUSIVE_, EXECUTION_ID_, PROCESS_INSTANCE_ID_, PROC_DEF_ID_, 
EXCEPTION_STACK_ID_,     EXCEPTION_MSG_, DUEDATE_, REPEAT_, HANDLER_TYPE_, HANDLER_CFG_, TENANT_ID_)
(SELECT ID_, REV_, TYPE_, EXCLUSIVE_, EXECUTION_ID_, PROCESS_INSTANCE_ID_, PROC_DEF_ID_, 
EXCEPTION_STACK_ID_, EXCEPTION_MSG_, DUEDATE_, REPEAT_, HANDLER_TYPE_, HANDLER_CFG_, TENANT_ID_ 
from ACT_RU_JOB WHERE RETRIES_ <= 0);

DELETE FROM ACT_RU_JOB 
WHERE RETRIES_ <= 0;


-- Moving suspended jobs to ACT_RU_SUSPENDED_JOB

INSERT INTO ACT_RU_SUSPENDED_JOB (ID_, REV_, TYPE_, EXCLUSIVE_, EXECUTION_ID_, PROCESS_INSTANCE_ID_, PROC_DEF_ID_, 
RETRIES_, EXCEPTION_STACK_ID_,     EXCEPTION_MSG_, DUEDATE_, REPEAT_, HANDLER_TYPE_, HANDLER_CFG_, TENANT_ID_)
(SELECT job.ID_, job.REV_, job.TYPE_, job.EXCLUSIVE_, job.EXECUTION_ID_, job.PROCESS_INSTANCE_ID_, job.PROC_DEF_ID_, 
job.RETRIES_, job.EXCEPTION_STACK_ID_, job.EXCEPTION_MSG_, job.DUEDATE_, job.REPEAT_, job.HANDLER_TYPE_, job.HANDLER_CFG_, job.TENANT_ID_ 
from ACT_RU_JOB job INNER JOIN ACT_RU_EXECUTION execution on execution.ID_ = job.PROCESS_INSTANCE_ID_ where execution.SUSPENSION_STATE_ = 2);

DELETE FROM ACT_RU_JOB
WHERE PROCESS_INSTANCE_ID_ IN (SELECT ID_ FROM ACT_RU_EXECUTION execution WHERE execution.PARENT_ID_ is null and execution.SUSPENSION_STATE_ = 2);



-- Moving timer jobs to ACT_RU_TIMER_JOB

INSERT INTO ACT_RU_TIMER_JOB (ID_, REV_, TYPE_, LOCK_EXP_TIME_, LOCK_OWNER_, EXCLUSIVE_, EXECUTION_ID_, PROCESS_INSTANCE_ID_, 
PROC_DEF_ID_, RETRIES_, EXCEPTION_STACK_ID_, EXCEPTION_MSG_, DUEDATE_, REPEAT_, HANDLER_TYPE_, HANDLER_CFG_, TENANT_ID_)
(SELECT ID_, REV_, TYPE_, LOCK_EXP_TIME_, LOCK_OWNER_, EXCLUSIVE_, EXECUTION_ID_, PROCESS_INSTANCE_ID_, 
PROC_DEF_ID_, RETRIES_, EXCEPTION_STACK_ID_, EXCEPTION_MSG_, DUEDATE_, REPEAT_, HANDLER_TYPE_, HANDLER_CFG_, TENANT_ID_ 
from ACT_RU_JOB WHERE (HANDLER_TYPE_ = 'activate-processdefinition' or HANDLER_TYPE_ = 'suspend-processdefinition' 
or HANDLER_TYPE_ = 'timer-intermediate-transition' or HANDLER_TYPE_ = 'timer-start-event' or HANDLER_TYPE_ = 'timer-transition') and LOCK_EXP_TIME_ is null);

DELETE FROM ACT_RU_JOB 
WHERE (HANDLER_TYPE_ = 'activate-processdefinition' 
    or HANDLER_TYPE_ = 'suspend-processdefinition' 
    or HANDLER_TYPE_ = 'timer-intermediate-transition' 
    or HANDLER_TYPE_ = 'timer-start-event' 
    or HANDLER_TYPE_ = 'timer-transition') 
and LOCK_EXP_TIME_ is null;
    

alter table ACT_RU_EXECUTION add column START_TIME_ datetime(3);
alter table ACT_RU_EXECUTION add column START_USER_ID_ varchar(255);
alter table ACT_RU_TASK add column CLAIM_TIME_ datetime(3);

alter table ACT_RE_DEPLOYMENT add column KEY_ varchar(255);

-- Upgrade added in upgradestep.52001.to.52002.engine, which is not applied when already on beta2 
update ACT_RU_EVENT_SUBSCR set PROC_DEF_ID_ = CONFIGURATION_ where EVENT_TYPE_ = 'message' and PROC_INST_ID_ is null and EXECUTION_ID_ is null and PROC_DEF_ID_ is null;

-- Adding count columns for execution relationship count feature
alter table ACT_RU_EXECUTION add column IS_COUNT_ENABLED_ BOOLEAN;
alter table ACT_RU_EXECUTION add column EVT_SUBSCR_COUNT_ integer; 
alter table ACT_RU_EXECUTION add column TASK_COUNT_ integer; 
alter table ACT_RU_EXECUTION add column JOB_COUNT_ integer; 
alter table ACT_RU_EXECUTION add column TIMER_JOB_COUNT_ integer;
alter table ACT_RU_EXECUTION add column SUSP_JOB_COUNT_ integer;
alter table ACT_RU_EXECUTION add column DEADLETTER_JOB_COUNT_ integer;
alter table ACT_RU_EXECUTION add column VAR_COUNT_ integer;
alter table ACT_RU_EXECUTION add column ID_LINK_COUNT_ integer;

alter table ACT_RU_TASK add column IS_COUNT_ENABLED_ BOOLEAN;
alter table ACT_RU_TASK add column VAR_COUNT_ integer;
alter table ACT_RU_TASK add column ID_LINK_COUNT_ integer;

update ACT_GE_PROPERTY set VALUE_ = '6.0.0.5' where NAME_ = 'schema.version';

create table ACT_ID_PROPERTY (
    NAME_ varchar(64),
    VALUE_ varchar(300),
    REV_ integer,
    primary key (NAME_)
) ;

insert into ACT_ID_PROPERTY
values ('schema.version', '6.0.0.5', 1);

create table ACT_ID_BYTEARRAY (
    ID_ varchar(64),
    REV_ integer,
    NAME_ varchar(255),
    BYTES_ BLOB,
    primary key (ID_)
) ;

create table ACT_ID_TOKEN (
    ID_ varchar(64) not null,
    REV_ integer,
    TOKEN_VALUE_ varchar(255),
    TOKEN_DATE_ timestamp(3),
    IP_ADDRESS_ varchar(255),
    USER_AGENT_ varchar(255),
    USER_ID_ varchar(255),
    TOKEN_DATA_ varchar(2000),
    primary key (ID_)
) ;

create table ACT_ID_PRIV (
    ID_ varchar(64) not null,
    NAME_ varchar(255),
    primary key (ID_)
) ;

create table ACT_ID_PRIV_MAPPING (
    ID_ varchar(64) not null,
    PRIV_ID_ varchar(64) not null,
    USER_ID_ varchar(255),
    GROUP_ID_ varchar(255),
    primary key (ID_)
) ;

alter table ACT_ID_PRIV_MAPPING 
    add constraint ACT_FK_PRIV_MAPPING 
    foreign key (PRIV_ID_) 
    references ACT_ID_PRIV (ID_);
    
create index ACT_IDX_PRIV_USER on ACT_ID_PRIV_MAPPING(USER_ID_);
create index ACT_IDX_PRIV_GROUP on ACT_ID_PRIV_MAPPING(GROUP_ID_);   

CREATE TABLE ACT_DMN_DATABASECHANGELOGLOCK (ID INT NOT NULL, LOCKED BIT(1) NOT NULL, LOCKGRANTED datetime NULL, LOCKEDBY VARCHAR(255) NULL, CONSTRAINT PK_ACT_DMN_DATABASECHANGELOGLOCK PRIMARY KEY (ID));

DELETE FROM ACT_DMN_DATABASECHANGELOGLOCK;

INSERT INTO ACT_DMN_DATABASECHANGELOGLOCK (ID, LOCKED) VALUES (1, 0);

UPDATE ACT_DMN_DATABASECHANGELOGLOCK SET LOCKED = 1, LOCKEDBY = '192.168.1.5 (192.168.1.5)', LOCKGRANTED = '2019-03-13 21:02:29.551' WHERE ID = 1 AND LOCKED = 0;

CREATE TABLE ACT_DMN_DATABASECHANGELOG (ID VARCHAR(255) NOT NULL, AUTHOR VARCHAR(255) NOT NULL, FILENAME VARCHAR(255) NOT NULL, DATEEXECUTED datetime NOT NULL, ORDEREXECUTED INT NOT NULL, EXECTYPE VARCHAR(10) NOT NULL, MD5SUM VARCHAR(35) NULL, DESCRIPTION VARCHAR(255) NULL, COMMENTS VARCHAR(255) NULL, TAG VARCHAR(255) NULL, LIQUIBASE VARCHAR(20) NULL, CONTEXTS VARCHAR(255) NULL, LABELS VARCHAR(255) NULL, DEPLOYMENT_ID VARCHAR(10) NULL);

CREATE TABLE ACT_DMN_DEPLOYMENT (ID_ VARCHAR(255) NOT NULL, NAME_ VARCHAR(255) NULL, CATEGORY_ VARCHAR(255) NULL, DEPLOY_TIME_ datetime NULL, TENANT_ID_ VARCHAR(255) NULL, PARENT_DEPLOYMENT_ID_ VARCHAR(255) NULL, CONSTRAINT PK_ACT_DMN_DEPLOYMENT PRIMARY KEY (ID_));

CREATE TABLE ACT_DMN_DEPLOYMENT_RESOURCE (ID_ VARCHAR(255) NOT NULL, NAME_ VARCHAR(255) NULL, DEPLOYMENT_ID_ VARCHAR(255) NULL, RESOURCE_BYTES_ BLOB NULL, CONSTRAINT PK_ACT_DMN_DEPLOYMENT_RESOURCE PRIMARY KEY (ID_));

CREATE TABLE ACT_DMN_DECISION_TABLE (ID_ VARCHAR(255) NOT NULL, NAME_ VARCHAR(255) NULL, VERSION_ INT NULL, KEY_ VARCHAR(255) NULL, CATEGORY_ VARCHAR(255) NULL, DEPLOYMENT_ID_ VARCHAR(255) NULL, PARENT_DEPLOYMENT_ID_ VARCHAR(255) NULL, TENANT_ID_ VARCHAR(255) NULL, RESOURCE_NAME_ VARCHAR(255) NULL, DESCRIPTION_ VARCHAR(255) NULL, CONSTRAINT PK_ACT_DMN_DECISION_TABLE PRIMARY KEY (ID_));

INSERT INTO ACT_DMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('1', 'activiti', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', NOW(), 1, '7:d878c2672ead57b5801578fd39c423af', 'createTable tableName=ACT_DMN_DEPLOYMENT; createTable tableName=ACT_DMN_DEPLOYMENT_RESOURCE; createTable tableName=ACT_DMN_DECISION_TABLE', '', 'EXECUTED', NULL, NULL, '3.5.3', '2507349622');

UPDATE ACT_DMN_DATABASECHANGELOGLOCK SET LOCKED = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;


CREATE TABLE ACT_FO_DATABASECHANGELOGLOCK (ID INT NOT NULL, LOCKED BIT(1) NOT NULL, LOCKGRANTED datetime NULL, LOCKEDBY VARCHAR(255) NULL, CONSTRAINT PK_ACT_FO_DATABASECHANGELOGLOCK PRIMARY KEY (ID));

DELETE FROM ACT_FO_DATABASECHANGELOGLOCK;

INSERT INTO ACT_FO_DATABASECHANGELOGLOCK (ID, LOCKED) VALUES (1, 0);

UPDATE ACT_FO_DATABASECHANGELOGLOCK SET LOCKED = 1, LOCKEDBY = '192.168.1.5 (192.168.1.5)', LOCKGRANTED = '2019-03-13 21:02:29.829' WHERE ID = 1 AND LOCKED = 0;

CREATE TABLE ACT_FO_DATABASECHANGELOG (ID VARCHAR(255) NOT NULL, AUTHOR VARCHAR(255) NOT NULL, FILENAME VARCHAR(255) NOT NULL, DATEEXECUTED datetime NOT NULL, ORDEREXECUTED INT NOT NULL, EXECTYPE VARCHAR(10) NOT NULL, MD5SUM VARCHAR(35) NULL, DESCRIPTION VARCHAR(255) NULL, COMMENTS VARCHAR(255) NULL, TAG VARCHAR(255) NULL, LIQUIBASE VARCHAR(20) NULL, CONTEXTS VARCHAR(255) NULL, LABELS VARCHAR(255) NULL, DEPLOYMENT_ID VARCHAR(10) NULL);

CREATE TABLE ACT_FO_FORM_DEPLOYMENT (ID_ VARCHAR(255) NOT NULL, NAME_ VARCHAR(255) NULL, CATEGORY_ VARCHAR(255) NULL, DEPLOY_TIME_ datetime NULL, TENANT_ID_ VARCHAR(255) NULL, PARENT_DEPLOYMENT_ID_ VARCHAR(255) NULL, CONSTRAINT PK_ACT_FO_FORM_DEPLOYMENT PRIMARY KEY (ID_));

CREATE TABLE ACT_FO_FORM_RESOURCE (ID_ VARCHAR(255) NOT NULL, NAME_ VARCHAR(255) NULL, DEPLOYMENT_ID_ VARCHAR(255) NULL, RESOURCE_BYTES_ BLOB NULL, CONSTRAINT PK_ACT_FO_FORM_RESOURCE PRIMARY KEY (ID_));

CREATE TABLE ACT_FO_FORM_DEFINITION (ID_ VARCHAR(255) NOT NULL, NAME_ VARCHAR(255) NULL, VERSION_ INT NULL, KEY_ VARCHAR(255) NULL, CATEGORY_ VARCHAR(255) NULL, DEPLOYMENT_ID_ VARCHAR(255) NULL, PARENT_DEPLOYMENT_ID_ VARCHAR(255) NULL, TENANT_ID_ VARCHAR(255) NULL, RESOURCE_NAME_ VARCHAR(255) NULL, DESCRIPTION_ VARCHAR(255) NULL, CONSTRAINT PK_ACT_FO_FORM_DEFINITION PRIMARY KEY (ID_));

CREATE TABLE ACT_FO_FORM_INSTANCE (ID_ VARCHAR(255) NOT NULL, FORM_DEFINITION_ID_ VARCHAR(255) NOT NULL, TASK_ID_ VARCHAR(255) NULL, PROC_INST_ID_ VARCHAR(255) NULL, PROC_DEF_ID_ VARCHAR(255) NULL, SUBMITTED_DATE_ datetime NULL, SUBMITTED_BY_ VARCHAR(255) NULL, FORM_VALUES_ID_ VARCHAR(255) NULL, TENANT_ID_ VARCHAR(255) NULL, CONSTRAINT PK_ACT_FO_FORM_INSTANCE PRIMARY KEY (ID_));

INSERT INTO ACT_FO_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('1', 'activiti', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', NOW(), 1, '7:252bd5cb28cf86685ed67eb15d910118', 'createTable tableName=ACT_FO_FORM_DEPLOYMENT; createTable tableName=ACT_FO_FORM_RESOURCE; createTable tableName=ACT_FO_FORM_DEFINITION; createTable tableName=ACT_FO_FORM_INSTANCE', '', 'EXECUTED', NULL, NULL, '3.5.3', '2507349856');

UPDATE ACT_FO_DATABASECHANGELOGLOCK SET LOCKED = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;


CREATE TABLE ACT_CO_DATABASECHANGELOGLOCK (ID INT NOT NULL, LOCKED BIT(1) NOT NULL, LOCKGRANTED datetime NULL, LOCKEDBY VARCHAR(255) NULL, CONSTRAINT PK_ACT_CO_DATABASECHANGELOGLOCK PRIMARY KEY (ID));

DELETE FROM ACT_CO_DATABASECHANGELOGLOCK;

INSERT INTO ACT_CO_DATABASECHANGELOGLOCK (ID, LOCKED) VALUES (1, 0);

UPDATE ACT_CO_DATABASECHANGELOGLOCK SET LOCKED = 1, LOCKEDBY = '192.168.1.5 (192.168.1.5)', LOCKGRANTED = '2019-03-13 21:02:30.051' WHERE ID = 1 AND LOCKED = 0;

CREATE TABLE ACT_CO_DATABASECHANGELOG (ID VARCHAR(255) NOT NULL, AUTHOR VARCHAR(255) NOT NULL, FILENAME VARCHAR(255) NOT NULL, DATEEXECUTED datetime NOT NULL, ORDEREXECUTED INT NOT NULL, EXECTYPE VARCHAR(10) NOT NULL, MD5SUM VARCHAR(35) NULL, DESCRIPTION VARCHAR(255) NULL, COMMENTS VARCHAR(255) NULL, TAG VARCHAR(255) NULL, LIQUIBASE VARCHAR(20) NULL, CONTEXTS VARCHAR(255) NULL, LABELS VARCHAR(255) NULL, DEPLOYMENT_ID VARCHAR(10) NULL);

CREATE TABLE ACT_CO_CONTENT_ITEM (ID_ VARCHAR(255) NOT NULL, NAME_ VARCHAR(255) NOT NULL, MIME_TYPE_ VARCHAR(255) NULL, TASK_ID_ VARCHAR(255) NULL, PROC_INST_ID_ VARCHAR(255) NULL, CONTENT_STORE_ID_ VARCHAR(255) NULL, CONTENT_STORE_NAME_ VARCHAR(255) NULL, FIELD_ VARCHAR(400) NULL, CONTENT_AVAILABLE_ BIT(1) DEFAULT 0 NULL, CREATED_ timestamp(6) NULL, CREATED_BY_ VARCHAR(255) NULL, LAST_MODIFIED_ timestamp(6) NULL, LAST_MODIFIED_BY_ VARCHAR(255) NULL, CONTENT_SIZE_ BIGINT DEFAULT 0 NULL, TENANT_ID_ VARCHAR(255) NULL, CONSTRAINT PK_ACT_CO_CONTENT_ITEM PRIMARY KEY (ID_));

CREATE INDEX idx_contitem_taskid ON ACT_CO_CONTENT_ITEM(TASK_ID_);

CREATE INDEX idx_contitem_procid ON ACT_CO_CONTENT_ITEM(PROC_INST_ID_);

INSERT INTO ACT_CO_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('1', 'activiti', 'org/flowable/content/db/liquibase/flowable-content-db-changelog.xml', NOW(), 1, '7:a17df43ed0c96adfef5271e1781aaed2', 'createTable tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_taskid, tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_procid, tableName=ACT_CO_CONTENT_ITEM', '', 'EXECUTED', NULL, NULL, '3.5.3', '2507350085');

UPDATE ACT_CO_DATABASECHANGELOGLOCK SET LOCKED = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;

