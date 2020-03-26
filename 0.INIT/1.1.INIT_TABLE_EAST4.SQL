USE EAST4
GO
--# 1.
--## 1.0. ϵͳ��
--### 1.0.1. ϵͳ��Ϣ��
--```sql
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TESYSTEMINFO')
    DROP TABLE TESYSTEMINFO
GO
CREATE TABLE TESYSTEMINFO
(
        SYSTEM_ID           INTEGER         NOT NULL    IDENTITY            ,   --�Զ����������
        VERSION             NVARCHAR(64)    NOT NULL                        ,   --�ֵ�ID
        INIT_DATE           DATETIME        NOT NULL    DEFAULT GETDATE()   ,   --ϵͳ������ʱ��
        CURRENT_MONTH       INTEGER         NOT NULL                        ,   --��ǰ�·�
        REP_1ST_START_DATE  INTEGER         NOT NULL                        ,   --�״α������������
        REP_1ST_END_DATE    INTEGER         NOT NULL                        ,   --�״α����������䵽
        USER_ID             INTEGER                                         ,   --�û�ID
        VERSION_NO          NVARCHAR(40)                                    ,   --�汾˵��
        CONSTRAINT PRI_TESYSTEMINFO PRIMARY KEY(SYSTEM_ID)
)
GO
--```
--### 1.0.2. ϵͳ�汾��Ϣ
--```sql
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TEVERSIONDETAIL')
    DROP TABLE TEVERSIONDETAIL
GO
CREATE TABLE TEVERSIONDETAIL
(
        SERIAL_NO           INTEGER         NOT NULL    IDENTITY            ,--��¼��
        VERSION_NO          NVARCHAR(40)    NOT NULL                        ,--�汾��
        RELEASE_DATE        INTEGER                                         ,--��������
        DEPLOY_DATE         DATETIME        NOT NULL    DEFAULT GETDATE()   ,--��������
        SUMMARY             NVARCHAR(MAX)                                   ,--�汾˵��
        CONSTRAINT PRI_TEVERSIONDETAIL PRIMARY KEY(SERIAL_NO)
)
CREATE UNIQUE INDEX IDX_TEVERSIONDETAIL1 ON TEVERSIONDETAIL(VERSION_NO)
CREATE UNIQUE INDEX IDX_TEVERSIONDETAIL2 ON TEVERSIONDETAIL(RELEASE_DATE)
GO
--```

--## 1.1. �ֵ��
-- ### 1.1.1 �����ֵ��
--```sql
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TEDICTPARAM')
    DROP TABLE TEDICTPARAM
GO
CREATE TABLE TEDICTPARAM
(
        SERIAL_NO       INTEGER         NOT NULL    IDENTITY ,   --�Զ����������
        TYPE_ID         NVARCHAR(10)    NOT NULL             ,   --�ֵ�ID
        TYPE_NAME       NVARCHAR(255)   NOT NULL             ,   --�ֵ�˵��
        TYPE_VALUE      NVARCHAR(100)   NOT NULL             ,   --�ֵ�ֵ
        TYPE_CONTENT    NVARCHAR(100)   NOT NULL             ,   --�ֵ�ֵ˵��
        CONSTRAINT PRI_TEDICTPARAM PRIMARY KEY(SERIAL_NO)
)
CREATE UNIQUE INDEX IDX_TEDICTPARAM ON TEDICTPARAM(TYPE_ID,TYPE_VALUE)
GO
--```

-- ### 1.1.2 ���������ֵ�
--```sql
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TEDICTGB2206')
    DROP TABLE TEDICTGB2206
GO
CREATE TABLE TEDICTGB2206
(
        SERIAL_NO       INTEGER         NOT NULL    IDENTITY ,   --�Զ����������
        REGION_CODE     NVARCHAR(10)    NOT NULL             ,
        REGION_NAME     NVARCHAR(200)   NOT NULL
        CONSTRAINT PRI_TEDICTGB2206 PRIMARY KEY(SERIAL_NO)
)
CREATE UNIQUE INDEX IDX_TEDICTGB2206_1 ON TEDICTGB2206(REGION_CODE)
GO
--```

-- ### 1.1.3 ���񾭼���ҵ����
--```sql
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TEDICTGB4754')
    DROP TABLE TEDICTGB4754
GO
CREATE TABLE TEDICTGB4754
(
        SERIAL_NO       INTEGER         NOT NULL    IDENTITY ,   --�Զ����������
        INDUSTRY_CODE   NVARCHAR(10)    NOT NULL             ,
        INDUSTRY_NAME   NVARCHAR(200)   NOT NULL
        CONSTRAINT PRI_TEDICTGB4754 PRIMARY KEY(SERIAL_NO)
)
CREATE UNIQUE INDEX IDX_TEDICTGB4754_1 ON TEDICTGB4754(INDUSTRY_CODE)
GO
--```

-- ### 1.1.4 ����GB/T 2659��
--```sql
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TEDICTGB2659')
    DROP TABLE TEDICTGB2659
GO
CREATE TABLE TEDICTGB2659
(
        SERIAL_NO       INTEGER         NOT NULL    IDENTITY ,   --�Զ����������
        COUNTRY_CODE    NVARCHAR(10)    NOT NULL             ,
        COUNTRY_NAME    NVARCHAR(200)   NOT NULL             ,
        ORDER_ID        INTEGER         NOT NULL    DEFAULT 2,
        CONSTRAINT PRI_TEDICTGB2659 PRIMARY KEY(SERIAL_NO)
)
CREATE UNIQUE INDEX IDX_TEDICTGB2659_1 ON TEDICTGB2659(COUNTRY_CODE)
GO
--```

--## 1.2.ϵͳ���ز������ñ�
--```sql
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TSYSCONTROL')
    DROP TABLE TSYSCONTROL
GO
CREATE TABLE TSYSCONTROL(
    SERIAL_NO   INTEGER          NOT NULL    IDENTITY   ,   --�Զ����������
    FLAG_TYPE   NVARCHAR(30)     NOT NULL               ,   --������
    TYPE_NAME   NVARCHAR(30)     NOT NULL               ,   --����������
    VALUE       INTEGER          NOT NULL   DEFAULT 0   ,   --ֵ
    SUMMARY     NVARCHAR(200),                              --˵��
    CONSTRAINT PRI_TSYSCONTROL PRIMARY KEY(FLAG_TYPE) )
GO
CREATE INDEX IDX_TSYSCONTROL1 ON TSYSCONTROL(FLAG_TYPE ASC,VALUE ASC)
GO
--```
--## 1.3. �걨��
--```sql
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'TEREPORT')
    DROP TABLE TEREPORT
GO
CREATE TABLE TEREPORT
(
        REPORT_ID           INTEGER             NOT NULL,               --���������
        REPORT_CODE         NVARCHAR(6)         NOT NULL,               --����� 
        REPORT_NAME         NVARCHAR(60)        NOT NULL,               --������
        FILE_NAME           NVARCHAR(100)       NOT NULL,               --�����ļ���
        CATALOG_TYPE        NVARCHAR(100)       NOT NULL,               --����
        CATALOG_TYPE_NAME   NVARCHAR(100)       NOT NULL,               --����˵��
        DATA_SOURCE         NVARCHAR(128)               ,               --����Դϵͳ����
        TABLE_NAME          NVARCHAR(128)               ,               --����Դ��
        SUMMARY             NVARCHAR(512)               ,               --����Դ˵��
        REPORT_FLAG         INTEGER             NOT NULL DEFAULT 1      --�걨��־��1-EAST�걨�� 2-������
        CONSTRAINT PRI_TEREPORT PRIMARY KEY(REPORT_ID)
)

CREATE UNIQUE INDEX IDX_TEREPORT1 ON TEREPORT(REPORT_CODE)
GO
--```
--## 1.4. �걨�� �ֶα�
--```sql
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TEREPORTFIELD')
    DROP TABLE TEREPORTFIELD
GO
CREATE TABLE TEREPORTFIELD
(
        SERIAL_NO           INTEGER         NOT NULL  IDENTITY,     --�Զ����������
        REPORT_ID           INTEGER         NOT NULL,               --��
        FIELD_CODE          NVARCHAR(30)    NOT NULL,               --���������
        FIELD_NAME          NVARCHAR(100)   NOT NULL,               --����������
        DATA_TYPE           NVARCHAR(100)   NOT NULL,               --��������
        DATA_LENGTH         INTEGER         NOT NULL,               --���ݳ���
        DATA_PRECISION      INTEGER,                                --���� 
        DATA_METHOD         NVARCHAR(100)   NOT NULL,               --������Դ������input/selected��
        DATA_REF            NVARCHAR(100),                          --�����ֵ�
        SUMMARY             NVARCHAR(512),                          --��ע
        MODI_FLAG           INTEGER         NOT NULL    DEFAULT 2,  --EAST4�Ƿ��ܽ����޸ģ�1 �����޸ģ�2�����޸�
        VERIFY_FLAG         INTEGER         NOT NULL    DEFAULT 0,  --������֤��0-���� 1-��ͨ��֤ 2-������֤
        REF_FIELD_CODE      NVARCHAR(30),
        HINT                NVARCHAR(512),
        MESSAGE             NVARCHAR(512)
        CONSTRAINT PRI_TEREPORTFIELD PRIMARY KEY(SERIAL_NO)
)
CREATE UNIQUE INDEX IDX_TEREPORTFIELD ON TEREPORTFIELD(REPORT_ID,FIELD_CODE)
GO
--```

--## 1.5. �걨�� �ֶα� ��֤
--```sql
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TEREPORTFIELDVERIFY')
    DROP TABLE TEREPORTFIELDVERIFY
GO
CREATE TABLE TEREPORTFIELDVERIFY
(
        SERIAL_NO           INTEGER         NOT NULL  IDENTITY,     --�Զ����������
        REPORT_ID           INTEGER         NOT NULL,               --��
        FIELD_CODE          NVARCHAR(30)    NOT NULL,               --���������
        FIELD_NAME          NVARCHAR(100)   NOT NULL,               --����������
        REF_FIELD_CODE      NVARCHAR(30)    NOT NULL,               --�������������
        REF_FIELD_VALUE     NVARCHAR(512)   NOT NULL,               --����������ֵ
        CONSTRAINT PRI_TEREPORTFIELDVERIFY PRIMARY KEY(SERIAL_NO)
)
CREATE UNIQUE INDEX IDX_TEREPORTFIELDVERIFY ON TEREPORTFIELDVERIFY(REPORT_ID,FIELD_CODE,REF_FIELD_CODE,REF_FIELD_VALUE)
GO
--```

--## 1.6. ��˾������Ϣ
--```sql

IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TEDEPART')
    DROP TABLE TEDEPART
GO
CREATE TABLE TEDEPART
(
        DEPART_ID           INTEGER         NOT NULL  IDENTITY,     --�Զ����������
        PARENT_ID           INTEGER         NOT NULL,               --��������ID
        DEPART_CODE         NVARCHAR(40)    NOT NULL,               --���Ŵ���
        DEPART_NAME         NVARCHAR(200)   NOT NULL,               --��������
        SHORT_NAME          NVARCHAR(200)   NOT NULL,               --���ż��
        CLASS               NVARCHAR(100)   NOT NULL,               --���ŷ���(2012)
        MANAGER             NVARCHAR(200)   NOT NULL,               --���ž���
        LEADER              NVARCHAR(200)   NOT NULL,               --�ֹ��쵼
        CONSTRAINT PRI_TEDEPART PRIMARY KEY(DEPART_ID)
)
CREATE UNIQUE INDEX IDX_TEDEPART ON TEDEPART(DEPART_CODE)
GO

--



--# 2.��ϸ��
--## 2.1. ������Ϣ��
--```sql
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TA01JGXXB')
    DROP TABLE TA01JGXXB
GO
CREATE TABLE TA01JGXXB
(   
        ID                  INTEGER         NOT NULL    IDENTITY ,  
        XTJGMC              NVARCHAR(200)   NOT NULL             ,  --���л�������      ����
        XTJGJRXKZDM         NVARCHAR(15)    NOT NULL             ,  --���л�����������֤����(2001) | ��д�������䷢�Ľ�������֤���� | ����
        TYSHXYDM            NVARCHAR(40)                         ,  --ͳһ������ô���                      ����
        XTGSJYFW            NVARCHAR(2000)                       ,  --���й�˾��Ӫ��Χ                      ����
        ZCZB                DECIMAL(20,2)                        ,  --ע���ʱ�                              ����
        ZCDQ                NVARCHAR(12)                         ,  --ע�����(1001)                        ����
        ZCDZ                NVARCHAR(200)                        ,  --ע���ַ                              ����
        SJBGDZ              NVARCHAR(200)                        ,  --ʵ�ʰ칫��ַ                          ����
        FDDBR               NVARCHAR(200)                        ,  --����������                            ����
        SJKZRBS             NVARCHAR(3)                          ,  --ʵ�ʿ����˱�ʶ(2002)                  ����
        SJKZRLX             NVARCHAR(30)                         ,  --ʵ�ʿ���������(2004)                  ����
        SJKZRMC             NVARCHAR(200)                        ,  --ʵ�ʿ���������                        ѡ������д��ʵ�ʿ����˱�ʶѡ�ǣ�����д"
        SJKZRZJLX           NVARCHAR(40)                         ,  --ʵ�ʿ�����֤������(2004)               ѡ������д��ʵ�ʿ����˱�ʶѡ�ǣ�����д"
        SJKZRZJHM           NVARCHAR(60)                         ,  --ʵ�ʿ�����֤������                    ѡ������д��ʵ�ʿ����˱�ʶѡ�ǣ�����д" ��Ȼ��ʵ�ʿ����˵�����֤������Ϊ��˽�����л������Ρ�
        GSZCRQ              NVARCHAR(8)                          ,  --����ע������                          ����
        INSERT_MONTH        INTEGER                              ,  --�״�ͬ�����ڣ����ɱ䣩,insert ʱȡ TSYSTEM.CURRENT_MONTH
        SYNC_MONTH          INTEGER                              ,  --ͬ���·�
        SYNC_STATUS         INTEGER         NOT NULL    DEFAULT 0,  --����ͬ�������0-�ޱ�� 1-�仯�� 2-������
        LOCK_FLAG           INTEGER         NOT NULL    DEFAULT 1,  --������־��1-�ɸ���/����д�� 2-������ֻ����
        COMPLETE_FLAG       INTEGER         NOT NULL    DEFAULT 1,  --�������ɱ�־��1.δ���� 2.�Զ������� 3.�ֶ�������
        CHECK_FLAG          INTEGER         NOT NULL    DEFAULT 1,
        CHECK_TIME          DATETIME                             ,
        CONSTRAINT PRI_TA01JGXXB  PRIMARY KEY(ID)
)
--```
--## 2.2.�ɶ���Ϣ��
--```sql
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TA02GDXXB')
    DROP TABLE TA02GDXXB
GO

CREATE TABLE TA02GDXXB
(   
        ID              INTEGER         NOT NULL        IDENTITY ,  --��¼��
        GDLX            NVARCHAR(30)    NOT NULL                 ,  --�ɶ�����(2003)����
        GDMC            NVARCHAR(200)   NOT NULL                 ,  --�ɶ����Ʊ���
        GDZJLX          NVARCHAR(40)                             ,  --�ɶ�֤������(2004)����
        GDZJHM          NVARCHAR(60)                             ,  --�ɶ�֤���������
        FDDBR           NVARCHAR(200)                            ,  --���������˱���
        GDJYFW          NVARCHAR(2000)                           ,  --�ɶ�ҵ���Ӫ��Χ����
        KGFS            NVARCHAR(20)                             ,  --�عɷ�ʽ(2005)����
        CGBL            DECIMAL(10,4)   NOT NULL    DEFAULT 0    ,  --�ֹɱ�������
        JGXZ            NVARCHAR(60)                             ,  --��������(2006)     ����Ȼ�˹ɶ����ɲ���
        QYZCLB          NVARCHAR(30)                             ,  --��ҵע�����(2007) ���Ա������Ȼ��/���幤�̻�/��������/�ض�Ŀ�������⣬����д
        HYFL            NVARCHAR(20)                             ,  --��ҵ����(2008)����Ȼ�˹ɶ����ɲ���
        HYMX            NVARCHAR(12)                             ,  --��ҵ��ϸ(1002)����Ȼ�˹ɶ����ɲ���
        GSZCRQ          NVARCHAR(8)                              ,  --����ע����������Ȼ�˹ɶ����ɲ���
        ZCZB            DECIMAL(20,2)                            ,  --ע���ʱ�  ����Ȼ�˹ɶ����ɲ���
        ZCGB            NVARCHAR(12)                             ,  --ע�����1001��
        ZCDQ            NVARCHAR(12)                             ,  --ע�����(1003)����Ȼ�˹ɶ����ɲ���
        ZCDZ            NVARCHAR(200)                            ,  --ע���ַ����Ȼ�˹ɶ����ɲ���
        SJBGDZ          NVARCHAR(200)                            ,  --ʵ�ʰ칫��ַ����Ȼ�˹ɶ����ɲ���
        SJKZRBS         NVARCHAR(3)                              ,  --ʵ�ʿ����˱�ʶ��003������Ȼ�˹ɶ����ɲ���
        SJKZRLX         NVARCHAR(30)                             ,  --ʵ�ʿ��������ͣ�004��"ѡ������д��ʵ�ʿ����˱�ʶѡ�ǣ�����д"
        SJKZRMC         NVARCHAR(200)                            ,  --ʵ�ʿ���������"ѡ������д��ʵ�ʿ����˱�ʶѡ�ǣ�����д"
        SJKZRZJLX       NVARCHAR(40)                             ,  --ʵ�ʿ�����֤�����ͣ�005��"ѡ������д��ʵ�ʿ����˱�ʶѡ�ǣ�����д"
        SJKZRZJHM       NVARCHAR(60)                             ,  --ʵ�ʿ�����֤������"ѡ������д��ʵ�ʿ����˱�ʶѡ�ǣ�����д"
--      ZZSYRMC	        NVARCHAR(2000)                           ,  --
--      ZZSYRZJLX       NVARCHAR(2000)                           ,  --
--      ZZSYRZJHM       NVARCHAR(2000)                           ,  --
        GDZT            NVARCHAR(10)                             ,  --�ɶ�״̬(2009)����
        YZXDRBS         NVARCHAR(3)                              ,  --һ���ж��˱�ʶ(2002)
        YZXDRZB         NVARCHAR(8)                              ,  --һ���ж������
        GQSFZY          NVARCHAR(3)                              ,  --��Ȩ�Ƿ���Ѻ(2002)       ����
        GQZYBL          DECIMAL(10,4)                            ,  --��Ȩ��Ѻ����             ѡ���Ա��������Ȩ�Ƿ���Ѻ�����1-�ǡ�������д
        GQSFDJ          NVARCHAR(3)                              ,  --��Ȩ�Ƿ񶳽�(2002)       ����
        GQDJBL          DECIMAL(10,4)                            ,  --��Ȩ�������             ѡ���Ա��������Ȩ�Ƿ񶳽ᡱ���1-�ǡ�������д
        DS_RECORD_NO    NVARCHAR(32)                             ,  --����Դ.��.����ֵ
        INSERT_MONTH    INTEGER                                  ,  --�״�ͬ�����ڣ����ɱ䣩,insert ʱȡ TSYSTEM.CURRENT_MONTH
        SYNC_MONTH      INTEGER                                  ,  --ͬ���·�
        SYNC_STATUS     INTEGER         NOT NULL    DEFAULT 0    ,  --����ͬ�������0-�ޱ�� 1-�仯�� 2-������
        LOCK_FLAG       INTEGER         NOT NULL    DEFAULT 1    ,  --������־��1-�ɸ���/����д�� 2-������ֻ����
        COMPLETE_FLAG   INTEGER         NOT NULL    DEFAULT 1    ,  --�������ɱ�־��1.δ���� 2.�Զ������� 3.�ֶ�������
        CHECK_FLAG      INTEGER         NOT NULL    DEFAULT 1    ,
        CHECK_TIME      DATETIME                                 ,
        CONSTRAINT PRI_TA02GDXXB  PRIMARY KEY(ID)
)
GO
CREATE UNIQUE INDEX IDX_TA02GDXXB_1 ON TA02GDXXB(GDMC,GDZJLX,GDZJHM)
GO


-- **�ɶ�����������**
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TA02GDZZSYRXXB')
    DROP TABLE TA02GDZZSYRXXB
GO

CREATE TABLE TA02GDZZSYRXXB
(        
        ID              INTEGER         NOT NULL        IDENTITY ,  --��¼��
        GDID            INTEGER         NOT NULL                 ,  --�ɶ�ID TA02GDXXB.ID
        ZZSYRMC	        NVARCHAR(2000)  NOT NULL                 ,  --��������������
        ZZSYRZJLX       NVARCHAR(2000)  NOT NULL                 ,  --����������֤������
        ZZSYRZJHM       NVARCHAR(2000)  NOT NULL                 ,  --����������֤������
        DS_RECORD_NO    NVARCHAR(32)                             ,  --����Դ.��.����ֵ
        INSERT_MONTH    INTEGER         NOT NULL                 ,  --�״�ͬ�����ڣ����ɱ䣩,insert ʱȡ TSYSTEM.CURRENT_MONTH
        SYNC_MONTH      INTEGER         NOT NULL                 ,  --ͬ���·�
        SYNC_STATUS     INTEGER         NOT NULL    DEFAULT 0    ,  --����ͬ�������0-�ޱ�� 1-�仯�� 2-������
        LOCK_FLAG       INTEGER         NOT NULL    DEFAULT 1    ,  --������־��1-�ɸ���/����д�� 2-������ֻ����
        COMPLETE_FLAG   INTEGER         NOT NULL    DEFAULT 1    ,  --�������ɱ�־��1.δ���� 2.�Զ������� 3.�ֶ�������

)
GO

CREATE UNIQUE INDEX IDX_TA02GDZZSYRXXB_1 ON TA02GDZZSYRXXB(XTJGMC,GDZJLX,GDZJHM)
--```
--## 2.3.Ա����Ϣ��
--```sql
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TA03YGXXB')
    DROP TABLE TA03YGXXB
GO
CREATE TABLE TA03YGXXB
(   
        ID              INTEGER         NOT NULL        IDENTITY ,  --��¼��
        YGH             NVARCHAR(200)   NOT NULL                 ,  --Ա����               ����
        YGXM            NVARCHAR(200)   NOT NULL                 ,  --Ա������             ����
        YGZJLX          NVARCHAR(30)    NOT NULL                 ,  --Ա��֤������(2010)   ����
        YGJZHM          NVARCHAR(60)    NOT NULL                 ,  --Ա��֤������         ����Ա��֤������Ϊ��˽�����л������Ρ�
        ZZMM            NVARCHAR(20)                             ,  --������ò(2011)       ����
        LXDH            NVARCHAR(30)                             ,  --��ϵ�绰             �Ǳ���Ա���ĵ绰����Ϊ��˽���ݲ�ȡ
        SSBM            NVARCHAR(200)                            ,  --��������             ����
        SSBMFL          NVARCHAR(100)                            ,  --�������ŷ���(2012)   ����
        YGZW            NVARCHAR(200)                            ,  --Ա��ְ��             ����
        SFGG            NVARCHAR(3)                              ,  --�Ƿ�߹�(2002)       ����
        YGBZ            NVARCHAR(20)                             ,  --Ա������(2013)       ����
        YGZT            NVARCHAR(20)                             ,  --Ա��״̬(2014)       ����
        RZRQ            NVARCHAR(8)                              ,  --��ְ����             �����Ա���,��Ա��״̬Ϊ��ְ��ְͣ������ʱ������
        LZRQ            NVARCHAR(8)                              ,  --��ְ����             �����Ա���,��Ա��״̬Ϊ��ְʱ������
        BGGB            NVARCHAR(12)                             ,  --�칫����(1003)       ����
        BGDQ            NVARCHAR(12)                             ,  --�칫����(1001)       ����
        GWMC            NVARCHAR(30)                             ,  --��λ����             ����
        GWMS            NVARCHAR(200)                            ,  --��λ����             ����
        DS_RECORD_NO    NVARCHAR(32)                             ,  --����Դ.��.����ֵ
        INSERT_MONTH    INTEGER                                  ,  --�״�ͬ�����ڣ����ɱ䣩,insert ʱȡ TSYSTEM.CURRENT_MONTH
        SYNC_MONTH      INTEGER                                  ,  --ͬ���·�
        SYNC_STATUS     INTEGER         NOT NULL    DEFAULT 0    ,  --����ͬ�������0-�ޱ�� 1-�仯�� 2-������
        LOCK_FLAG       INTEGER         NOT NULL    DEFAULT 1    ,  --������־��1-�ɸ���/����д�� 2-������ֻ����
        COMPLETE_FLAG   INTEGER         NOT NULL    DEFAULT 1    ,  --�������ɱ�־��1.δ���� 2.�Զ������� 3.�ֶ�������
        CHECK_FLAG      INTEGER         NOT NULL    DEFAULT 1    ,
        CHECK_TIME      DATETIME                                 ,
        CONSTRAINT PRI_TA03YGXXB  PRIMARY KEY(ID)
)
GO
CREATE UNIQUE INDEX IDX_TA03YGXXB_1 ON TA03YGXXB(YGH)
CREATE UNIQUE INDEX IDX_TA03YGXXB_2 ON TA03YGXXB(YGXM,YGZJLX,YGJZHM)
GO
--```

--## 2.4.��������Ϣ��
--```sql
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'TA04GLFXXB')
    DROP TABLE TA04GLFXXB
GO

CREATE TABLE TA04GLFXXB
(   
        ID              INTEGER         NOT NULL    IDENTITY ,  --��¼��
        GLFBH           NVARCHAR(40)    NOT NULL             ,  -- ���������             ����  
        GLFLX           NVARCHAR(30)                         ,  -- ����������(2003)       ���� 
        GLLX            NVARCHAR(500)                        ,  -- ��������(2015)          ����
        GLFMC           NVARCHAR(200)   NOT NULL             ,  -- ����������              ���� 
        GLFZJLX         NVARCHAR(40)    NOT NULL             ,  -- ������֤������ (2004)   ���� 
        GLFZJHM         NVARCHAR(60)    NOT NULL             ,  -- ������֤������  ���� ��Ȼ�˹�����������֤������Ϊ��˽�����л������Ρ�
        GLFJYFW         NVARCHAR(200)                        ,  -- ������ҵ���Ӫ��Χ    ���� 
        HYFL            NVARCHAR(20)                         ,  -- ��ҵ���� (2008)     �����Ա���,������������Ȼ�ˣ��Ǳ���
        HYMX            NVARCHAR(6)                          ,  -- ��ҵ��ϸ (1002)     �����Ա���,������������Ȼ�ˣ��Ǳ���
        QYZCLB          NVARCHAR(30)                         ,  -- ��ҵע����� (2007) �����Ա��������������ѡ��ǽ�����ҵ�����ڻ�����ʵ�壩������ģ�����д 
        GSZCRQ          NVARCHAR(8)                          ,  -- ����ע������        �����Ա���,������������Ȼ�ˣ��Ǳ���
        ZCZB            DECIMAL(20,2)                        ,  -- ע���ʱ�            �����Ա���,������������Ȼ�ˣ��Ǳ���
        ZCGB            NVARCHAR(12)                         ,  -- ע����� (1003)     �����Ա���,������������Ȼ�ˣ��Ǳ���
        ZCDQ            NVARCHAR(12)                         ,  -- ע����� (1001)     �����Ա���,������������Ȼ�ˣ��Ǳ���
        ZCDZ            NVARCHAR(200)                        ,  -- ע���ַ            �����Ա���,������������Ȼ�ˣ��Ǳ���
        SJBGDZ          NVARCHAR(200)                        ,  -- ʵ�ʰ칫��ַ        �����Ա���,������������Ȼ�ˣ��Ǳ���
        DS_RECORD_NO    NVARCHAR(32)                         ,  --����Դ.��.����ֵ
        INSERT_MONTH    INTEGER                              ,  --�״�ͬ�����ڣ����ɱ䣩,insert ʱȡ TSYSTEM.CURRENT_MONTH
        SYNC_MONTH      INTEGER                              ,  --ͬ���·�
        SYNC_STATUS     INTEGER         NOT NULL    DEFAULT 0,  --����ͬ�������0-�ޱ�� 1-�仯�� 2-������
        LOCK_FLAG       INTEGER         NOT NULL    DEFAULT 1,  --������־��1-�ɸ���/����д�� 2-������ֻ����
        COMPLETE_FLAG   INTEGER         NOT NULL    DEFAULT 1,  --�������ɱ�־��1.δ���� 2.�Զ������� 3.�ֶ�������
        CHECK_FLAG      INTEGER         NOT NULL    DEFAULT 1,
        CHECK_TIME      DATETIME                             ,
        CONSTRAINT PRI_TA04GLFXXB  PRIMARY KEY(ID)
)
GO
CREATE UNIQUE INDEX IDX_TA04GLFXXB_1 ON TA04GLFXXB(GLFBH)
CREATE        INDEX IDX_TA04GLFXXB_2 ON TA04GLFXXB(GLFBH,GLFMC,GLFZJLX,GLFZJHM)
GO
--```