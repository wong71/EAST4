USE EAST4
GO
--# 1.
--## 1.0. 系统表
--### 1.0.1. 系统信息表
--```sql
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TESYSTEMINFO')
    DROP TABLE TESYSTEMINFO
GO
CREATE TABLE TESYSTEMINFO
(
        SYSTEM_ID           INTEGER         NOT NULL    IDENTITY            ,   --自动编号做主键
        VERSION             NVARCHAR(64)    NOT NULL                        ,   --字典ID
        INIT_DATE           DATETIME        NOT NULL    DEFAULT GETDATE()   ,   --系统部部署时间
        CURRENT_MONTH       INTEGER         NOT NULL                        ,   --当前月份
        REP_1ST_START_DATE  INTEGER         NOT NULL                        ,   --首次报送日期区间从
        REP_1ST_END_DATE    INTEGER         NOT NULL                        ,   --首次报送日期区间到
        USER_ID             INTEGER                                         ,   --用户ID
        VERSION_NO          NVARCHAR(40)                                    ,   --版本说明
        CONSTRAINT PRI_TESYSTEMINFO PRIMARY KEY(SYSTEM_ID)
)
GO
--```
--### 1.0.2. 系统版本信息
--```sql
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TEVERSIONDETAIL')
    DROP TABLE TEVERSIONDETAIL
GO
CREATE TABLE TEVERSIONDETAIL
(
        SERIAL_NO           INTEGER         NOT NULL    IDENTITY            ,--记录号
        VERSION_NO          NVARCHAR(40)    NOT NULL                        ,--版本号
        RELEASE_DATE        INTEGER                                         ,--发布日期
        DEPLOY_DATE         DATETIME        NOT NULL    DEFAULT GETDATE()   ,--部署日期
        SUMMARY             NVARCHAR(MAX)                                   ,--版本说明
        CONSTRAINT PRI_TEVERSIONDETAIL PRIMARY KEY(SERIAL_NO)
)
CREATE UNIQUE INDEX IDX_TEVERSIONDETAIL1 ON TEVERSIONDETAIL(VERSION_NO)
CREATE UNIQUE INDEX IDX_TEVERSIONDETAIL2 ON TEVERSIONDETAIL(RELEASE_DATE)
GO
--```

--## 1.1. 字典表
-- ### 1.1.1 基本字典表
--```sql
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TEDICTPARAM')
    DROP TABLE TEDICTPARAM
GO
CREATE TABLE TEDICTPARAM
(
        SERIAL_NO       INTEGER         NOT NULL    IDENTITY ,   --自动编号做主键
        TYPE_ID         NVARCHAR(10)    NOT NULL             ,   --字典ID
        TYPE_NAME       NVARCHAR(255)   NOT NULL             ,   --字典说明
        TYPE_VALUE      NVARCHAR(100)   NOT NULL             ,   --字典值
        TYPE_CONTENT    NVARCHAR(100)   NOT NULL             ,   --字典值说明
        CONSTRAINT PRI_TEDICTPARAM PRIMARY KEY(SERIAL_NO)
)
CREATE UNIQUE INDEX IDX_TEDICTPARAM ON TEDICTPARAM(TYPE_ID,TYPE_VALUE)
GO
--```

-- ### 1.1.2 行政区域字典
--```sql
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TEDICTGB2206')
    DROP TABLE TEDICTGB2206
GO
CREATE TABLE TEDICTGB2206
(
        SERIAL_NO       INTEGER         NOT NULL    IDENTITY ,   --自动编号做主键
        REGION_CODE     NVARCHAR(10)    NOT NULL             ,
        REGION_NAME     NVARCHAR(200)   NOT NULL
        CONSTRAINT PRI_TEDICTGB2206 PRIMARY KEY(SERIAL_NO)
)
CREATE UNIQUE INDEX IDX_TEDICTGB2206_1 ON TEDICTGB2206(REGION_CODE)
GO
--```

-- ### 1.1.3 国民经济行业分类
--```sql
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TEDICTGB4754')
    DROP TABLE TEDICTGB4754
GO
CREATE TABLE TEDICTGB4754
(
        SERIAL_NO       INTEGER         NOT NULL    IDENTITY ,   --自动编号做主键
        INDUSTRY_CODE   NVARCHAR(10)    NOT NULL             ,
        INDUSTRY_NAME   NVARCHAR(200)   NOT NULL
        CONSTRAINT PRI_TEDICTGB4754 PRIMARY KEY(SERIAL_NO)
)
CREATE UNIQUE INDEX IDX_TEDICTGB4754_1 ON TEDICTGB4754(INDUSTRY_CODE)
GO
--```

-- ### 1.1.4 国别（GB/T 2659）
--```sql
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TEDICTGB2659')
    DROP TABLE TEDICTGB2659
GO
CREATE TABLE TEDICTGB2659
(
        SERIAL_NO       INTEGER         NOT NULL    IDENTITY ,   --自动编号做主键
        COUNTRY_CODE    NVARCHAR(10)    NOT NULL             ,
        COUNTRY_NAME    NVARCHAR(200)   NOT NULL             ,
        ORDER_ID        INTEGER         NOT NULL    DEFAULT 2,
        CONSTRAINT PRI_TEDICTGB2659 PRIMARY KEY(SERIAL_NO)
)
CREATE UNIQUE INDEX IDX_TEDICTGB2659_1 ON TEDICTGB2659(COUNTRY_CODE)
GO
--```

--## 1.2.系统开关参数配置表
--```sql
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TSYSCONTROL')
    DROP TABLE TSYSCONTROL
GO
CREATE TABLE TSYSCONTROL(
    SERIAL_NO   INTEGER          NOT NULL    IDENTITY   ,   --自动编号做主键
    FLAG_TYPE   NVARCHAR(30)     NOT NULL               ,   --开关名
    TYPE_NAME   NVARCHAR(30)     NOT NULL               ,   --开关中文名
    VALUE       INTEGER          NOT NULL   DEFAULT 0   ,   --值
    SUMMARY     NVARCHAR(200),                              --说明
    CONSTRAINT PRI_TSYSCONTROL PRIMARY KEY(FLAG_TYPE) )
GO
CREATE INDEX IDX_TSYSCONTROL1 ON TSYSCONTROL(FLAG_TYPE ASC,VALUE ASC)
GO
--```
--## 1.3. 申报表
--```sql
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
        DATA_SOURCE         NVARCHAR(128)               ,               --数据源系统名称
        TABLE_NAME          NVARCHAR(128)               ,               --数据源表
        SUMMARY             NVARCHAR(512)               ,               --数据源说明
        REPORT_FLAG         INTEGER             NOT NULL DEFAULT 1      --申报标志：1-EAST申报表 2-其他表
        CONSTRAINT PRI_TEREPORT PRIMARY KEY(REPORT_ID)
)

CREATE UNIQUE INDEX IDX_TEREPORT1 ON TEREPORT(REPORT_CODE)
GO
--```
--## 1.4. 申报表 字段表
--```sql
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
--```

--## 1.5. 申报表 字段表 验证
--```sql
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
--```

--## 1.6. 公司部门信息
--```sql

IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TEDEPART')
    DROP TABLE TEDEPART
GO
CREATE TABLE TEDEPART
(
        DEPART_ID           INTEGER         NOT NULL  IDENTITY,     --自动编号做主键
        PARENT_ID           INTEGER         NOT NULL,               --父级部门ID
        DEPART_CODE         NVARCHAR(40)    NOT NULL,               --部门代码
        DEPART_NAME         NVARCHAR(200)   NOT NULL,               --部门名称
        SHORT_NAME          NVARCHAR(200)   NOT NULL,               --部门简称
        CLASS               NVARCHAR(100)   NOT NULL,               --部门分类(2012)
        MANAGER             NVARCHAR(200)   NOT NULL,               --部门经理
        LEADER              NVARCHAR(200)   NOT NULL,               --分管领导
        CONSTRAINT PRI_TEDEPART PRIMARY KEY(DEPART_ID)
)
CREATE UNIQUE INDEX IDX_TEDEPART ON TEDEPART(DEPART_CODE)
GO

--



--# 2.详细表
--## 2.1. 机构信息表
--```sql
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TA01JGXXB')
    DROP TABLE TA01JGXXB
GO
CREATE TABLE TA01JGXXB
(   
        ID                  INTEGER         NOT NULL    IDENTITY ,  
        XTJGMC              NVARCHAR(200)   NOT NULL             ,  --信托机构名称      必填
        XTJGJRXKZDM         NVARCHAR(15)    NOT NULL             ,  --信托机构金融许可证代码(2001) | 填写银保监会颁发的金融许可证编码 | 必填
        TYSHXYDM            NVARCHAR(40)                         ,  --统一社会信用代码                      必填
        XTGSJYFW            NVARCHAR(2000)                       ,  --信托公司经营范围                      必填
        ZCZB                DECIMAL(20,2)                        ,  --注册资本                              必填
        ZCDQ                NVARCHAR(12)                         ,  --注册地区(1001)                        必填
        ZCDZ                NVARCHAR(200)                        ,  --注册地址                              必填
        SJBGDZ              NVARCHAR(200)                        ,  --实际办公地址                          必填
        FDDBR               NVARCHAR(200)                        ,  --法定代表人                            必填
        SJKZRBS             NVARCHAR(3)                          ,  --实际控制人标识(2002)                  必填
        SJKZRLX             NVARCHAR(30)                         ,  --实际控制人类型(2004)                  必填
        SJKZRMC             NVARCHAR(200)                        ,  --实际控制人名称                        选择性填写若实际控制人标识选是，需填写"
        SJKZRZJLX           NVARCHAR(40)                         ,  --实际控制人证件类型(2004)               选择性填写若实际控制人标识选是，需填写"
        SJKZRZJHM           NVARCHAR(60)                         ,  --实际控制人证件号码                    选择性填写若实际控制人标识选是，需填写" 自然人实际控制人的身份证件号码为隐私，信托机构变形。
        GSZCRQ              NVARCHAR(8)                          ,  --工商注册日期                          必填
        INSERT_MONTH        INTEGER                              ,  --首次同步日期（不可变）,insert 时取 TSYSTEM.CURRENT_MONTH
        SYNC_MONTH          INTEGER                              ,  --同步月份
        SYNC_STATUS         INTEGER         NOT NULL    DEFAULT 0,  --数据同步情况：0-无变更 1-变化量 2-增加量
        LOCK_FLAG           INTEGER         NOT NULL    DEFAULT 1,  --锁定标志：1-可更新/（读写） 2-锁定（只读）
        COMPLETE_FLAG       INTEGER         NOT NULL    DEFAULT 1,  --数据填报完成标志：1.未完整 2.自动检查完成 3.手动检查完成
        CHECK_FLAG          INTEGER         NOT NULL    DEFAULT 1,
        CHECK_TIME          DATETIME                             ,
        CONSTRAINT PRI_TA01JGXXB  PRIMARY KEY(ID)
)
--```
--## 2.2.股东信息表
--```sql
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TA02GDXXB')
    DROP TABLE TA02GDXXB
GO

CREATE TABLE TA02GDXXB
(   
        ID              INTEGER         NOT NULL        IDENTITY ,  --记录号
        GDLX            NVARCHAR(30)    NOT NULL                 ,  --股东类型(2003)必填
        GDMC            NVARCHAR(200)   NOT NULL                 ,  --股东名称必填
        GDZJLX          NVARCHAR(40)                             ,  --股东证件类型(2004)必填
        GDZJHM          NVARCHAR(60)                             ,  --股东证件号码必填
        FDDBR           NVARCHAR(200)                            ,  --法定代表人必填
        GDJYFW          NVARCHAR(2000)                           ,  --股东业务或经营范围必填
        KGFS            NVARCHAR(20)                             ,  --控股方式(2005)必填
        CGBL            DECIMAL(10,4)   NOT NULL    DEFAULT 0    ,  --持股比例必填
        JGXZ            NVARCHAR(60)                             ,  --机构性质(2006)     若自然人股东，可不填
        QYZCLB          NVARCHAR(30)                             ,  --企业注册类别(2007) 择性必填，除自然人/个体工商户/广义政府/特定目的载体外，需填写
        HYFL            NVARCHAR(20)                             ,  --行业分类(2008)若自然人股东，可不填
        HYMX            NVARCHAR(12)                             ,  --行业明细(1002)若自然人股东，可不填
        GSZCRQ          NVARCHAR(8)                              ,  --工商注册日期若自然人股东，可不填
        ZCZB            DECIMAL(20,2)                            ,  --注册资本  若自然人股东，可不填
        ZCGB            NVARCHAR(12)                             ,  --注册国（1001）
        ZCDQ            NVARCHAR(12)                             ,  --注册地区(1003)若自然人股东，可不填
        ZCDZ            NVARCHAR(200)                            ,  --注册地址若自然人股东，可不填
        SJBGDZ          NVARCHAR(200)                            ,  --实际办公地址若自然人股东，可不填
        SJKZRBS         NVARCHAR(3)                              ,  --实际控制人标识（003）若自然人股东，可不填
        SJKZRLX         NVARCHAR(30)                             ,  --实际控制人类型（004）"选择性填写若实际控制人标识选是，需填写"
        SJKZRMC         NVARCHAR(200)                            ,  --实际控制人名称"选择性填写若实际控制人标识选是，需填写"
        SJKZRZJLX       NVARCHAR(40)                             ,  --实际控制人证件类型（005）"选择性填写若实际控制人标识选是，需填写"
        SJKZRZJHM       NVARCHAR(60)                             ,  --实际控制人证件号码"选择性填写若实际控制人标识选是，需填写"
--      ZZSYRMC	        NVARCHAR(2000)                           ,  --
--      ZZSYRZJLX       NVARCHAR(2000)                           ,  --
--      ZZSYRZJHM       NVARCHAR(2000)                           ,  --
        GDZT            NVARCHAR(10)                             ,  --股东状态(2009)必填
        YZXDRBS         NVARCHAR(3)                              ,  --一致行动人标识(2002)
        YZXDRZB         NVARCHAR(8)                              ,  --一致行动人组别
        GQSFZY          NVARCHAR(3)                              ,  --股权是否质押(2002)       必填
        GQZYBL          DECIMAL(10,4)                            ,  --股权质押比例             选择性必填，若“股权是否质押”填报“1-是”，需填写
        GQSFDJ          NVARCHAR(3)                              ,  --股权是否冻结(2002)       必填
        GQDJBL          DECIMAL(10,4)                            ,  --股权冻结比例             选择性必填，若“股权是否冻结”填报“1-是”，需填写
        DS_RECORD_NO    NVARCHAR(32)                             ,  --数据源.表.主键值
        INSERT_MONTH    INTEGER                                  ,  --首次同步日期（不可变）,insert 时取 TSYSTEM.CURRENT_MONTH
        SYNC_MONTH      INTEGER                                  ,  --同步月份
        SYNC_STATUS     INTEGER         NOT NULL    DEFAULT 0    ,  --数据同步情况：0-无变更 1-变化量 2-增加量
        LOCK_FLAG       INTEGER         NOT NULL    DEFAULT 1    ,  --锁定标志：1-可更新/（读写） 2-锁定（只读）
        COMPLETE_FLAG   INTEGER         NOT NULL    DEFAULT 1    ,  --数据填报完成标志：1.未完整 2.自动检查完成 3.手动检查完成
        CHECK_FLAG      INTEGER         NOT NULL    DEFAULT 1    ,
        CHECK_TIME      DATETIME                                 ,
        CONSTRAINT PRI_TA02GDXXB  PRIMARY KEY(ID)
)
GO
CREATE UNIQUE INDEX IDX_TA02GDXXB_1 ON TA02GDXXB(GDMC,GDZJLX,GDZJHM)
GO


-- **股东受益所有人**
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TA02GDZZSYRXXB')
    DROP TABLE TA02GDZZSYRXXB
GO

CREATE TABLE TA02GDZZSYRXXB
(        
        ID              INTEGER         NOT NULL        IDENTITY ,  --记录号
        GDID            INTEGER         NOT NULL                 ,  --股东ID TA02GDXXB.ID
        ZZSYRMC	        NVARCHAR(2000)  NOT NULL                 ,  --最终受益人名称
        ZZSYRZJLX       NVARCHAR(2000)  NOT NULL                 ,  --最终受益人证件类型
        ZZSYRZJHM       NVARCHAR(2000)  NOT NULL                 ,  --最终受益人证件号码
        DS_RECORD_NO    NVARCHAR(32)                             ,  --数据源.表.主键值
        INSERT_MONTH    INTEGER         NOT NULL                 ,  --首次同步日期（不可变）,insert 时取 TSYSTEM.CURRENT_MONTH
        SYNC_MONTH      INTEGER         NOT NULL                 ,  --同步月份
        SYNC_STATUS     INTEGER         NOT NULL    DEFAULT 0    ,  --数据同步情况：0-无变更 1-变化量 2-增加量
        LOCK_FLAG       INTEGER         NOT NULL    DEFAULT 1    ,  --锁定标志：1-可更新/（读写） 2-锁定（只读）
        COMPLETE_FLAG   INTEGER         NOT NULL    DEFAULT 1    ,  --数据填报完成标志：1.未完整 2.自动检查完成 3.手动检查完成

)
GO

CREATE UNIQUE INDEX IDX_TA02GDZZSYRXXB_1 ON TA02GDZZSYRXXB(XTJGMC,GDZJLX,GDZJHM)
--```
--## 2.3.员工信息表
--```sql
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TA03YGXXB')
    DROP TABLE TA03YGXXB
GO
CREATE TABLE TA03YGXXB
(   
        ID              INTEGER         NOT NULL        IDENTITY ,  --记录号
        YGH             NVARCHAR(200)   NOT NULL                 ,  --员工号               必填
        YGXM            NVARCHAR(200)   NOT NULL                 ,  --员工姓名             必填
        YGZJLX          NVARCHAR(30)    NOT NULL                 ,  --员工证件类型(2010)   必填
        YGJZHM          NVARCHAR(60)    NOT NULL                 ,  --员工证件号码         必填员工证件号码为隐私，信托机构变形。
        ZZMM            NVARCHAR(20)                             ,  --政治面貌(2011)       必填
        LXDH            NVARCHAR(30)                             ,  --联系电话             非必填员工的电话号码为隐私，暂不取
        SSBM            NVARCHAR(200)                            ,  --所属部门             必填
        SSBMFL          NVARCHAR(100)                            ,  --所属部门分类(2012)   必填
        YGZW            NVARCHAR(200)                            ,  --员工职务             必填
        SFGG            NVARCHAR(3)                              ,  --是否高管(2002)       必填
        YGBZ            NVARCHAR(20)                             ,  --员工编制(2013)       必填
        YGZT            NVARCHAR(20)                             ,  --员工状态(2014)       必填
        RZRQ            NVARCHAR(8)                              ,  --入职日期             条件性必填,若员工状态为在职、停职、退休时，必填
        LZRQ            NVARCHAR(8)                              ,  --离职日期             条件性必填,若员工状态为离职时，必填
        BGGB            NVARCHAR(12)                             ,  --办公国别(1003)       必填
        BGDQ            NVARCHAR(12)                             ,  --办公地区(1001)       必填
        GWMC            NVARCHAR(30)                             ,  --岗位名称             必填
        GWMS            NVARCHAR(200)                            ,  --岗位描述             必填
        DS_RECORD_NO    NVARCHAR(32)                             ,  --数据源.表.主键值
        INSERT_MONTH    INTEGER                                  ,  --首次同步日期（不可变）,insert 时取 TSYSTEM.CURRENT_MONTH
        SYNC_MONTH      INTEGER                                  ,  --同步月份
        SYNC_STATUS     INTEGER         NOT NULL    DEFAULT 0    ,  --数据同步情况：0-无变更 1-变化量 2-增加量
        LOCK_FLAG       INTEGER         NOT NULL    DEFAULT 1    ,  --锁定标志：1-可更新/（读写） 2-锁定（只读）
        COMPLETE_FLAG   INTEGER         NOT NULL    DEFAULT 1    ,  --数据填报完成标志：1.未完整 2.自动检查完成 3.手动检查完成
        CHECK_FLAG      INTEGER         NOT NULL    DEFAULT 1    ,
        CHECK_TIME      DATETIME                                 ,
        CONSTRAINT PRI_TA03YGXXB  PRIMARY KEY(ID)
)
GO
CREATE UNIQUE INDEX IDX_TA03YGXXB_1 ON TA03YGXXB(YGH)
CREATE UNIQUE INDEX IDX_TA03YGXXB_2 ON TA03YGXXB(YGXM,YGZJLX,YGJZHM)
GO
--```

--## 2.4.关联方信息表
--```sql
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TA04GLFXXB')
    DROP TABLE TA04GLFXXB
GO

CREATE TABLE TA04GLFXXB
(   
        ID              INTEGER         NOT NULL    IDENTITY ,  --记录号
        GLFBH           NVARCHAR(40)    NOT NULL             ,  -- 关联方编号             必填  
        GLFLX           NVARCHAR(30)                         ,  -- 关联方类型(2003)       必填 
        GLLX            NVARCHAR(500)                        ,  -- 关联类型(2015)          必填
        GLFMC           NVARCHAR(200)   NOT NULL             ,  -- 关联方名称              必填 
        GLFZJLX         NVARCHAR(40)    NOT NULL             ,  -- 关联方证件类型 (2004)   必填 
        GLFZJHM         NVARCHAR(60)    NOT NULL             ,  -- 关联方证件号码  必填 自然人关联方的身份证件号码为隐私，信托机构变形。
        GLFJYFW         NVARCHAR(200)                        ,  -- 关联方业务或经营范围    必填 
        HYFL            NVARCHAR(20)                         ,  -- 行业分类 (2008)     条件性必填,若关联方是自然人，非必填
        HYMX            NVARCHAR(6)                          ,  -- 行业明细 (1002)     条件性必填,若关联方是自然人，非必填
        QYZCLB          NVARCHAR(30)                         ,  -- 企业注册类别 (2007) 条件性必填，若关联方类型选择非金融企业、金融机构（实体）、境外的，需填写 
        GSZCRQ          NVARCHAR(8)                          ,  -- 工商注册日期        条件性必填,若关联方是自然人，非必填
        ZCZB            DECIMAL(20,2)                        ,  -- 注册资本            条件性必填,若关联方是自然人，非必填
        ZCGB            NVARCHAR(12)                         ,  -- 注册国别 (1003)     条件性必填,若关联方是自然人，非必填
        ZCDQ            NVARCHAR(12)                         ,  -- 注册地区 (1001)     条件性必填,若关联方是自然人，非必填
        ZCDZ            NVARCHAR(200)                        ,  -- 注册地址            条件性必填,若关联方是自然人，非必填
        SJBGDZ          NVARCHAR(200)                        ,  -- 实际办公地址        条件性必填,若关联方是自然人，非必填
        DS_RECORD_NO    NVARCHAR(32)                         ,  --数据源.表.主键值
        INSERT_MONTH    INTEGER                              ,  --首次同步日期（不可变）,insert 时取 TSYSTEM.CURRENT_MONTH
        SYNC_MONTH      INTEGER                              ,  --同步月份
        SYNC_STATUS     INTEGER         NOT NULL    DEFAULT 0,  --数据同步情况：0-无变更 1-变化量 2-增加量
        LOCK_FLAG       INTEGER         NOT NULL    DEFAULT 1,  --锁定标志：1-可更新/（读写） 2-锁定（只读）
        COMPLETE_FLAG   INTEGER         NOT NULL    DEFAULT 1,  --数据填报完成标志：1.未完整 2.自动检查完成 3.手动检查完成
        CHECK_FLAG      INTEGER         NOT NULL    DEFAULT 1,
        CHECK_TIME      DATETIME                             ,
        CONSTRAINT PRI_TA04GLFXXB  PRIMARY KEY(ID)
)
GO
CREATE UNIQUE INDEX IDX_TA04GLFXXB_1 ON TA04GLFXXB(GLFBH)
CREATE        INDEX IDX_TA04GLFXXB_2 ON TA04GLFXXB(GLFBH,GLFMC,GLFZJLX,GLFZJHM)
GO
--```