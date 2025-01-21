CREATE TABLE ACT_APP_DEPLOYMENT (ID_ VARCHAR(255) NOT NULL, NAME_ VARCHAR(255) NULL, CATEGORY_ VARCHAR(255) NULL, KEY_ VARCHAR(255) NULL, DEPLOY_TIME_ datetime NULL, TENANT_ID_ VARCHAR(255) DEFAULT '' NULL, CONSTRAINT PK_ACT_APP_DEPLOYMENT PRIMARY KEY (ID_));

CREATE TABLE ACT_APP_DEPLOYMENT_RESOURCE (ID_ VARCHAR(255) NOT NULL, NAME_ VARCHAR(255) NULL, DEPLOYMENT_ID_ VARCHAR(255) NULL, RESOURCE_BYTES_ BLOB NULL, CONSTRAINT PK_APP_DEPLOYMENT_RESOURCE PRIMARY KEY (ID_));

ALTER TABLE ACT_APP_DEPLOYMENT_RESOURCE ADD CONSTRAINT ACT_FK_APP_RSRC_DPL FOREIGN KEY (DEPLOYMENT_ID_) REFERENCES ACT_APP_DEPLOYMENT (ID_);

CREATE INDEX ACT_IDX_APP_RSRC_DPL ON ACT_APP_DEPLOYMENT_RESOURCE(DEPLOYMENT_ID_);

CREATE TABLE ACT_APP_APPDEF (ID_ VARCHAR(255) NOT NULL, REV_ INT NOT NULL, NAME_ VARCHAR(255) NULL, KEY_ VARCHAR(255) NOT NULL, VERSION_ INT NOT NULL, CATEGORY_ VARCHAR(255) NULL, DEPLOYMENT_ID_ VARCHAR(255) NULL, RESOURCE_NAME_ VARCHAR(4000) NULL, DESCRIPTION_ VARCHAR(4000) NULL, TENANT_ID_ VARCHAR(255) DEFAULT '' NULL, CONSTRAINT PK_ACT_APP_APPDEF PRIMARY KEY (ID_));

ALTER TABLE ACT_APP_APPDEF ADD CONSTRAINT ACT_FK_APP_DEF_DPLY FOREIGN KEY (DEPLOYMENT_ID_) REFERENCES ACT_APP_DEPLOYMENT (ID_);

CREATE INDEX ACT_IDX_APP_DEF_DPLY ON ACT_APP_APPDEF(DEPLOYMENT_ID_);

ALTER TABLE ACT_APP_DEPLOYMENT MODIFY DEPLOY_TIME_ datetime(3) CASCADE;

CREATE UNIQUE INDEX ACT_IDX_APP_DEF_UNIQ ON ACT_APP_APPDEF(KEY_, VERSION_, TENANT_ID_);

insert into ACT_GE_PROPERTY
values ('app.schema.version', '7.1.0.2', 1);
