USE EAST4
GO


--1.表结构 
--1.1.新表
--1.1.1.公司部门信息表
IF  NOT EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TEDEPART') BEGIN
    CREATE TABLE TEDEPART
    (
            DEPART_ID           INTEGER         NOT NULL  IDENTITY,     --自动编号做主键
            PARENT_ID           INTEGER         NOT NULL,               --父级部门ID
            DEPART_CODE         NVARCHAR(40)    NOT NULL,               --部门代码
            DEPART_NAME         NVARCHAR(200)   NOT NULL,               --部门名称
            CLASS               NVARCHAR(100)   NOT NULL,               --部门分类(2012)
            MANAGER1            NVARCHAR(200)   NOT NULL,               --部门经理1
            MANAGER2            NVARCHAR(200)   NOT NULL,               --部门经理2
            LEADER              NVARCHAR(200)   NOT NULL,               --分管领导
            SUMMARY             NVARCHAR(2000)                          --部门说明
            CONSTRAINT PRI_TEDEPART PRIMARY KEY(DEPART_ID)
    )
    CREATE UNIQUE INDEX IDX_TEDEPART ON TEDEPART(DEPART_CODE)
END
--1.2. 新增字段
--1.2.1. TEREPORT.REPORT_FLAG
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('TEREPORT') and name = 'REPORT_FLAG') BEGIN

    ALTER TABLE TEREPORT ADD REPORT_FLAG INTEGER NOT NULL   DEFAULT 1   --申报标志：1-EAST申报表 2-其他表
END

GO


---2.数据处理
--2.1. 字典9003
IF NOT EXISTS(SELECT 1 FROM TEDICTPARAM WHERE TYPE_ID = 9003 AND TYPE_VALUE = 1) BEGIN
    INSERT INTO TEDICTPARAM(TYPE_ID,TYPE_NAME,TYPE_VALUE,TYPE_CONTENT)
        VALUES('9003',    '表申报标志' ,'1' , '申报表')

END
IF NOT EXISTS(SELECT 1 FROM TEDICTPARAM WHERE TYPE_ID = 9003 AND TYPE_VALUE = 9) BEGIN
    INSERT INTO TEDICTPARAM(TYPE_ID,TYPE_NAME,TYPE_VALUE,TYPE_CONTENT)
        VALUES('9003',    '表申报标志' ,'9' , '其他表')

END
GO
