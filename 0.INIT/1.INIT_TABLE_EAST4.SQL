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


--1.2.系统开关参数配置表
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
        DATA_TYPE           NVARCHAR(100)   NOT NULL,               --数据类型
        DATA_LENGTH         INTEGER         NOT NULL,               --数据长度
        DATA_PRECISION      INTEGER,                                --精度 
        DATA_METHOD         NVARCHAR(100)   NOT NULL,               --数据来源方法（input/selected）
        DATA_REF            NVARCHAR(100),                          --引用字典
        SUMMARY             NVARCHAR(512),                          --备注
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



--2.详细表
--2.1. 机构信息表
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TA01JGXXB')
    DROP TABLE TA01JGXXB
GO
CREATE TABLE TA01JGXXB
(   
        ID                  INTEGER         NOT NULL    IDENTITY,
        XTJGDM              NVARCHAR(3)     NOT NULL            ,   --信托机构代码(001) 必填
        XTJGMC              NVARCHAR(200)   NOT NULL            ,   --信托机构名称      必填
        TYSHXYDM            NVARCHAR(40)    NOT NULL            ,   --统一社会信用代码  必填
        XTGSJYFW            NVARCHAR(2000)  NOT NULL            ,   --信托公司经营范围  必填
        ZCZB                DECIMAL(20,2)   NOT NULL            ,   --注册资本          必填
        ZCDQ                NVARCHAR(6)     NOT NULL            ,   --注册地区(002)     必填
        ZCDZ                NVARCHAR(2000)  NOT NULL            ,   --注册地址          必填
        FDDBR               NVARCHAR(200)   NOT NULL            ,   --法定代表人        必填
        SJKZRBS             NVARCHAR(1)     NOT NULL            ,   --实际控制人标识(003)必填
        SJKZRLX             NVARCHAR(1)     NOT NULL            ,   --实际控制人类型(004)必填
        SJKZRMC             NVARCHAR(200)                       ,   --实际控制人名称            "选择性填写若实际控制人标识选是，需填写"
        SJKZRZJLX           NVARCHAR(2)                         ,   --实际控制人证件类型(005)   "选择性填写若实际控制人标识选是，需填写"
        SJKZRZJHM           NVARCHAR(60)                        ,   --实际控制人证件号码        "选择性填写若实际控制人标识选是，需填写" 自然人实际控制人的身份证件号码为隐私，信托机构变形。
        CONSTRAINT PRI_TA01JGXXB  PRIMARY KEY(ID)
)
GO

--2.2.股东信息表
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TA02GDXXB')
    DROP TABLE TA02GDXXB
GO

CREATE TABLE TA02GDXXB
(   
        ID          INTEGER         NOT NULL    IDENTITY ,
        XTJGDM      NVARCHAR(3)     NOT NULL             ,   --信托机构代码必填
        XTJGMC      NVARCHAR(200)   NOT NULL             ,   --股东名称必填
        GDLB        NVARCHAR(2)     NOT NULL             ,   --股东类型(004)必填
        GDZJLX      NVARCHAR(2)     NOT NULL             ,   --股东证件类型(005)必填
        GDZJHM      NVARCHAR(60)    NOT NULL             ,   --股东证件号码必填
        FDDBR       NVARCHAR(200)   NOT NULL             ,   --法定代表人必填
        GDJYFW      NVARCHAR(2000)  NOT NULL             ,   --股东业务或经营范围必填
        KGFS        NVARCHAR(1)     NOT NULL             ,   --控股方式(006)必填
        CGBL        DECIMAL(10,4)   NOT NULL    DEFAULT 0,   --持股比例必填
        GGXZ        NVARCHAR(1)                          ,   --机构性质(007)     若自然人股东，可不填
        QYZCLB      NVARCHAR(2)                          ,   --企业注册类别(008) 择性必填，除自然人/个体工商户/广义政府/特定目的载体外，需填写
        HYFL        NVARCHAR(1)                          ,   --行业分类(009)若自然人股东，可不填
        HYMX        NVARCHAR(6)                          ,   --行业明细(010)若自然人股东，可不填
        GSZCRQ      NVARCHAR(8)                          ,   --工商注册日期若自然人股东，可不填
        ZCZB        DECIMAL(20,2)                        ,   --注册资本  若自然人股东，可不填
        ZCDQ        NVARCHAR(6)                          ,   --注册地区(002)若自然人股东，可不填
        ZCDZ        NVARCHAR(200)                        ,   --注册地址若自然人股东，可不填
        SJBGDZ      NVARCHAR(200)                        ,   --实际办公地址若自然人股东，可不填
        SJKZRBS     NVARCHAR(1)                          ,   --实际控制人标识（003）若自然人股东，可不填
        SJKZRLX     NVARCHAR(1)                          ,   --实际控制人类型（004）"选择性填写若实际控制人标识选是，需填写"
        SJKZRMC     NVARCHAR(200)                        ,   --实际控制人名称"选择性填写若实际控制人标识选是，需填写"
        SJKZRZJLX   NVARCHAR(2)                          ,   --实际控制人证件类型（005）"选择性填写若实际控制人标识选是，需填写"
        SJKZRZJHM   NVARCHAR(60)                         ,   --实际控制人证件号码"选择性填写若实际控制人标识选是，需填写"
        GDZT        NVARCHAR(1)    NOT NULL              ,   --股东状态(011)必填
        GQSFZY      NVARCHAR(1)     NOT NULL             ,   --股权是否质押(003)必填
        GQZYBL      DECIMAL(10,4)                        ,   --股权质押比例选择性必填，若“股权是否质押”填报“1-是”，需填写
        GQSFDJ      NVARCHAR(1)                          ,   --股权是否冻结(003)必填
        DJBL        DECIMAL(10,4)                        ,   --股权冻结比例选择性必填，若“股权是否冻结”填报“1-是”，需填写
        CONSTRAINT PRI_TA02GDXXB  PRIMARY KEY(ID)
)
GO
--2.3.员工信息表
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TA03YGXXB')
    DROP TABLE TA03YGXXB
GO

CREATE TABLE TA03YGXXB
(   
        ID          INTEGER         NOT NULL    IDENTITY,
        YGGH        NVARCHAR(200)   NOT NULL            ,    --员工号必填
        YGXM        NVARCHAR(200)   NOT NULL            ,    --员工姓名必填
        YGZJLX      NVARCHAR(2)     NOT NULL            ,    --员工证件类型(012)必填
        YGJZHM      NVARCHAR(60)    NOT NULL            ,    --员工证件号码必填员工证件号码为隐私，信托机构变形。
        LXDH        NVARCHAR(30)                        ,    --联系电话非必填员工的电话号码为隐私，暂不取
        SSBM        NVARCHAR(200)   NOT NULL            ,    --所属部门必填
        BMFL        NVARCHAR(30)    NOT NULL            ,    --所属部门分类必填
        YGZW        NVARCHAR(200)   NOT NULL            ,    --员工职务必填
        SFGG        NVARCHAR(1)     NOT NULL            ,    --是否高管(003)必填
        YGBZ        NVARCHAR(1)     NOT NULL            ,    --员工编制(014)必填
        YGZT        NVARCHAR(1)     NOT NULL            ,    --员工状态*015)必填
        RZRQ        NVARCHAR(8)                         ,    --入职日期"条件下必填若员工状态为在职、停职、退休时，必填"
        LZRQ        NVARCHAR(8)                         ,    --离职日期"条件下必填若员工状态为离职、时，必填"
        BGDQ        NVARCHAR(6)     NOT NULL            ,    --办公地区(002)必填
        GWMC        NVARCHAR(30)    NOT NULL            ,    --岗位名称必填
        GWMS        NVARCHAR(200)   NOT NULL            ,    --岗位描述必填
        CONSTRAINT PRI_TA03YGXXB  PRIMARY KEY(ID)
)
GO

--2.4.关联方信息表
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TA04GLFXXB')
    DROP TABLE TA04GLFXXB
GO

CREATE TABLE TA04GLFXXB
(   
        ID          INTEGER         NOT NULL    IDENTITY,
        GLFBH       NVARCHAR(40)    NOT NULL            ,--  关联方编号 必填  
        GLFLX       NVARCHAR(1)     NOT NULL            ,--  关联方类型(004)  必填 
        GLFMC       NVARCHAR(200)   NOT NULL            ,-- 关联方名称  必填 
        GLFZJLX     NVARCHAR(2)     NOT NULL            ,-- 关联方证件类型 (005) 必填 
        GLFJYFW     NVARCHAR(200)   NOT NULL            ,-- 关联方业务或经营范围  必填 
        GLFZJHM     NVARCHAR(60)    NOT NULL            ,-- 关联方证件号码  必填 自然人关联方的身份证件号码为隐私，信托机构变形。
        HYFL        NVARCHAR(1)                         ,-- 行业分类 (009) 若关联方是自然人，可不填 
        HYMX        NVARCHAR(6)                         ,-- 行业明细 (010) 若关联方是自然人，可不填 
        JGXZ        NVARCHAR(1)     NOT NULL            ,-- 关联方性质 (007) 必填 
        QYZCLB      NVARCHAR(1)                         ,-- 企业注册类别 (008) 若关联方是自然人，可不填 
        GSZCRQ      NVARCHAR(8)                         ,-- 工商注册日期  若关联方是自然人，可不填 
        ZCZB        DECIMAL(20,2)                       ,-- 注册资本  若关联方是自然人，可不填 
        ZCDQ        NVARCHAR(6)                         ,-- 注册地区 (002) 若关联方是自然人，可不填 
        ZCDZ        NVARCHAR(200)                       ,-- 注册地址  若关联方是自然人，可不填 
        SJBGDZ      NVARCHAR(200)                       ,-- 实际办公地址  若自然人股东，可不填 
        CONSTRAINT PRI_TA04GLFXXB  PRIMARY KEY(ID)
)
GO
