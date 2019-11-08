USE EAST4
GO
--1.0. 系统表
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TESYSTEMINFO')
    DROP TABLE TESYSTEMINFO
GO
CREATE TABLE TESYSTEMINFO
(
        SYSTEM_ID           INTEGER         NOT NULL    IDENTITY,       --自动编号做主键
        VERSION             NVARCHAR(64)    NOT NULL,                   --字典ID
        INIT_DATE           DATETIME        NOT NULL    DEFAULT GETDATE(),
        CURRENT_MONTH       INTEGER         NOT NULL,
        REP_1ST_START_DATE  INTEGER         NOT NULL,
        REP_1ST_END_DATE    INTEGER         NOT NULL,
		USER_ID             INTEGER,
        CONSTRAINT PRI_TESYSTEMINFO PRIMARY KEY(SYSTEM_ID)
)
GO

--1.1. 字典表
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TEDICTPARAM')
    DROP TABLE TEDICTPARAM
GO
CREATE TABLE TEDICTPARAM
(
        SERIAL_NO       INTEGER         NOT NULL    IDENTITY,   --自动编号做主键
        TYPE_ID         NVARCHAR(10)    NOT NULL,               --字典ID
        TYPE_NAME       NVARCHAR(255)   NOT NULL,               --字典说明
        TYPE_VALUE      NVARCHAR(100)   NOT NULL,               --字典值
        TYPE_CONTENT    NVARCHAR(100)   NOT NULL,               --字典值说明
        CONSTRAINT PRI_TEDICTPARAM PRIMARY KEY(SERIAL_NO)
)
CREATE UNIQUE INDEX IDX_TEDICTPARAM ON TEDICTPARAM(TYPE_ID,TYPE_VALUE)
GO


--1.2. 数据元
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TEMETADATA')
    DROP TABLE TEMETADATA
GO
CREATE TABLE TEMETADATA
(
        SERIAL_NO           INTEGER         NOT NULL    IDENTITY,   --自动编号做主键
        META_CODE           NVARCHAR(6)     NOT NULL,               --数据元编码
        META_NAME           NVARCHAR(100)   NOT NULL,               --数据元名称
        META_EN_NAME        NVARCHAR(100)   NOT NULL,               --数据元英文名称
        CATALOG_TYPE        NVARCHAR(100)   NOT NULL,               --分类
        CATALOG_TYPE_NAME   NVARCHAR(100)   NOT NULL,               --分类说明
        DATA_TYPE           NVARCHAR(100)   NOT NULL,               --数据类型
        DATA_TYPE_NAME      NVARCHAR(100)   NOT NULL,               --数据类型说明
        DATA_LENGTH         INTEGER         NOT NULL,               --数据长度
        DATA_PRECISION      INTEGER,                                --精度 
        DATA_METHOD         NVARCHAR(100)   NOT NULL,               --数据来源方法（input/selected）
        DATA_METHOD_NAME    NVARCHAR(100)   NOT NULL,               --数据来源方法（input/selected）
        DATA_REF            INTEGER         NOT NULL,               --引用字典
        DEFAULT_VALUE       NVARCHAR(2000)  NOT NULL    DEFAULT '', --默认值
        SUMMARY             NVARCHAR(512)                           --数据源说明
        CONSTRAINT PRI_TEMETADATA PRIMARY KEY(SERIAL_NO)
)
CREATE UNIQUE INDEX IDX_TEMETADATA ON TEMETADATA(META_CODE)
GO

--20.系统开关参数配置表
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TSYSCONTROL')
    DROP TABLE TSYSCONTROL
GO
CREATE TABLE TSYSCONTROL(
    SERIAL_NO   INTEGER          NOT NULL    IDENTITY,      --自动编号做主键
    FLAG_TYPE   NVARCHAR(30)     NOT NULL,                  --开关名
    TYPE_NAME   NVARCHAR(30)     NOT NULL,                  --开关中文名
    VALUE       INTEGER          NOT NULL DEFAULT 0,        --值
    SUMMARY     NVARCHAR(200),                              --说明
    CONSTRAINT PRI_TSYSCONTROL PRIMARY KEY(FLAG_TYPE) )
GO
CREATE INDEX IDX_TSYSCONTROL1 ON TSYSCONTROL(FLAG_TYPE ASC,VALUE ASC)
GO

--1.3. 申报表
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TEREPORT')
    DROP TABLE TEREPORT
GO
CREATE TABLE TEREPORT
(
        REPORT_ID           INTEGER             NOT NULL,               --编号做主键
        REPORT_CODE         NVARCHAR(6)         NOT NULL,               --表编号 
        REPORT_NAME         NVARCHAR(60)        NOT NULL,               --表名称
        FILE_NAME           NVARCHAR(100)       NOT NULL,               --传输文件名
        CATALOG_TYPE        NVARCHAR(100)       NOT NULL,               --分类
        CATALOG_TYPE_NAME   NVARCHAR(100)       NOT NULL,               --分类说明
        SUMMARY             NVARCHAR(512),                              --数据源说明
        CONSTRAINT PRI_TEREPORT PRIMARY KEY(REPORT_ID)
)

CREATE UNIQUE INDEX IDX_TEREPORT1 ON TEREPORT(REPORT_CODE)
GO

--1.4. 申报表 字段表
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TEREPORTFIELD')
    DROP TABLE TEREPORTFIELD
GO
CREATE TABLE TEREPORTFIELD
(
        SERIAL_NO           INTEGER         NOT NULL  IDENTITY,     --自动编号做主键
        REPORT_ID           INTEGER         NOT NULL,               --表
        FIELD_CODE          NVARCHAR(30)    NOT NULL,               --数据项代码
        FIELD_NAME          NVARCHAR(100)   NOT NULL,               --数据项名称
        --META_CODE           NVARCHAR(6)     NOT NULL,               --数据元编码
        SUMMARY             NVARCHAR(512),                          --备注
        MAP_VALUE           NVARCHAR(512),                          --
        DEFAULT_VALUE       NVARCHAR(512),
        LOCK_FLAG           INTEGER         NOT NULL    DEFAULT 1,  --数据同步更新锁定标志 ：1.不锁(可更新) 2.锁定 (不可更新)
        MODI_FLAG           INTEGER         NOT NULL    DEFAULT 2,  --EAST4是否能界面修改，1 不能修改，2是能修改
        VERIFY_FLAG         INTEGER         NOT NULL    DEFAULT 0,  --数据验证：0-忽略 1-普通验证 2-级联验证
        REF_FIELD_CODE      NVARCHAR(30),
        HINT                NVARCHAR(512),
        MESSAGE             NVARCHAR(512)
        CONSTRAINT PRI_TEREPORTFIELD PRIMARY KEY(SERIAL_NO)
)
CREATE UNIQUE INDEX IDX_TEREPORTFIELD ON TEREPORTFIELD(REPORT_ID,FIELD_CODE)
GO

IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TEREPORTFIELDVERIFY')
    DROP TABLE TEREPORTFIELDVERIFY
GO
CREATE TABLE TEREPORTFIELDVERIFY
(
        SERIAL_NO           INTEGER         NOT NULL  IDENTITY,     --自动编号做主键
        REPORT_ID           INTEGER         NOT NULL,               --表
        FIELD_CODE          NVARCHAR(30)    NOT NULL,               --数据项代码
        FIELD_NAME          NVARCHAR(100)   NOT NULL,               --数据项名称
        REF_FIELD_CODE      NVARCHAR(30)    NOT NULL,               --引用数据项代码
        REF_FIELD_VALUE     NVARCHAR(512)   NOT NULL,               --引用数据项值
        CONSTRAINT PRI_TEREPORTFIELDVERIFY PRIMARY KEY(SERIAL_NO)
)
CREATE UNIQUE INDEX IDX_TEREPORTFIELDVERIFY ON TEREPORTFIELDVERIFY(REPORT_ID,FIELD_CODE,REF_FIELD_CODE,REF_FIELD_VALUE)
GO

--1.5. MAP
IF EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TEREPORTFIELDVALUEMAP')
    DROP TABLE TEREPORTFIELDVALUEMAP
GO
CREATE TABLE TEREPORTFIELDVALUEMAP
(
        SERIAL_NO           INTEGER         NOT NULL  IDENTITY,     --自动编号做主键
        REPORT_ID           INTEGER         NOT NULL,               --表
        FIELD_CODE          NVARCHAR(30)    NOT NULL,               --数据项代码
        TYPE_ID             NVARCHAR(6)     NOT NULL,               --TE字典ID
        TYPE_VALUE          NVARCHAR(100)   NOT NULL,               --字典值
        TYPE_CONTENT        NVARCHAR(100)   NOT NULL,               --字典值说明
        MAP_VALUE           NVARCHAR(100)   NOT NULL,               --映射数据源参数
        CONSTRAINT PRI_TEREPORTFIELDVALUEMAP PRIMARY KEY(SERIAL_NO)
)
CREATE UNIQUE INDEX IDX_TEREPORTFIELDVALUEMAP ON TEREPORTFIELDVALUEMAP(REPORT_ID,FIELD_CODE,TYPE_ID,TYPE_VALUE,MAP_VALUE)
GO


IF EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TEREPORTLOG')
    DROP TABLE TEREPORTLOG
GO
CREATE TABLE TEREPORTLOG(
    LOG_ID          INTEGER         NOT NULL    IDENTITY,
    REPORT_ID       INTEGER         NOT NULL, 
    REPORT_CODE     NVARCHAR(6)     NOT NULL, 
    REPORT_NAME     NVARCHAR(60)    NOT NULL, 
    TABLE_NAME      NVARCHAR(128)   NOT NULL,
    TABLE_SN        INTEGER         NOT NULL,                  --对应表的记录号
    KEY_NAME        NVARCHAR(256)   NOT NULL,
    KEY_VALUE       NVARCHAR(128)   NOT NULL,
    OLD_XML         XML,
    NEW_XML         XML,
    VAR_OLD_VALUE   DECIMAL(20,2),
    VAR_NEW_VALUE   DECIMAL(20,2),
    REPORT_FLAG1    INTEGER         NOT NULL    DEFAULT 0,        --要素变更情况:0-未变更 1-已变更
    REPORT_FLAG2    INTEGER         NOT NULL    DEFAULT 0,        --时点变更情况:0-未变更 1-已变更
    REPORT_FLAG     INTEGER         NOT NULL    DEFAULT 1,         --0-忽略 1-变化量 2-增量
    REPORT_MONTH    INTEGER         NOT NULL
    CONSTRAINT PRI_TEREPORTLOG PRIMARY KEY(LOG_ID)
)
    
CREATE UNIQUE INDEX IDX_TEREPORTLOG ON TEREPORTLOG(REPORT_ID,TABLE_NAME,TABLE_SN)
GO

IF EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'HEREPORTLOG')
    DROP TABLE HEREPORTLOG
GO
CREATE TABLE HEREPORTLOG(
    LOG_ID          INTEGER         NOT NULL    IDENTITY,
    TLOG_ID         INTEGER         NOT NULL,
    REPORT_ID       INTEGER         NOT NULL, 
    REPORT_CODE     NVARCHAR(6)     NOT NULL, 
    REPORT_NAME     NVARCHAR(60)    NOT NULL, 
    TABLE_NAME      NVARCHAR(128)   NOT NULL,
    TABLE_SN        INTEGER         NOT NULL,                  --对应表的记录号
    KEY_NAME        NVARCHAR(256)   NOT NULL,
    KEY_VALUE       NVARCHAR(128)   NOT NULL,
    OLD_XML         XML,
    NEW_XML         XML,
    VAR_OLD_VALUE   DECIMAL(20,2),
    VAR_NEW_VALUE   DECIMAL(20,2),
    REPORT_FLAG1    INTEGER         NOT NULL    DEFAULT 0,        --要素变更情况:0-未变更 1-已变更
    REPORT_FLAG2    INTEGER         NOT NULL    DEFAULT 0,        --时点变更情况:0-未变   1-已变更
    REPORT_FLAG     INTEGER,
    REPORT_MONTH    INTEGER         NOT NULL
    CONSTRAINT PRI_HEREPORTLOG PRIMARY KEY(LOG_ID)
)
CREATE UNIQUE INDEX IDX_HEREPORTLOG ON HEREPORTLOG(REPORT_MONTH,REPORT_ID,TABLE_NAME,KEY_VALUE)
GO