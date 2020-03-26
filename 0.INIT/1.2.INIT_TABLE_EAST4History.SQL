USE EAST4History
GO

--# 2.详细表
--## 2.1. 机构信息表
--```sql
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'HA01JGXXB')
    DROP TABLE HA01JGXXB
GO
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
CREATE UNIQUE INDEX IDX_HA01JGXXB_1 ON HA01JGXXB(SYNC_MONTH,ID)
--```
--## 2.2.股东信息表
--```sql
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'HA02GDXXB')
    DROP TABLE HA02GDXXB
GO

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
GO
CREATE UNIQUE INDEX IDX_HA02GDXXB_1 ON HA02GDXXB(SYNC_MONTH,ID)
GO


-- **股东受益所有人**
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'HA02GDZZSYRXXB')
    DROP TABLE HA02GDZZSYRXXB
GO

CREATE TABLE HA02GDZZSYRXXB
(        
        
        SERIAL_NO       INTEGER         NOT NULL        IDENTITY ,
        ID              INTEGER         NOT NULL                 ,  --TA02GDZZSYRXXB.ID
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
GO

CREATE UNIQUE INDEX IDX_HA02GDZZSYRXXB_1 ON HA02GDZZSYRXXB(SYNC_MONTH,ID)
--```
--## 2.3.员工信息表
--```sql
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'HA03YGXXB')
    DROP TABLE HA03YGXXB
GO
CREATE TABLE HA03YGXXB
(   
        SERIAL_NO       INTEGER         NOT NULL        IDENTITY ,
        ID              INTEGER         NOT NULL                 ,  --TA03YGXXB.ID
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
GO
CREATE UNIQUE INDEX IDX_HA03YGXXB_1 ON HA03YGXXB(HA03YGXXB,ID)
GO
--```

--## 2.4.关联方信息表
--```sql
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'HA04GLFXXB')
    DROP TABLE HA04GLFXXB
GO

CREATE TABLE HA04GLFXXB
(   
        SERIAL_NO       INTEGER         NOT NULL    IDENTITY ,  --记录号
        ID              INTEGER         NOT NULL             ,  --TA04GLFXXB.ID
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
GO
CREATE INDEX IDX_HA04GLFXXB_1 ON HA04GLFXXB(SYNC_MONTH,ID)
GO
--```