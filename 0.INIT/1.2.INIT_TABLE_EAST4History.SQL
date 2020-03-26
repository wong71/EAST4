USE EAST4History
GO

--# 2.��ϸ��
--## 2.1. ������Ϣ��
--```sql
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'HA01JGXXB')
    DROP TABLE HA01JGXXB
GO
CREATE TABLE HA01JGXXB
(   
        SERIAL_NO           INTEGER         NOT NULL    IDENTITY ,
        ID                  INTEGER         NOT NULL             ,
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
        SYNC_MONTH          INTEGER                              ,  --ͬ���·� / �������
        SYNC_STATUS         INTEGER         NOT NULL    DEFAULT 0,  --����ͬ�������1-�仯�� 2-������

        CONSTRAINT PRI_HA01JGXXB  PRIMARY KEY(SERIAL_NO)
)
CREATE UNIQUE INDEX IDX_HA01JGXXB_1 ON HA01JGXXB(SYNC_MONTH,ID)
--```
--## 2.2.�ɶ���Ϣ��
--```sql
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'HA02GDXXB')
    DROP TABLE HA02GDXXB
GO

CREATE TABLE HA02GDXXB
(   
        SERIAL_NO       INTEGER         NOT NULL        IDENTITY ,  --��¼��
        ID              INTEGER         NOT NULL                 ,  --TA02GDXXB.ID
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
        SYNC_STATUS     INTEGER         NOT NULL    DEFAULT 0    ,  --����ͬ�������1-�仯�� 2-������
        CONSTRAINT PRI_HA02GDXXB  PRIMARY KEY(SERIAL_NO)
)
GO
CREATE UNIQUE INDEX IDX_HA02GDXXB_1 ON HA02GDXXB(SYNC_MONTH,ID)
GO


-- **�ɶ�����������**
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'HA02GDZZSYRXXB')
    DROP TABLE HA02GDZZSYRXXB
GO

CREATE TABLE HA02GDZZSYRXXB
(        
        
        SERIAL_NO       INTEGER         NOT NULL        IDENTITY ,
        ID              INTEGER         NOT NULL                 ,  --TA02GDZZSYRXXB.ID
        GDID            INTEGER         NOT NULL                 ,  --�ɶ�ID TA02GDXXB.ID
        ZZSYRMC	        NVARCHAR(2000)  NOT NULL                 ,  --��������������
        ZZSYRZJLX       NVARCHAR(2000)  NOT NULL                 ,  --����������֤������
        ZZSYRZJHM       NVARCHAR(2000)  NOT NULL                 ,  --����������֤������
        DS_RECORD_NO    NVARCHAR(32)                             ,  --����Դ.��.����ֵ
        INSERT_MONTH    INTEGER         NOT NULL                 ,  --�״�ͬ�����ڣ����ɱ䣩,insert ʱȡ TSYSTEM.CURRENT_MONTH
        SYNC_MONTH      INTEGER         NOT NULL                 ,  --ͬ���·�
        SYNC_STATUS     INTEGER         NOT NULL    DEFAULT 0    ,  --����ͬ�������0-�ޱ�� 1-�仯�� 2-������
        CONSTRAINT PRI_HA02GDZZSYRXXB  PRIMARY KEY(SERIAL_NO)

)
GO

CREATE UNIQUE INDEX IDX_HA02GDZZSYRXXB_1 ON HA02GDZZSYRXXB(SYNC_MONTH,ID)
--```
--## 2.3.Ա����Ϣ��
--```sql
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'HA03YGXXB')
    DROP TABLE HA03YGXXB
GO
CREATE TABLE HA03YGXXB
(   
        SERIAL_NO       INTEGER         NOT NULL        IDENTITY ,
        ID              INTEGER         NOT NULL                 ,  --TA03YGXXB.ID
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
        SYNC_MONTH      INTEGER                                  ,  --ͬ���·�
        SYNC_STATUS     INTEGER         NOT NULL    DEFAULT 0    ,  --����ͬ�������1-�仯�� 2-������
        CONSTRAINT PRI_HA03YGXXB  PRIMARY KEY(SERIAL_NO)
)
GO
CREATE UNIQUE INDEX IDX_HA03YGXXB_1 ON HA03YGXXB(HA03YGXXB,ID)
GO
--```

--## 2.4.��������Ϣ��
--```sql
IF  EXISTS(SELECT 1 FROM sysobjects WHERE NAME = 'HA04GLFXXB')
    DROP TABLE HA04GLFXXB
GO

CREATE TABLE HA04GLFXXB
(   
        SERIAL_NO       INTEGER         NOT NULL    IDENTITY ,  --��¼��
        ID              INTEGER         NOT NULL             ,  --TA04GLFXXB.ID
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
        SYNC_STATUS     INTEGER         NOT NULL    DEFAULT 0,  --����ͬ�������1-�仯�� 2-������
        CONSTRAINT PRI_HA04GLFXXB  PRIMARY KEY(SERIAL_NO)
)
GO
CREATE INDEX IDX_HA04GLFXXB_1 ON HA04GLFXXB(SYNC_MONTH,ID)
GO
--```