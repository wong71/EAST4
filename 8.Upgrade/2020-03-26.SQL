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


--1.1.2.系统版本信息
IF NOT EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TEVERSIONDETAIL') BEGIN
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
END

--1.1.3. 机构信息历史表
IF  NOT EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'HA01JGXXB') BEGIN
    CREATE TABLE HA01JGXXB
    (   
            SERIAL_NO           INTEGER         NOT NULL    IDENTITY ,
            ID                  INTEGER         NOT NULL             ,
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
            SYNC_MONTH          INTEGER                              ,  --同步月份 / 变更日期
            SYNC_STATUS         INTEGER         NOT NULL    DEFAULT 0,  --数据同步情况：1-变化量 2-增加量

            CONSTRAINT PRI_HA01JGXXB  PRIMARY KEY(SERIAL_NO)
    )
    CREATE UNIQUE INDEX IDX_HA01JGXXB_1 ON HA01JGXXB(INSERT_MONTH,ID)
END

--1.1.4. 股东信息表

IF  NOT EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'HA02GDXXB') BEGIN
    CREATE TABLE HA02GDXXB
    (   
            SERIAL_NO       INTEGER         NOT NULL        IDENTITY ,  --记录号
            ID              INTEGER         NOT NULL                 ,  --TA02GDXXB.ID
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
            SYNC_STATUS     INTEGER         NOT NULL    DEFAULT 0    ,  --数据同步情况：1-变化量 2-增加量
            CONSTRAINT PRI_HA02GDXXB  PRIMARY KEY(SERIAL_NO)
    )
    CREATE UNIQUE INDEX IDX_HA02GDXXB_1 ON HA02GDXXB(SYNC_MONTH,ID)

END


--1.1.5. 股东受益所有人历史表
IF  NOT EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'HA02GDZZSYRXXB') BEGIN

    CREATE TABLE HA02GDZZSYRXXB
    (        
            
            SERIAL_NO       INTEGER         NOT NULL        IDENTITY ,
            ID              INTEGER         NOT NULL                 ,  --记录号
            GDID            INTEGER         NOT NULL                 ,  --股东ID TA02GDXXB.ID
            ZZSYRMC	        NVARCHAR(2000)  NOT NULL                 ,  --最终受益人名称
            ZZSYRZJLX       NVARCHAR(2000)  NOT NULL                 ,  --最终受益人证件类型
            ZZSYRZJHM       NVARCHAR(2000)  NOT NULL                 ,  --最终受益人证件号码
            DS_RECORD_NO    NVARCHAR(32)                             ,  --数据源.表.主键值
            INSERT_MONTH    INTEGER         NOT NULL                 ,  --首次同步日期（不可变）,insert 时取 TSYSTEM.CURRENT_MONTH
            SYNC_MONTH      INTEGER         NOT NULL                 ,  --同步月份
            SYNC_STATUS     INTEGER         NOT NULL    DEFAULT 0    ,  --数据同步情况：0-无变更 1-变化量 2-增加量
            CONSTRAINT PRI_HA02GDZZSYRXXB  PRIMARY KEY(SERIAL_NO)

    )
    CREATE UNIQUE INDEX IDX_HA02GDZZSYRXXB_1 ON HA02GDZZSYRXXB(SYNC_MONTH,ID)

END 

--1.1.6. 员工信息历史表
IF NOT EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'HA03YGXXB') BEGIN
    CREATE TABLE HA03YGXXB
    (   
            SERIAL_NO       INTEGER         NOT NULL        IDENTITY ,
            ID              INTEGER         NOT NULL                 ,  --记录号
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
            SYNC_MONTH      INTEGER                                  ,  --同步月份
            SYNC_STATUS     INTEGER         NOT NULL    DEFAULT 0    ,  --数据同步情况：1-变化量 2-增加量
            CONSTRAINT PRI_HA03YGXXB  PRIMARY KEY(SERIAL_NO)
    )
    CREATE UNIQUE INDEX IDX_HA03YGXXB_1 ON HA03YGXXB(HA03YGXXB,ID)
END

--1.1.6. 关联方信息表
IF NOT EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'HA04GLFXXB') BEGIN

    CREATE TABLE HA04GLFXXB
    (   
            SERIAL_NO       INTEGER         NOT NULL    IDENTITY ,  --记录号
            ID              INTEGER         NOT NULL             ,  --记录号
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
            SYNC_STATUS     INTEGER         NOT NULL    DEFAULT 0,  --数据同步情况：1-变化量 2-增加量
            CONSTRAINT PRI_HA04GLFXXB  PRIMARY KEY(SERIAL_NO)
    )
    CREATE INDEX IDX_HA04GLFXXB_1 ON HA04GLFXXB(SYNC_MONTH,ID)
END

GO


USE EAST4 
GO

--1.2. 新增字段
--1.2.1. TESYSTEMINFO
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('TESYSTEMINFO') and name = 'VERSION_NO') BEGIN
    ALTER TABLE TESYSTEMINFO ADD  VERSION_NO NVARCHAR(40)   --版本号
END
--1.2.2. TEREPORT.REPORT_FLAG
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('TEREPORT') and name = 'REPORT_FLAG') BEGIN

    ALTER TABLE TEREPORT ADD REPORT_FLAG INTEGER NOT NULL   DEFAULT 1   --申报标志：1-EAST申报表 2-其他表
END


--1.2.3. TA01JGXXB 机构信息表
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('TA01JGXXB') and name = 'CHECK_FLAG') BEGIN
    ALTER TABLE TA01JGXXB ADD  CHECK_FLAG INTEGER   NOT NULL DEFAULT 1   --审核标志
END
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('TA01JGXXB') and name = 'CHECK_TIME') BEGIN
    ALTER TABLE TA01JGXXB ADD  CHECK_TIME DATETIME                      --审核时间
END
--1.2.4. TA02GDXXB 股东信息表
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('TA02GDXXB') and name = 'CHECK_FLAG') BEGIN
    ALTER TABLE TA02GDXXB ADD  CHECK_FLAG INTEGER   NOT NULL DEFAULT 1   --审核标志
END
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('TA02GDXXB') and name = 'CHECK_TIME') BEGIN
    ALTER TABLE TA02GDXXB ADD  CHECK_TIME DATETIME                      --审核时间
END

--1.2.5. TA03YGXXB 员工信息表
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('TA03YGXXB') and name = 'CHECK_FLAG') BEGIN
    ALTER TABLE TA03YGXXB ADD  CHECK_FLAG INTEGER   NOT NULL DEFAULT 1   --审核标志
END
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('TA03YGXXB') and name = 'CHECK_TIME') BEGIN
    ALTER TABLE TA03YGXXB ADD  CHECK_TIME DATETIME                      --审核时间
END
--1.2.4. TA04GLFXXB 关联方信息表
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('TA04GLFXXB') and name = 'CHECK_FLAG') BEGIN
    ALTER TABLE TA04GLFXXB ADD  CHECK_FLAG INTEGER   NOT NULL DEFAULT 1   --审核标志
END
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('TA04GLFXXB') and name = 'CHECK_TIME') BEGIN
    ALTER TABLE TA04GLFXXB ADD  CHECK_TIME DATETIME                      --审核时间
END
GO


---2.数据处理
--2.1. 字典9003
IF NOT EXISTS(SELECT 1 FROM TEDICTPARAM WHERE TYPE_ID = 9003 AND TYPE_VALUE = 1) BEGIN
    INSERT INTO TEDICTPARAM(TYPE_ID,TYPE_NAME,TYPE_VALUE,TYPE_CONTENT)
        VALUES('9003',    '表申报标志' ,'1' , '申报表')

END
IF NOT EXISTS(SELECT 1 FROM TEDICTPARAM WHERE TYPE_ID = 9003 AND TYPE_VALUE = 1) BEGIN
    INSERT INTO TEDICTPARAM(TYPE_ID,TYPE_NAME,TYPE_VALUE,TYPE_CONTENT)
        VALUES('9003',    '表申报标志' ,'2' , '申报表扩展')

END
IF NOT EXISTS(SELECT 1 FROM TEDICTPARAM WHERE TYPE_ID = 9003 AND TYPE_VALUE = 9) BEGIN
    INSERT INTO TEDICTPARAM(TYPE_ID,TYPE_NAME,TYPE_VALUE,TYPE_CONTENT)
        VALUES('9003',    '表申报标志' ,'9' , '其他表')

END
GO


--3.写入版本信息
IF EXISTS(SELECT 1 FROM TEVERSIONDETAIL ) BEGIN
    INSERT INTO TEVERSIONDETAIL(VERSION_NO,RELEASE_DATE,SUMMARY)
        SELECT N'V 1.0.200326',
            20200326,
            N'1.增加部门表 TEDEPART; 2.添加系统版本信息表TEVERSIONDETAIL 3.TEREPORT 增加字段 REPORT_FLAG 以及 对应字典(9003) 4.增加审核功能'
END

UPDATE TESYSTEMINFO
    SET VERSION_NO = N'V 1.0.200326'