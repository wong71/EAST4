USE EAST4

    --# 1. 系统配置表 TESYSTEMINFO
    --```sql
    IF NOT EXISTS(SELECT 1 FROM TESYSTEMINFO)
        INSERT INTO TESYSTEMINFO(VERSION,CURRENT_MONTH,REP_1ST_START_DATE,REP_1ST_END_DATE)
            VALUES ('V1.0',202003,20200101,20200331)
    
    --```

    --#2.申报表清单 TEREPORT
    --```sql
    TRUNCATE TABLE TEREPORT;
    INSERT TEREPORT (REPORT_ID,REPORT_FLAG, REPORT_CODE, REPORT_NAME,FILE_NAME, CATALOG_TYPE, CATALOG_TYPE_NAME, DATA_SOURCE, TABLE_NAME,SUMMARY) 
        --信托公司管理信息 
                  SELECT 01 ,   1  ,N'A01'  ,N'机构信息表'                   ,N'JGXXB'            ,N'A'   ,N'管理信息'          ,'' ,'TA01JGXXB'       , N'本表收集信托公司的基本信息，主要包括：机构代码、机构名称、统一社会信用代码、成立时间、注册资本、注册地区、注册地址、经营范围等'
        UNION ALL SELECT 02 ,   1  ,N'A02'  ,N'股东信息表'                   ,N'GDXXB'            ,N'A'   ,N'管理信息'          ,'' ,'TA02GDXXB'       , N'本表收集信托公司的股东及其出资信息，主要包括：股东名称、股东类型、证件类别、证件号码、持股方式、持股比例等；报送规则分上市公司及非上市公司，对于非上市公司，报送全部股东信息。对于上市公司，报送前10大股东信息以及涉及一致行动人的股东'
        UNION ALL SELECT 201,   2  ,N'A0201',N'股东受益所有人'               ,N'GDSYSYRB'         ,N'A'   ,N'管理信息'          ,''  ,'TA02GDZZSYRXXB' , N''
        UNION ALL SELECT 03 ,   1  ,N'A03'  ,N'员工信息表'                   ,N'YGXXB'            ,N'A'   ,N'管理信息'          ,'' ,'TA03YGXXB'       , N'本表收集信托公司的所有员工信息，包含正式员工、合同员工、劳务派遣员工及其它非正式员工，包括在岗和离职员工，高管、董事等人员也应包含在内。对于无法从核心系统中获取的员工信息，应从人力资源系统进行补充。初始报送时，无须报送已离职员工信息，未来变化量报送时，若有员工离职，需要报送'
        UNION ALL SELECT 04 ,   1  ,N'A04'  ,N'关联方信息表'                 ,N'GLFXXB'           ,N'A'   ,N'管理信息'          ,'' ,'TA04GLFXXB'      , N'本表收集信托公司涉及的所有关联方信息，包括但不限于信托公司下属资管公司、投资子公司、财富公司、有关联的公司、交易对手公司、交易发生时涉及的公司、自然人等'
        --信托产品公共信息, ''  
        UNION ALL SELECT 05 ,   1  ,N'B01'  ,N'信托客户（住户）'             ,N'XTKHZH'           ,N'B'   ,N'信托产品公共信息'  ,'' ,''                , N'本表收集所有信托客户（住户）的相关要素信息，包括委托人和受益人'
        UNION ALL SELECT 06 ,   1  ,N'B02'  ,N'信托客户（机构）'             ,N'XTKHJG'           ,N'B'   ,N'信托产品公共信息'  ,'' ,''                , N'本表收集所有信托客户（机构）的相关要素信息，包括委托人和受益人'
        UNION ALL SELECT 07 ,   1  ,N'B03'  ,N'信托客户（金融产品）'         ,N'XTKHJRCP'         ,N'B'   ,N'信托产品公共信息'  ,'' ,''                , N'本表收集所有信托客户（金融产品）的相关要素信息，包括委托人和受益人'
        UNION ALL SELECT 08 ,   1  ,N'B04'  ,N'交易对手（住户）'             ,N'JYDSZH'           ,N'B'   ,N'信托产品公共信息'  ,'' ,''                , N'本表收集信托业务涉及的所有住户对手方相关要素信息，包括对手方和担保方等，投资于场内交易的标准化产品，可以豁免填报'
        UNION ALL SELECT 09 ,   1  ,N'B05'  ,N'交易对手（机构）'             ,N'JYDSJG'           ,N'B'   ,N'信托产品公共信息'  ,'' ,''                , N'本表收集信托业务涉及的所有机构对手方相关要素信息，包括对手方和担保方等，投资于场内交易的标准化产品，可以豁免填报'
        UNION ALL SELECT 10 ,   1  ,N'B06'  ,N'交易对手（金融产品）'         ,N'JYDSJRCP'         ,N'B'   ,N'信托产品公共信息'  ,'' ,''                , N'本表收集信托业务涉及的所有金融产品对手方相关要素信息，投资于场内交易的标准化产品，可以豁免填报'
        UNION ALL SELECT 11 ,   1  ,N'B07'  ,N'信托交易对手股东信息'         ,N'XTJYDSGDXX'       ,N'B'   ,N'信托产品公共信息'  ,'' ,''                , N'本表收集所有机构对手方的股东信息。报送规则分上市公司及非上市公司，对于非上市公司，报送全部股东信息。对于上市公司，报送前10大股东信息。且仅限于交易对手为机构。如果交易对手是住户或金融产品，无需填写此表'
        --信托产品信息, ''  
        UNION ALL SELECT 12 ,   1  ,N'C01'  ,N'信托产品基本信息'             ,N'XTCPJBXX'         ,N'C'   ,N'信托产品'          ,'' ,''                , N'本表收集信托公司已成立的信托产品基本要素信息'
        UNION ALL SELECT 13 ,   1  ,N'C02'  ,N'信托产品账户信息'             ,N'XTCPZHXX'         ,N'C'   ,N'信托产品'          ,'' ,''                , N'本表收集信托产品的各类账户及余额信息'
        UNION ALL SELECT 14 ,   1  ,N'C03'  ,N'信托投资顾问合同信息'         ,N'XTTZGWHTXX'       ,N'C'   ,N'信托产品'          ,'' ,''                , N'本表收集信托项目相关的投资顾问合同信息'
        UNION ALL SELECT 15 ,   1  ,N'C04'  ,N'信托三方机构合作信息'         ,N'XTSFJGHZXX'       ,N'C'   ,N'信托产品'          ,'' ,''                , N'本表收集所有信托合作机构的相关要素信息，包括但不限于证券期货投资咨询人、公募基金管理人、私募基金管理人、资产管理资格人、银行、信托、保险、评级机构、助贷机构等合作机构信息'
        UNION ALL SELECT 16 ,   1  ,N'C05'  ,N'信托产品受益所有人信息'       ,N'XTCPSYSYRXX'       ,N'C'   ,N'信托产品'         ,'' ,''                , N'本表收集信托产品除自然人委托人、自然人受益人外的全部受益所有人的相关要素信息。存在关联多个的非自然人信托客户而构成受益所有人关系的，需要多次填写此表。'
        --信托募集信息, ''  
        UNION ALL SELECT 17 ,   1  ,N'D01' ,N'信托产品受益权信息'           ,N'XTCPSYQXX'        ,N'D'   ,N'信托募集'          ,'' ,''                 , N'本表收集信托项目下的各受益权类别信息'
        UNION ALL SELECT 18 ,   1  ,N'D02' ,N'信托合同信息'                 ,N'XTHTXX'           ,N'D'   ,N'信托募集'          ,'' ,''                 , N'本表收集委托人交付信托资产（资金或财产）给予信托公司所签订合同及其相关信息'
        UNION ALL SELECT 19 ,   1  ,N'D03' ,N'信托受益凭据信息'             ,N'XTSYPJXX'         ,N'D'   ,N'信托募集'          ,'' ,''                 , N'本表收集信托项目涉及的委托合同的受益权凭据明细及其相关信息'
        UNION ALL SELECT 20 ,   1  ,N'D04' ,N'信托受益权转让信息'           ,N'XTSYQZRXX'        ,N'D'   ,N'信托募集'          ,'' ,''                 , N'本表收集信托项目涉及的受益权转让登记协议的相关要素信息'
        UNION ALL SELECT 21 ,   1  ,N'D05' ,N'信托募集分配流水'             ,N'XTMJFPLS'         ,N'D'   ,N'信托募集'          ,'' ,''                 , N'本表收集信托项目的委托合同和受益权凭据的信托交易（TA申购、兑付/赎回、受益权转让等）流水信息。受益权转让资金流若不通过信托产品账户或无资金往来的，可不填报此表'
        --信托运用信息, ''  
        UNION ALL SELECT 22 ,   1  ,N'E01' ,N'信托运用信息'                 ,N'XTYYXX'           ,N'E'   ,N'信托运用'          ,'' ,''                 , N'本表收集信托财产（包括资金和财产权）运用的相关要素信息，若财产运用涉及到信托运用合同的，需填写运用合同具体信息。若一个信托产品涉及多笔运用时，应当多次填报本表'
        UNION ALL SELECT 23 ,   1  ,N'E02' ,N'信托运用交易流水信息'         ,N'XTYYJYLSXX'       ,N'E'   ,N'信托运用'          ,'' ,''                 , N'本表收集信托项目的所有投资交易流水信息。暂不采集具体证券交易类流水'
        UNION ALL SELECT 24 ,   1  ,N'E03' ,N'信托担保合同表'               ,N'XTDBHTB'          ,N'E'   ,N'信托运用'          ,'' ,''                 , N'本表收集信托项目涉及担保合同的相关信息'
        UNION ALL SELECT 25 ,   1  ,N'E04' ,N'信托抵质押物信息'             ,N'XTDZYWXX'         ,N'E'   ,N'信托运用'          ,'' ,''                 , N'"本表收集信托项目担保合同下的各抵/质押物信息明细。若在信托担保合同表中选择抵押或质押，需要填写此表；如果一个抵质押物对应同一信托公司发行的多个信托产品的，需要多次填写本表"'
        UNION ALL SELECT 26 ,   1  ,N'E05' ,N'信托担保关系表'               ,N'XTDBGXB'          ,N'E'   ,N'信托运用'          ,'' ,''                 , N'本表收集信托产品担保合同和被担保合同之间的关系，为多对多关系表，一个担保合同担保多个合同的，需要填写多笔，多个担保合同担保一个合同的，需要填写多笔记录。'
        UNION ALL SELECT 27 ,   1  ,N'E06' ,N'信托抵质押物关系表'           ,N'XTDZYWGXB'        ,N'E'   ,N'信托运用'          ,'' ,''                 , N'本表收集信托项目担保合同和被担保合同之间的关系，为多对多关系表。一个担保合同担保多个被担保合同的，需要填写多笔；多个担保合同担保一个被担保合同的，需要填写多笔记录'
        UNION ALL SELECT 28 ,   1  ,N'E07' ,N'信托回款情况表'               ,N'XTHKQKB'          ,N'E'   ,N'信托运用'          ,'' ,''                 , N'本表收集信托项目的回款情况及评估日期的预计还款来源，信托项目涉及多个运用合同的，须填写多笔记录'
        UNION ALL SELECT 29 ,   1  ,N'E08' ,N'信托产品存续情况表'           ,N'XTCPCXQKB'        ,N'E'   ,N'信托运用'          ,'' ,''                 , N'本表收集信托产品的存续情况，一个信托产品每期仅需报送一张本表'
        UNION ALL SELECT 30 ,   1  ,N'E09' ,N'信托产品清算信息表'           ,N'XTCPQSXXB'        ,N'E'   ,N'信托运用'          ,'' ,''                 , N'本表收集信托项目清算时的相关信息，在报告期清算结束的项目均应填报'
        --信托运用补充信息, ''  
        UNION ALL SELECT 31 ,   1  ,N'F01' ,N'信托房地产产品信息'           ,N'XTFDCCPXX'        ,N'F'   ,N'信托运用补充信息'  ,'' ,''                 , N'本表收集信托产品涉及的房地产产品的相关要素信息'
        UNION ALL SELECT 32 ,   1  ,N'F02' ,N'基础建设产品信息'             ,N'JCJSCPXX'         ,N'F'   ,N'信托运用补充信息'  ,'' ,''                 , N'本表本表填写基础建设产品信息。'
        UNION ALL SELECT 33 ,   1  ,N'F03' ,N'消费金融信托管理信息表'       ,N'XFJRXTGLXXB'      ,N'F'   ,N'信托运用补充信息'  ,'' ,''                 , N'信托产品为消费金融信托的，填写此表。消费金融信托是指将信托财产用于向住户发放消费贷款的信托产品。'
        UNION ALL SELECT 34 ,   1  ,N'F04' ,N'消费金融信托借款人信息明细表' ,N'XFJRXTJKRXXMXB'   ,N'F'   ,N'信托运用补充信息'  ,'' ,''                 , N'信托产品为消费金融信托的，填写此表。消费金融信托是指将信托财产用于向住户发放消费贷款的信托产品。'
        UNION ALL SELECT 35 ,   1  ,N'F05' ,N'资产证券化管理信息'           ,N'ZCZQHGLXX'        ,N'F'   ,N'信托运用补充信息'  ,'' ,''                 , N'本表收集信托产品涉及资产证券化业务，资产证券化业务指由信托公司担任发行人或计划管理人的资产证券化产品'
        --信托运用详情, ''  
        UNION ALL SELECT 36 ,   1  ,N'G01' ,N'证券投资管理信息'             ,N'ZQTZGLXX'         ,N'G'   ,N'信托产品详情'      ,'' ,''                 , N'本表收集信托资金投资于境内外一、二级市场股票、债券的业务信息。通过场外收购上市公司股权的，也须填写此表。信托运用信息表中，业务种类选择股票投资、债券投资，必须填报此表'
        UNION ALL SELECT 37 ,   1  ,N'G02' ,N'贷款管理信息'                 ,N'DKGLXX'           ,N'G'   ,N'信托产品详情'      ,'' ,''                 , N'本表收集信托资金按照委托人或信托合同所指定的对象、用途、期限、利率与金额等发放贷款，并负责到期收回贷款本息。信托运用信息表中，业务种类选择信托贷款，必须填报此表'
        UNION ALL SELECT 38 ,   1  ,N'G03' ,N'贷款转让业务管理信息'         ,N'DKZRYWGLXX'       ,N'G'   ,N'信托产品详情'      ,'' ,''                 , N'本表收集信托产品以信托财产受让贷款资产或委托人以贷款资产作为信托财产成立信托产品的管理信息。此表需填写的信贷资产转让不包含信贷资产转让的受益权。信托运用信息表中，业务种类选择信贷资产转让，必须填报此表。融资款发放存在多笔借款借据的，需要多次填报此表'
        UNION ALL SELECT 39 ,   1  ,N'G04' ,N'收(受）益权管理信息'          ,N'SSYQGLXX'         ,N'G'   ,N'信托产品详情'      ,'' ,''                 , N'本表收集信托资金以一定的价格受让资产收（受）益权或委托人以资产收（受）益权作为信托财产成立信托产品的关系信息，若有回购，则回购方承诺在约定条件满足时履行回购义务。信托运用信息表中，业务种类选择资产收（受）益权，必须填报此表。融资款发放存在多笔借款借据的，需要多次填报此表'
        UNION ALL SELECT 40 ,   1  ,N'G05' ,N'特定目的载体管理信息'         ,N'TDMDZTGLXX'       ,N'G'   ,N'信托产品详情'      ,'' ,''                 , N'本表收集信托资金投资于特定目的载体(包括但不限于商业银行理财产品、信托投资计划、证券投资基金、证券公司资产管理计划、基金管理公司及子公司资产管理计划、保险业资产管理机构资产管理产品等)管理信息。信托运用信息表中，业务种类选择特定目的载体份额，必须填报此表'
        UNION ALL SELECT 41 ,   1  ,N'G06' ,N'应收账款管理信息'             ,N'YSZKGLXX'         ,N'G'   ,N'信托产品详情'      ,'' ,''                 , N'本表收集信托产品以信托财产受让应收账款资产或委托人以应收账款资产作为信托财产成立信托产品的管理信息。此表需填写的应收账款不包含应收账款的受益权。信托运用信息表中，业务种类选择应收账款转让，必须填报此表。应收账款融资款的发放存在多笔借款借据的，需要多次填报此表'
        UNION ALL SELECT 42 ,   1  ,N'G07' ,N'其他非标债权管理信息'         ,N'QTFBZQGLXX'       ,N'G'   ,N'信托产品详情'      ,'' ,''                 , N'本表收集信托运用信息表中，业务种类选择其他非标准化债权投资的管理信息。本表所需填写的其他非标准化债权是指除贷款、信贷资产转让、应收账款、收(受）益权等以外的债权投资，每项债权填报一次本表'
        UNION ALL SELECT 43 ,   1  ,N'G08' ,N'其他股权投资管理信息'         ,N'WSSGQTZGLXX'      ,N'G'   ,N'信托产品详情'      ,'' ,''                 , N'本表收集信托资金直接投资于非公开市场交易的非上市公司股权、私募股权投资基金等股权性资产的管理信息。此表需填写的股权投资不包含股权投资的收受益权。信托运用信息表中，业务种类选择其他股权投资，必须填报此'
        UNION ALL SELECT 44 ,   1  ,N'G09' ,N'非私募基金类有限合伙份额'     ,N'FSMJJLYXHHFE'     ,N'G'   ,N'信托产品详情'      ,'' ,''                 , N'本表收集未在基金业协会备案的有限合伙份额相关要素信息。信托运用信息表中，业务种类选择非私募基金类有限合伙份额，必须填报此表'
        UNION ALL SELECT 45 ,   1  ,N'G10' ,N'固定资产投资管理信息'         ,N'GDZCTZGLXX'       ,N'G'   ,N'信托产品详情'      ,'' ,''                 , N'本表收集信托项目为运用、管理、处分而取得的固定资产投资管理信息。固定资产应是有形资产并使用年限超过1年、单位价值较高及为实现特定信托目的而持有的。信托运用信息表中，业务种类选择固定资产投资，必须填报此表'
        UNION ALL SELECT 46 ,   1  ,N'G11' ,N'另类投资管理信息'             ,N'LLTZGLXX'         ,N'G'   ,N'信托产品详情'      ,'' ,''                 , N'本表收集信托资金投资于艺术品、宝石、酒类、茶类、古董等领域的管理信息。信托运用信息表中，业务种类选择另类资产投资，必须填报此表'
        --信托会计信息, ''  
        UNION ALL SELECT 47 ,   1  ,N'H01' ,N'信托内部科目对照表'           ,N'XTNBKMDZB'        ,N'H'   ,N'信托产品会计'      ,'' ,''                 , N'本表收集信托公司信托业务会计科目结构信息，根据信托公司内部会计科目的设置，填报到最细项。每级科目可通过上级科目进行关联，对于一级科目其上级科目代码为"0"。'
        UNION ALL SELECT 48 ,   1  ,N'H02' ,N'信托产品总账会计全科目表'     ,N'XTCPZZKJQKMB'     ,N'H'   ,N'信托产品会计'      ,'' ,''                 , N'信托产品总账会计全科目表报送范围为信托公司信托业务全科目报表数据，包括所有进行账务处理的机构，币种只报送人民币和本外币合计。仅报送有余额、有变动的信息。报送周期与会计报表周期一致，即按月度/季度/半年度/年度。'
        UNION ALL SELECT 49 ,   1  ,N'H03' ,N'信托凭证分录明细表'           ,N'XTPZFLMXB'        ,N'H'   ,N'信托产品会计'      ,'' ,''                 , N'本表收集信托产品的凭证分录流水明细信息，金额如果涉及外币的，由各信托公司自行换算成本币金额填报。'
        UNION ALL SELECT 50 ,   1  ,N'H04' ,N'信托资产负债统计表'           ,N'XTZCFZTJB'        ,N'H'   ,N'信托产品会计'      ,'' ,''                 , N'本表收集信托产品的每月资产负债情况统计信息，金额如果涉及外币的，由各信托公司自行换算成本币金额填报。'
        --信托公司固有业务信息, ''  
        UNION ALL SELECT 51 ,   1  ,N'I01' ,N'固有交易对手（个人）'         ,N'GYJYDSGR'         ,N'I'   ,N'固有业务'          ,'' ,''                 , N'本表收集固有业务涉及的所有住户对手方相关要素信息，包括对手方和担保方等'
        UNION ALL SELECT 52 ,   1  ,N'I02' ,N'固有交易对手（机构）'         ,N'GYJYDSJG'         ,N'I'   ,N'固有业务'          ,'' ,''                 , N'本表收集固有业务涉及的所有机构对手方相关要素信息，包括对手方和担保方等'
        UNION ALL SELECT 53 ,   1  ,N'I03' ,N'固有交易对手（金融产品）'     ,N'GYJYDSJRCP'       ,N'I'   ,N'固有业务'          ,'' ,''                 , N'本表收集固有业务涉及的所有金融产品的对手方相关要素信息'
        UNION ALL SELECT 54 ,   1  ,N'I04' ,N'固有对手股东信息'             ,N'GYDSGDXX'         ,N'I'   ,N'固有业务'          ,'' ,''                 , N'"本表收集固有机构对手方的股东信息;报送规则分上市公司及非上市公司，对于非上市公司，报送全部股东信息。对于上市公司，报送前10大股东信息。且仅限于交易对手为机构"'
        UNION ALL SELECT 55 ,   1  ,N'I05' ,N'固有运用合同信息'             ,N'GYYYHTXX'         ,N'I'   ,N'固有业务'          ,'' ,''                 , N'本表收集固有资金运用合同相关要素信息'
        UNION ALL SELECT 56 ,   1  ,N'I06' ,N'固有运用合同变动'             ,N'GYYYHTBD'         ,N'I'   ,N'固有业务'          ,'' ,''                 , N'本表收集固有资金运用合同的展期与五级变动等跟踪信息'
        UNION ALL SELECT 57 ,   1  ,N'I07' ,N'固有账户信息'                 ,N'GYZHXX'           ,N'I'   ,N'固有业务'          ,'' ,''                 , N'本表收集除信托项目相关以外的所有账户信息，包括固有银行账户、股票、基金等各类账户的信息等'
        UNION ALL SELECT 58 ,   1  ,N'I08' ,N'固有运用交易流水'             ,N'GYYYJYLS'         ,N'I'   ,N'固有业务'          ,'' ,''                 , N'本表收集固有业务的所有投资交易流水信息。暂不采集具体证券交易类流水'
        UNION ALL SELECT 59 ,   1  ,N'I09' ,N'固有担保合同表'               ,N'GYDBHTB'          ,N'I'   ,N'固有业务'          ,'' ,''                 , N'本表收集固有业务涉及的担保合同信息'
        UNION ALL SELECT 60 ,   1  ,N'I10' ,N'固有抵质押物信息'             ,N'GYDZYWXX'         ,N'I'   ,N'固有业务'          ,'' ,''                 , N'本表收集固有业务担保合同下的各抵/质押物信息明细。若在固有担保合同表中选择抵押或质押，需要填写此表。若同一抵押物对应多个担保合同的，需要多次填报此表'
        UNION ALL SELECT 61 ,   1  ,N'I11' ,N'固有担保关系表'               ,N'GYDBGXB'          ,N'I'   ,N'固有业务'          ,'' ,''                 , N'本表收集固有业务担保合同和被担保合同之间的关系，为多对多关系表。一个担保合同担保多个被担保合同的，需要填写多笔；多个担保合同担保一个被担保合同的，需要填写多笔记录'
        UNION ALL SELECT 62 ,   1  ,N'I12' ,N'固有担保抵质押关系表'         ,N'GYDBDZYGXB'       ,N'I'   ,N'固有业务'          ,'' ,''                 , N'本表收集信托固有会计科目结构信息，根据各信托公司内部会计科目的设置，填报到最细项。每级科目可通过上级科目进行关联，对于一级科目其上级科目代码为"0"'
        --信托公司固有会计信息, ''  
        UNION ALL SELECT 63 ,   1  ,N'J01' ,N'固有内部科目对照表'           ,N'GYNBKMDZB'        ,N'J'   ,N'固有会计'          ,'' ,''                 , N'本表收集信托固有会计科目结构信息，根据各信托公司内部会计科目的设置，填报到最细项。每级科目可通过上级科目进行关联，对于一级科目其上级科目代码为"0"'
        UNION ALL SELECT 64 ,   1  ,N'J02' ,N'固有总账会计全科目表'         ,N'GYZZKJQKMB'       ,N'J'   ,N'固有会计'          ,'' ,''                 , N'信托产品总账会计全科目表报送范围为信托公司固有业务全科目报表数据，包括所有进行账务处理的机构，币种只报送人民币和本外币合计。仅报送有余额、有变动的信息。报送周期与会计报表周期一致，即按月度/季度/半年度/年度。'
        UNION ALL SELECT 65 ,   1  ,N'J03' ,N'固有凭证分录明细表'           ,N'GYPZFLMXB'        ,N'J'   ,N'固有会计'          ,'' ,''                 , N'本表收集信托固有的凭证分录流水明细信息，金额如果涉及外币的，由各信托公司自行换算成本币金额填报。'
        UNION ALL SELECT 66 ,   1  ,N'J04' ,N'固有资产负债统计表'           ,N'GYZCFZTJB'        ,N'J'   ,N'固有会计'          ,'' ,''                 , N'本表收集信托固有的每月资产负债情况统计信息，金额如果涉及外币的，由各信托公司自行换算成本币金额填报。'
        --UNION ALL SELECT 67, N'K01', N'附表一信托产品资产负债表'     ,N''                 ,N'K'   ,N'附件'            ,'' ,''                 , N'本表填报信托固有的凭证分录流水明细表。'
        --UNION ALL SELECT 68, N'K02', N'附表二固有业务资产负债表'     ,N''                 ,N'K'   ,N'附件'            ,'' ,''                 , N'本表填报信托固有的每月资产负债情况统计表。'
    --```
    --# 3. TEREPORTFIELD
    TRUNCATE TABLE TEREPORTFIELD
    TRUNCATE TABLE TEREPORTFIELDVERIFY
    --## 3.1.   N'A01', N'机构信息表'
    --```sql
    INSERT INTO TEREPORTFIELD(REPORT_ID,FIELD_CODE,FIELD_NAME,DATA_TYPE,DATA_LENGTH,DATA_PRECISION,DATA_METHOD,DATA_REF,VERIFY_FLAG,REF_FIELD_CODE,HINT,MESSAGE)
                  SELECT 1   ,N'XTJGMC'       ,N'信托机构名称'          ,'C'     ,200    ,0      ,'input'        ,''     ,1       ,''           ,N'必填'                                    ,'名称应与公章所使用的名称完全一致，应与银保监会金融机构许可证登记名称为准'
        UNION ALL SELECT 1   ,N'XTJGJRXKZDM'  ,N'信托机构金融许可证代码','C'     ,15     ,0      ,'input'        ,'2001' ,1       ,''           ,N'必填'                                    ,'填写银保监会颁发的金融许可证编码'
        UNION ALL SELECT 1   ,N'TYSHXYDM'     ,N'统一社会信用代码'      ,'C'     ,40     ,0      ,'input'        ,''     ,1       ,''           ,N'必填'                                    ,'填写18位统一社会信用代码'
        UNION ALL SELECT 1   ,N'XTGSJYFW'     ,N'信托公司经营范围'      ,'C'     ,2000   ,0      ,'input'        ,''     ,1       ,''           ,N'必填,'                                   ,'填写经营范围，应与工商注册中的经营范围一致'
        UNION ALL SELECT 1   ,N'ZCZB'         ,N'注册资本'              ,'D'     ,20     ,2      ,'input'        ,''     ,1       ,''           ,N'必填,'                                   ,'填写注册资本，注册资本以营业执照上的工商注册资本信息为准。若注册资本存在外币的情况，信托公司应自行换算成人民币进行填报'
        UNION ALL SELECT 1   ,N'ZCDQ'         ,N'注册地区'              ,'C'     ,6      ,0      ,'selected'     ,'1001' ,1       ,''           ,N'必填,'                                   ,'境内：按国标GB/T 2260中华人民共和国行政区划6位代码填报。参照身份证前六位的行政区域代码对应的省（区、市）、地（区、市、州、盟）、县（区、市、旗）;境外：按照《GB/T 2659 世界各国和地区名称代码》填报国家（地区）代码'
        UNION ALL SELECT 1   ,N'ZCDZ'         ,N'注册地址'              ,'C'     ,200    ,0      ,'input'        ,''     ,1       ,''           ,N'必填'                                    ,'按照工商注册信息中的注册地填报，要写明省（区、市）、地（区、市、州、盟）、县（区、市、旗）'
        UNION ALL SELECT 1   ,N'SJBGDZ'       ,N'实际办公地址'          ,'C'     ,200    ,0      ,'input'        ,''     ,1       ,''           ,N'必填'                                    ,'按照机构实际办公地址填报，要写明省（区、市）、地（区、市、州、盟）、县（区、市、旗）'
        UNION ALL SELECT 1   ,N'FDDBR'        ,N'法定代表人'            ,'C'     ,200    ,0      ,'input'        ,''     ,1       ,''           ,N'必填'                                    ,'填写法定代表人姓名，应与工商注册的姓名一致'
        UNION ALL SELECT 1   ,N'SJKZRBS'      ,N'实际控制人标识'        ,'C'     ,1      ,0      ,'selected'    ,'2002'  ,1       ,''           ,N'必填'                                   ,'填写枚举值;信托公司内部是否有实际控制人;实际控制人指虽不是公司的股东，但通过投资关系、协议或者其他安排，能够实际支配公司行为的人'
        UNION ALL SELECT 1   ,N'SJKZRLX'      ,N'实际控制人类型'        ,'C'     ,1      ,0      ,'selected'    ,'2003'  ,2       ,'SJKZRBS'    ,N'条件性必填若实际控制人标识选是，需填写' ,'填写枚举值:自然人/个体工商户/广义政府/非金融企业/金融机构（实体）/特定目的载体/境外'
        UNION ALL SELECT 1   ,N'SJKZRMC'      ,N'实际控制人名称'        ,'C'     ,200    ,0      ,'input'        ,''     ,2       ,'SJKZRBS'    ,N'条件性必填若实际控制人标识选是，需填写'  ,'填写实际控制人名称'
        UNION ALL SELECT 1   ,N'SJKZRZJLX'    ,N'实际控制人证件类型'    ,'C'     ,2      ,0      ,'selected'     ,'2004' ,2       ,'SJKZRBS'    ,N'条件性必填若实际控制人标识选是，需填写'  ,'填写枚举值(2004)。对自然人实际控制人，优先填报身份证件号码;对金融机构实际控制人，优先填报金融许可证号;对于非金融机构或其他则填报社会信用代码'
        UNION ALL SELECT 1   ,N'SJKZRZJHM'    ,N'实际控制人证件号码'    ,'C'     ,60     ,0      ,'input'        ,''     ,2       ,'SJKZRBS'    ,N'条件性必填若实际控制人标识选是，需填写'  ,'填写证件号码,自然人实际控制人的身份证件号码为隐私，信托机构变形'
        UNION ALL SELECT 1   ,N'GSZCRQ'       ,N'工商注册日期'          ,'C'     ,8      ,0      ,'input'        ,''     ,1       ,''           ,N'必填'                                    ,'以工商注册的成立日期为准'
    

    INSERT INTO TEREPORTFIELDVERIFY(REPORT_ID,FIELD_CODE,FIELD_NAME,REF_FIELD_CODE,REF_FIELD_VALUE )
                  SELECT 1,   N'SJKZRLX',      N'实际控制人类型',     N'SJKZRBS',  N'1'
        UNION ALL SELECT 1,   N'SJKZRMC',      N'实际控制人名称',     N'SJKZRBS',  N'1'
        UNION ALL SELECT 1,   N'SJKZRZJLX',    N'实际控制人证件类型', N'SJKZRBS',  N'1'
        UNION ALL SELECT 1,   N'SJKZRZJHM',    N'实际控制人证件号码', N'SJKZRBS',  N'1'

    
    --```

    --## 3.2.   N'A02', N'股东信息表'
    --```sql
    INSERT INTO TEREPORTFIELD(REPORT_ID,FIELD_CODE,FIELD_NAME,DATA_TYPE,DATA_LENGTH,DATA_PRECISION,DATA_METHOD,DATA_REF,VERIFY_FLAG,REF_FIELD_CODE,HINT,MESSAGE)
                  SELECT 2  ,'GDLX'     ,N'股东类型'                ,'C'    ,30     ,0      ,'selected'     ,'2003'     ,1      ,''             ,N'必填'                                                                ,N'填写枚举值:自然人/个体工商户/广义政府/非金融企业/金融机构（实体）/特定目的载体/境外 '
        UNION ALL SELECT 2  ,'GDMC'     ,N'股东名称'                ,'C'    ,200    ,0      ,'input'        ,''         ,1      ,''             ,N'必填'                                                                ,N''
        UNION ALL SELECT 2  ,'GDZJLX'   ,N'股东证件类型'            ,'C'    ,40     ,0      ,'selected'     ,'2004'     ,2      ,'GDLX'         ,N'条件性必填,股东类型选择广义政府的，非必填'                           ,N'填写枚举值。对自然人股东，优先填报股东身份证件号码，对金融机构股东，优先填报股东金融许可证号，对于非金融机构或其他则填报社会信用代码'
        UNION ALL SELECT 2  ,'GDZJHM'   ,N'股东证件号码'            ,'C'    ,60     ,0      ,'input'        ,''         ,2      ,'GDLX'         ,N'条件性必填,股东类型选择广义政府的，非必填'                           ,N'填写证件号码,自然人股东的身份证件号码为隐私，进行变形'
        UNION ALL SELECT 2  ,'FDDBR'    ,N'法定代表人'              ,'C'    ,200    ,0      ,'input'        ,''         ,2      ,'GDLX'         ,N'条件性必填,股东类型选择广义政府的，非必填'                           ,N'填写法定代表人姓名,填写法定代表人姓名，应与工商注册的姓名一致'
        UNION ALL SELECT 2  ,'GDJYFW'   ,N'股东业务或经营范围'      ,'C'    ,2000   ,0      ,'input'        ,''         ,2      ,'GDLX'         ,N'条件性必填,股东类型选择广义政府的，非必填'                           ,N'填写信托公司股东的业务或经营范围,填写经营范围，应与工商注册中的经营范围一致。'
        UNION ALL SELECT 2  ,'KGFS'     ,N'控股方式'                ,'C'    ,20     ,0      ,'selected'     ,'2005'     ,1      ,''             ,N'必填'                                                                ,N''
        UNION ALL SELECT 2  ,'CGBL'     ,N'持股比例'                ,'D'    ,10     ,4      ,'input'        ,''         ,1      ,''             ,N'必填'                                                                ,N''
        UNION ALL SELECT 2  ,'JGXZ'     ,N'机构性质'                ,'C'    ,60     ,0      ,'selected'     ,'2006'     ,2      ,'GDLX'         ,N'条件性必填,自然人股东非必填'                                         ,N'填写枚举值。企业法人(公司、非公司制企业法人)/企业非法人(个人独资企业、合伙企业)/行政机关/事业单位/社会团体/其他'
        UNION ALL SELECT 2  ,'QYZCLB'   ,N'企业注册类别'            ,'C'    ,30     ,0      ,'selected'     ,'2007'     ,2      ,'GDLX'         ,N'条件性必填，股东类型选择非金融企业、金融机构（实体）、境外的，需填写',N'填写枚举值。有限责任公司/股份有限公司/分公司/非公司企业法人/营业单位/企业非法人分支机构/个人独资企业/合伙企业/中外合作企业/中外合资企业/外资企业'
        UNION ALL SELECT 2  ,'HYFL'     ,N'行业分类'                ,'C'    ,20     ,0      ,'selected'     ,'2008'     ,2      ,'GDLX'         ,N'条件性必填自然人、广义政府股东非必填'                                ,N'填写枚举值填写信托公司股东的行业分类:基础产业/房地产/证券/金融机构/工商企业/其他'
        UNION ALL SELECT 2  ,'HYMX'     ,N'行业明细'                ,'C'    ,12     ,0      ,'selected'     ,'1002'     ,2      ,'GDLX'         ,N'条件性必填自然人、广义政府股东非必填'                                ,N'填写机构所属行业明细代码,行业分类按《国民经济行业分类》（GB/T 4754）执行。境外机构按“境外”填报。填报所属行业的小类代码对应的行业'
        UNION ALL SELECT 2  ,'GSZCRQ'   ,N'工商注册日期'            ,'C'    ,8      ,0      ,'input'        ,''         ,2      ,'GDLX'         ,N'条件性必填自然人、广义政府股东非必填'                                ,N'机构成立日期，YYYYMMDD，默认值99991231'
        UNION ALL SELECT 2  ,'ZCZB'     ,N'注册资本'                ,'D'    ,20     ,2      ,'input'        ,''         ,2      ,'GDLX'         ,N'条件性必填自然人、广义政府股东非必填'                                ,N'按实际金额填写,以工商注册金额为准。'
        UNION ALL SELECT 2  ,'ZCGB'     ,N'注册国别'                ,'C'    ,12     ,0      ,'selected'     ,'1003'     ,2      ,'GDLX'         ,N'条件性必填自然人、广义政府股东非必填'                                ,N'填写信托公司股东注册地区代码,境内：按国标GB/T 2260中华人民共和国行政区划6位代码填报。参照身份证前六位的行政区域代码对应的省（区、市）、地（区、市、州、盟）、县（区、市、旗）'
        UNION ALL SELECT 2  ,'ZCDQ'     ,N'注册地区'                ,'C'    ,12     ,0      ,'selected'     ,'1001'     ,2      ,'ZCGB'         ,N'条件性必填自然人、广义政府股东非必填'                                ,N'填写信托公司股东注册地区代码,境内：按国标GB/T 2260中华人民共和国行政区划6位代码填报。参照身份证前六位的行政区域代码对应的省（区、市）、地（区、市、州、盟）、县（区、市、旗）'
        UNION ALL SELECT 2  ,'ZCDZ'     ,N'注册地址'                ,'C'    ,200    ,0      ,'input'        ,''         ,2      ,'GDLX'         ,N'条件性必填自然人、广义政府股东非必填'                                ,N'填写信托公司股东注册地地址按照工商注册信息中的注册地填报，要写明省（区、市）、地（区、市、州、盟）、县（区、市、旗）'
        UNION ALL SELECT 2  ,'SJBGDZ'   ,N'实际办公地址'            ,'C'    ,200    ,0      ,'input'        ,''         ,2      ,'GDLX'         ,N'条件性必填自然人、广义政府股东非必填'                                ,N'填写信托公司股东实际办公地址:按照机构实际办公地址填报，要写明省（区、市）、地（区、市、州、盟）、县（区、市、旗）'
        UNION ALL SELECT 2  ,'SJKZRBS'  ,N'实际控制人标识'          ,'C'    ,3      ,0      ,'selected'     ,'2002'     ,2      ,'GDLX'         ,N'条件性必填自然人、广义政府股东非必填'                                ,N'填写枚举值。该股东是否有实际控制人，实际控制人指虽不是公司的股东，但通过投资关系、协议或者其他安排，能够实际支配公司行为的人。'
        UNION ALL SELECT 2  ,'SJKZRLX'  ,N'实际控制人类型'          ,'C'    ,30     ,0      ,'input'        ,'2003'     ,2      ,'SJKZRBS'      ,N'选择性填写若实际控制人标识选是，需填写'                              ,N'填写枚举值。自然人/个体工商户/广义政府/非金融企业/金融机构（实体）/特定目的载体/境外 '
        UNION ALL SELECT 2  ,'SJKZRMC'  ,N'实际控制人名称'          ,'C'    ,200    ,0      ,'input'        ,''         ,2      ,'SJKZRBS'      ,N'选择性填写若实际控制人标识选是，需填写'                              ,N'填写信托机构股东实际控制人姓名'
        UNION ALL SELECT 2  ,'SJKZRZJLX',N'实际控制人证件类型'      ,'C'    ,40      ,0      ,'selected'     ,'2004'     ,2     ,'SJKZRBS'      ,N'选择性填写若实际控制人标识选是，需填写'                              ,N'填写枚举值。对自然人实际控制人，优先填报身份证件号码，对金融机构实际控制人，优先填报金融许可证号，对于非金融机构或其他则填报社会信用代码'
        UNION ALL SELECT 2  ,'SJKZRZJHM',N'实际控制人证件号码'      ,'C'    ,60      ,0      ,'input'        ,''         ,2     ,'SJKZRBS'      ,N'选择性填写若实际控制人标识选是，需填写'                              ,N''
        --UNION ALL SELECT 2  ,'ZZSYRMC'  ,N'最终受益人名称'          ,'C'    ,2000   ,0      ,'input'        ,''         ,1      ,''             ,N'必填'                                                                ,N'若涉及到一个股东有多个最终受益人的，填写全部受益人名称并用；隔开'
        --UNION ALL SELECT 2  ,'ZZSYRZJLX',N'最终受益人证件类型'      ,'C'    ,2000   ,0      ,'input'        ,'2004'     ,1      ,''             ,N'必填'                                                                ,N'若涉及到一个股东有多个最终受益人的，枚举全部受益人类型并用；隔开。对自然人最终受益人，优先填报身份证件号码；对金融机构最终受益人，优先填报金融许可证号；对于非金融机构或其他则填报社会信用代码.'
        --UNION ALL SELECT 2  ,'ZZSYRZJHM',N'最终受益人证件号码'      ,'C'    ,2000   ,0      ,'input'        ,''         ,1      ,''             ,N'必填'                                                                ,N'若涉及到一个股东有多个最终受益人的，填写全部受益人证件号码并用；隔开。若最终受益人为自然人，则自然人的身份证件号码为隐私，信托机构变形。'
        UNION ALL SELECT 2  ,'GDZT'     ,N'股东状态'                ,'C'    ,10     ,0      ,'selected'     ,'2009'     ,1      ,''             ,N'必填'                                                                ,N''
        UNION ALL SELECT 2  ,'YZXDRBS'  ,N'一致行动人标识'          ,'C'    ,3      ,0      ,'selected'     ,'2002'     ,1      ,''             ,N'必填'                                                                ,N'填写枚举值。该股东是否与其他信托公司股东构成一致行动人，一致行动人是指投资者通过协议、其他安排，与其他投资者共同扩大其所能够支配的一个公司股份表决权数量的行为或者事实。达成一致行动的相关投资者，为一致行动人。'
        UNION ALL SELECT 2  ,'YZXDRZB'  ,N'一致行动人组别'          ,'D'    ,8      ,0      ,'input'     ,''            ,2      ,'YZXDRBS'      ,N'条件性必填.若“一致行动人标识”填报是，需填写'                         ,N''
        UNION ALL SELECT 2  ,'GQSFZY'   ,N'股权是否质押'            ,'C'    ,3      ,0      ,'selected'     ,'2002'     ,1      ,''             ,N'必填'                                                                ,N''
        UNION ALL SELECT 2  ,'GQZYBL'   ,N'股权质押比例'            ,'D'    ,10     ,4      ,'input'        ,''         ,2      ,'GQSFZY'       ,N'条件性必填。若“股权是否质押”填报是，需填写'                          ,N''
        UNION ALL SELECT 2  ,'GQSFDJ'   ,N'股权是否冻结'            ,'C'    ,3      ,0      ,'selected'     ,'2002'     ,1      ,''             ,N'必填'                                                                ,N''
        UNION ALL SELECT 2  ,'GQDJBL'    ,N'股权冻结比例'            ,'D'    ,10     ,4      ,'input'        ,''         ,2     ,'GQSFDJ'       ,N'条件性必填。若“股权是否冻结”填报是，需填写'                          ,N''
    
    INSERT INTO TEREPORTFIELDVERIFY(REPORT_ID,FIELD_CODE,FIELD_NAME,REF_FIELD_CODE,REF_FIELD_VALUE )
                  SELECT 2,   N'GDZJLX',      N'股东证件类型',       N'GDLX',  N'1'    -- 股东类型 = 1-自然人
        UNION ALL SELECT 2,   N'GDZJHM',      N'股东证件号码',       N'GDLX',  N'1'    -- 股东类型 = 1-自然人
        UNION ALL SELECT 2,   N'FDDBR',       N'股东证件号码',       N'GDLX',  N'1'    -- 股东类型 = 1-自然人
        UNION ALL SELECT 2,   N'GDJYFW',      N'股东业务或经营范围', N'GDLX',  N'1'    -- 股东类型 = 1-自然人
        UNION ALL SELECT 2,   N'GDZJLX',      N'股东证件类型',       N'GDLX',  N'2'    -- 股东类型 = 2-个体工商户
        UNION ALL SELECT 2,   N'GDZJHM',      N'股东证件号码',       N'GDLX',  N'2'    -- 股东类型 = 2-个体工商户
        UNION ALL SELECT 2,   N'FDDBR',       N'股东证件号码',       N'GDLX',  N'2'    -- 股东类型 = 2-个体工商户
        UNION ALL SELECT 2,   N'GDJYFW',      N'股东业务或经营范围', N'GDLX',  N'2'    -- 股东类型 = 2-个体工商户
        UNION ALL SELECT 2,   N'GDZJLX',      N'股东证件类型',       N'GDLX',  N'4'    -- 股东类型 = 4-非金融企业
        UNION ALL SELECT 2,   N'GDZJHM',      N'股东证件号码',       N'GDLX',  N'4'    -- 股东类型 = 4-非金融企业
        UNION ALL SELECT 2,   N'FDDBR',       N'股东证件号码',       N'GDLX',  N'4'    -- 股东类型 = 4-非金融企业
        UNION ALL SELECT 2,   N'GDJYFW',      N'股东业务或经营范围', N'GDLX',  N'4'    -- 股东类型 = 4-非金融企业
        UNION ALL SELECT 2,   N'GDZJLX',      N'股东证件类型',       N'GDLX',  N'5'    -- 股东类型 = 5-金融机构（实体）
        UNION ALL SELECT 2,   N'GDZJHM',      N'股东证件号码',       N'GDLX',  N'5'    -- 股东类型 = 5-金融机构（实体）
        UNION ALL SELECT 2,   N'FDDBR',       N'股东证件号码',       N'GDLX',  N'5'    -- 股东类型 = 5-金融机构（实体）
        UNION ALL SELECT 2,   N'GDJYFW',      N'股东业务或经营范围', N'GDLX',  N'5'    -- 股东类型 = 5-金融机构（实体）
        UNION ALL SELECT 2,   N'GDZJLX',      N'股东证件类型',       N'GDLX',  N'6'    -- 股东类型 = 6-特定目的载体
        UNION ALL SELECT 2,   N'GDZJHM',      N'股东证件号码',       N'GDLX',  N'6'    -- 股东类型 = 6-特定目的载体
        UNION ALL SELECT 2,   N'FDDBR',       N'股东证件号码',       N'GDLX',  N'6'    -- 股东类型 = 6-特定目的载体
        UNION ALL SELECT 2,   N'GDJYFW',      N'股东业务或经营范围', N'GDLX',  N'6'    -- 股东类型 = 6-特定目的载体
        UNION ALL SELECT 2,   N'GDZJLX',      N'股东证件类型',       N'GDLX',  N'7'    -- 股东类型 = 7-境外
        UNION ALL SELECT 2,   N'GDZJHM',      N'股东证件号码',       N'GDLX',  N'7'    -- 股东类型 = 7-境外
        UNION ALL SELECT 2,   N'FDDBR',       N'股东证件号码',       N'GDLX',  N'7'    -- 股东类型 = 7-境外
        UNION ALL SELECT 2,   N'GDJYFW',      N'股东业务或经营范围', N'GDLX',  N'7'    -- 股东类型 = 7-境外

        UNION ALL SELECT 2,   N'JGXZ',        N'机构性质',           N'GDLX'    ,N'2'    -- 股东类型 = 2-个体工商户
        UNION ALL SELECT 2,   N'QYZCLB',      N'企业注册类别',       N'GDLX'    ,N'2'    -- 股东类型 = 2-个体工商户
        UNION ALL SELECT 2,   N'HYFL',        N'行业分类',           N'GDLX'    ,N'2'    -- 股东类型 = 2-个体工商户
        UNION ALL SELECT 2,   N'HYMX',        N'行业明细',           N'GDLX'    ,N'2'    -- 股东类型 = 2-个体工商户
        UNION ALL SELECT 2,   N'GSZCRQ',      N'工商注册日期',       N'GDLX'    ,N'2'    -- 股东类型 = 2-个体工商户
        UNION ALL SELECT 2,   N'ZCZB',        N'注册资本',           N'GDLX'    ,N'2'    -- 股东类型 = 2-个体工商户
        --UNION ALL SELECT 2,   N'ZCDQ',        N'注册地区',           N'GDLX'    ,N'2'    -- 股东类型 = 2-个体工商户
        UNION ALL SELECT 2,   N'ZCGB',        N'注册地区',           N'GDLX'    ,N'2'    -- 股东类型 = 2-个体工商户
        UNION ALL SELECT 2,   N'ZCDZ',        N'注册地址',           N'GDLX'    ,N'2'    -- 股东类型 = 2-个体工商户
        UNION ALL SELECT 2,   N'SJBGDZ',      N'实际办公地址',       N'GDLX'    ,N'2'    -- 股东类型 = 2-个体工商户
        UNION ALL SELECT 2,   N'SJKZRBS',     N'实际控制人标识',     N'GDLX'    ,N'2'    -- 股东类型 = 2-个体工商户
        UNION ALL SELECT 2,   N'JGXZ',        N'机构性质',           N'GDLX'    ,N'4'    -- 股东类型 = 4-非金融企业
        UNION ALL SELECT 2,   N'QYZCLB',      N'企业注册类别',       N'GDLX'    ,N'4'    -- 股东类型 = 4-非金融企业
        UNION ALL SELECT 2,   N'HYFL',        N'行业分类',           N'GDLX'    ,N'4'    -- 股东类型 = 4-非金融企业
        UNION ALL SELECT 2,   N'HYMX',        N'行业明细',           N'GDLX'    ,N'4'    -- 股东类型 = 4-非金融企业
        UNION ALL SELECT 2,   N'GSZCRQ',      N'工商注册日期',       N'GDLX'    ,N'4'    -- 股东类型 = 4-非金融企业
        UNION ALL SELECT 2,   N'ZCZB',        N'注册资本',           N'GDLX'    ,N'4'    -- 股东类型 = 4-非金融企业
        --UNION ALL SELECT 2,   N'ZCDQ',        N'注册地区',           N'GDLX'    ,N'4'    -- 股东类型 = 4-非金融企业
        UNION ALL SELECT 2,   N'ZCGB',        N'注册国别',           N'GDLX'    ,N'4'    -- 股东类型 = 4-非金融企业
        UNION ALL SELECT 2,   N'ZCDZ',        N'注册地址',           N'GDLX'    ,N'4'    -- 股东类型 = 4-非金融企业
        UNION ALL SELECT 2,   N'SJBGDZ',      N'实际办公地址',       N'GDLX'    ,N'4'    -- 股东类型 = 4-非金融企业
        UNION ALL SELECT 2,   N'SJKZRBS',     N'实际控制人标识',     N'GDLX'    ,N'4'    -- 股东类型 = 4-非金融企业
        UNION ALL SELECT 2,   N'JGXZ',        N'机构性质',           N'GDLX'    ,N'5'    -- 股东类型 = 5-金融机构（实体）
        UNION ALL SELECT 2,   N'QYZCLB',      N'企业注册类别',       N'GDLX'    ,N'5'    -- 股东类型 = 5-金融机构（实体）
        UNION ALL SELECT 2,   N'HYFL',        N'行业分类',           N'GDLX'    ,N'5'    -- 股东类型 = 5-金融机构（实体）
        UNION ALL SELECT 2,   N'HYMX',        N'行业明细',           N'GDLX'    ,N'5'    -- 股东类型 = 5-金融机构（实体）
        UNION ALL SELECT 2,   N'GSZCRQ',      N'工商注册日期',       N'GDLX'    ,N'5'    -- 股东类型 = 5-金融机构（实体）
        UNION ALL SELECT 2,   N'ZCZB',        N'注册资本',           N'GDLX'    ,N'5'    -- 股东类型 = 5-金融机构（实体）
        --UNION ALL SELECT 2,   N'ZCDQ',        N'注册地区',           N'GDLX'    ,N'5'    -- 股东类型 = 5-金融机构（实体）
        UNION ALL SELECT 2,   N'ZCGB',        N'注册国别',           N'GDLX'    ,N'5'    -- 股东类型 = 5-金融机构（实体）
        UNION ALL SELECT 2,   N'ZCDZ',        N'注册地址',           N'GDLX'    ,N'5'    -- 股东类型 = 5-金融机构（实体）
        UNION ALL SELECT 2,   N'SJBGDZ',      N'实际办公地址',       N'GDLX'    ,N'5'    -- 股东类型 = 5-金融机构（实体）
        UNION ALL SELECT 2,   N'SJKZRBS',     N'实际控制人标识',     N'GDLX'    ,N'5'    -- 股东类型 = 5-金融机构（实体）
        UNION ALL SELECT 2,   N'JGXZ',        N'机构性质',           N'GDLX'    ,N'6'    -- 股东类型 = 6-特定目的载体
        UNION ALL SELECT 2,   N'QYZCLB',      N'企业注册类别',       N'GDLX'    ,N'6'    -- 股东类型 = 6-特定目的载体
        UNION ALL SELECT 2,   N'HYFL',        N'行业分类',           N'GDLX'    ,N'6'    -- 股东类型 = 6-特定目的载体
        UNION ALL SELECT 2,   N'HYMX',        N'行业明细',           N'GDLX'    ,N'6'    -- 股东类型 = 6-特定目的载体
        UNION ALL SELECT 2,   N'GSZCRQ',      N'工商注册日期',       N'GDLX'    ,N'6'    -- 股东类型 = 6-特定目的载体
        UNION ALL SELECT 2,   N'ZCZB',        N'注册资本',           N'GDLX'    ,N'6'    -- 股东类型 = 6-特定目的载体
        --UNION ALL SELECT 2,   N'ZCDQ',        N'注册地区',           N'GDLX'    ,N'6'    -- 股东类型 = 6-特定目的载体
        UNION ALL SELECT 2,   N'ZCGB',        N'注册国别',           N'GDLX'    ,N'6'    -- 股东类型 = 6-特定目的载体
        UNION ALL SELECT 2,   N'ZCDZ',        N'注册地址',           N'GDLX'    ,N'6'    -- 股东类型 = 6-特定目的载体
        UNION ALL SELECT 2,   N'SJBGDZ',      N'实际办公地址',       N'GDLX'    ,N'6'    -- 股东类型 = 6-特定目的载体
        UNION ALL SELECT 2,   N'SJKZRBS',     N'实际控制人标识',     N'GDLX'    ,N'6'    -- 股东类型 = 6-特定目的载体
        UNION ALL SELECT 2,   N'JGXZ',        N'机构性质',           N'GDLX'    ,N'7'    -- 股东类型 = 7-境外
        UNION ALL SELECT 2,   N'QYZCLB',      N'企业注册类别',       N'GDLX'    ,N'7'    -- 股东类型 = 7-境外
        UNION ALL SELECT 2,   N'HYFL',        N'行业分类',           N'GDLX'    ,N'7'    -- 股东类型 = 7-境外
        UNION ALL SELECT 2,   N'HYMX',        N'行业明细',           N'GDLX'    ,N'7'    -- 股东类型 = 7-境外
        UNION ALL SELECT 2,   N'GSZCRQ',      N'工商注册日期',       N'GDLX'    ,N'7'    -- 股东类型 = 7-境外
        UNION ALL SELECT 2,   N'ZCZB',        N'注册资本',           N'GDLX'    ,N'7'    -- 股东类型 = 7-境外
        --UNION ALL SELECT 2,   N'ZCDQ',        N'注册地区',           N'GDLX'    ,N'7'    -- 股东类型 = 7-境外
        UNION ALL SELECT 2,   N'ZCGB',        N'注册国别',           N'GDLX'    ,N'7'    -- 股东类型 = 7-境外
        UNION ALL SELECT 2,   N'ZCDZ',        N'注册地址',           N'GDLX'    ,N'7'    -- 股东类型 = 7-境外
        UNION ALL SELECT 2,   N'SJBGDZ',      N'实际办公地址',       N'GDLX'    ,N'7'    -- 股东类型 = 7-境外
        UNION ALL SELECT 2,   N'SJKZRBS',     N'实际控制人标识',     N'GDLX'    ,N'7'    -- 股东类型 = 7-境外

        UNION ALL SELECT 2,   N'ZCDQ',        N'注册地区',           N'ZCGB'    ,N'CHN'    -- 股东类型 = 7-境外
        UNION ALL SELECT 2,   N'SJKZRLX',     N'实际控制人类型',     N'SJKZRBS', N'1' -- 实际控制人标识 = 1-是
        UNION ALL SELECT 2,   N'SJKZRMC',     N'实际控制人名称',     N'SJKZRBS', N'1' -- 实际控制人标识 = 1-是
        UNION ALL SELECT 2,   N'SJKZRZJLX',   N'实际控制人证件类型', N'SJKZRBS', N'1' -- 实际控制人标识 = 1-是
        UNION ALL SELECT 2,   N'SJKZRZJHM',   N'实际控制人证件号码', N'SJKZRBS', N'1' -- 实际控制人标识 = 1-是
        UNION ALL SELECT 2,   N'YZXDRZB',     N'一致行动人组别',     N'YZXDRBS', N'1' -- 一致行动人标识 = 1-是
        UNION ALL SELECT 2,   N'GQZYBL',      N'股权质押比例',       N'GQSFZY',  N'1'  -- 股权是否质押 = 1-是
        UNION ALL SELECT 2,   N'GQDJBL',      N'股权冻结比例',       N'GQSFDJ',  N'1'  -- 股权冻结比例 = 1-是
    --```

    --## 3.2.1   N'A02', N'股东受益所有人'
    --```sql
    INSERT INTO TEREPORTFIELD(REPORT_ID,FIELD_CODE,FIELD_NAME,DATA_TYPE,DATA_LENGTH,DATA_PRECISION,DATA_METHOD,DATA_REF,VERIFY_FLAG,REF_FIELD_CODE,HINT,MESSAGE)
                  SELECT 201,'ZZSYRMC'  ,N'最终受益人名称'          ,'C'    ,200    ,0      ,'input'        ,''         ,1      ,''             ,N'必填'                                                                ,N'若涉及到一个股东有多个最终受益人的，填写全部受益人名称并用；隔开'
        UNION ALL SELECT 201,'ZZSYRZJLX',N'最终受益人证件类型'      ,'C'    ,30     ,0      ,'input'        ,'2004'     ,1      ,''             ,N'必填'                                                                ,N'若涉及到一个股东有多个最终受益人的，枚举全部受益人类型并用；隔开。对自然人最终受益人，优先填报身份证件号码；对金融机构最终受益人，优先填报金融许可证号；对于非金融机构或其他则填报社会信用代码.'
        UNION ALL SELECT 201,'ZZSYRZJHM',N'最终受益人证件号码'      ,'C'    ,60     ,0      ,'input'        ,''         ,1      ,''             ,N'必填'                                                                ,N'若涉及到一个股东有多个最终受益人的，填写全部受益人证件号码并用；隔开。若最终受益人为自然人，则自然人的身份证件号码为隐私，信托机构变形。'
    --## 3.3.   N'A03', N'员工信息表'
    --```sql
    INSERT INTO TEREPORTFIELD(REPORT_ID,FIELD_CODE,FIELD_NAME,DATA_TYPE,DATA_LENGTH,DATA_PRECISION,DATA_METHOD,DATA_REF,VERIFY_FLAG,REF_FIELD_CODE,HINT,MESSAGE)
                  SELECT 3, 'YGH'       ,N'员工工号'        ,'C'    ,200    ,0  ,'input'            ,''      ,1     ,''           ,'必填'                                                 ,N'信托公司自定义：员工工号'
        UNION ALL SELECT 3, 'YGXM'      ,N'员工姓名'        ,'C'    ,200    ,0  ,'input'            ,''      ,1     ,''           ,'必填'                                                 ,N'员工姓名应与有效证件上的姓名一致'
        UNION ALL SELECT 3, 'YGZJLX'    ,N'员工证件类型'    ,'C'    ,30     ,0  ,'selected'         ,'2010'  ,1     ,''           ,'必填'                                                 ,N'填写枚举值。建议以身份证为主要选择项'
        UNION ALL SELECT 3, 'YGJZHM'    ,N'员工证件号码'    ,'C'    ,60     ,0  ,'input'            ,''      ,1     ,''           ,'必填'                                                 ,N''
        UNION ALL SELECT 3, 'ZZMM'      ,N'政治面貌'        ,'C'    ,20     ,0  ,'input'            ,'2011'  ,1     ,''           ,'必填'                                                  ,N'填写枚举值'
        UNION ALL SELECT 3, 'LXDH'      ,N'联系电话'        ,'C'    ,30     ,0  ,'input'            ,''      ,0     ,''           ,'非必填'                                               ,N'填写联系电话号码,信托公司自定义：区号-座机电话或手机,电话号码为隐私，暂不取'
        UNION ALL SELECT 3, 'SSBM'      ,N'所属部门'        ,'C'    ,200    ,0  ,'input'            ,''      ,1     ,''           ,'必填'                                                 ,N''
        UNION ALL SELECT 3, 'SSBMFL'    ,N'所属部门分类'    ,'C'    ,100     ,0  ,'multiselected'   ,'2012'  ,1     ,''           ,'必填'                                             ,N'信托公司自定义：中文描述'
        UNION ALL SELECT 3, 'YGZW'      ,N'员工职务'        ,'C'    ,200    ,0  ,'input'            ,''      ,1     ,''           ,'必填'                                                 ,N'填写职务名称	信托公司自定义：中文描述'
        UNION ALL SELECT 3, 'SFGG'      ,N'是否高管'        ,'C'    ,3      ,0  ,'selected'         ,'2002'  ,1     ,''           ,'必填'                                                 ,N'填写枚举值。此员工是否属于高级管理人员,高级管理人员，是指公司的经理、副经理、财务负责人，上市公司董事会秘书和公司章程规定的其他人员'
        UNION ALL SELECT 3, 'YGBZ'      ,N'员工编制'        ,'C'    ,20     ,0  ,'selected'         ,'2013'  ,1     ,''           ,'必填'                                                 ,N'填写枚举值。员工编制状态，默认状态为正式员工。若员工离职，按离职前编制填报'
        UNION ALL SELECT 3, 'YGZT'      ,N'员工状态'        ,'C'    ,20     ,0  ,'selected'         ,'2014'  ,1     ,''           ,'必填'                                                 ,N'填写枚举值。员工在职状态,待岗/在职(默认)/离职/停职/退休/长期休假/其他'
        UNION ALL SELECT 3, 'RZRQ'      ,N'入职日期'        ,'C'    ,8      ,0  ,'input'            ,''      ,2     ,'YGZT'       ,'条件性必填,若员工状态为在职、停职、退休时，必填'      ,N'员工入职时间，以信托公司人力系统记载日期为准'
        UNION ALL SELECT 3, 'LZRQ'      ,N'离职日期'        ,'C'    ,8      ,0  ,'input'            ,''      ,2     ,'YGZT'       ,'条件性必填,若员工状态为离职时，必填'                  ,N'员工离职时间，以信托公司人力系统记载日期为准'
        UNION ALL SELECT 3, 'BGGB'      ,N'办公国别'        ,'C'    ,12     ,0  ,'selected'         ,'1003'  ,1     ,''           ,'必填'                                                 ,N'填写员工办公地点,境内：按国标GB/T 2260 中华人民共和国行政区划6位代码填报。参照身份证前六位的行政区域代码对应的省（区、市）、地（区、市、州、盟）、县（区、市、旗）。 境外：按照《GB/T 2659 世界各国和地区名称代码》填报国家（地区）代码。若该员工已离职或已退休，办公地点以最近一次办公地点为准'
        UNION ALL SELECT 3, 'BGDQ'      ,N'办公地区'        ,'C'    ,12     ,0  ,'selected'         ,'1001'  ,2     ,'BGGB'       ,'必填'                                                 ,N'填写员工办公地点,境内：按国标GB/T 2260 中华人民共和国行政区划6位代码填报。参照身份证前六位的行政区域代码对应的省（区、市）、地（区、市、州、盟）、县（区、市、旗）。 境外：按照《GB/T 2659 世界各国和地区名称代码》填报国家（地区）代码。若该员工已离职或已退休，办公地点以最近一次办公地点为准'
        UNION ALL SELECT 3, 'GWMC'      ,N'岗位名称'        ,'C'    ,30     ,0  ,'input'            ,''      ,1     ,''           ,'必填'                                                 ,N'填写岗位名称。信托公司自定义，对于该岗位的简称，以各信托公司内部发文为准'
        UNION ALL SELECT 3, 'GWMS'      ,N'岗位描述'        ,'C'    ,200    ,0  ,'input'            ,''      ,1     ,''           ,'必填'                                                 ,N'填写岗位描述。信托公司自定义，对于该岗位的简单描述，描述应包含该岗位的工作职责，工作内容等'

    INSERT INTO TEREPORTFIELDVERIFY(REPORT_ID,FIELD_CODE,FIELD_NAME,REF_FIELD_CODE,REF_FIELD_VALUE )
                  SELECT 3,   N'RZRQ',      N'入职日期',      N'YGZT',  N'2' -- 员工状态 = 2-在职(默认)
      --UNION ALL SELECT 3,   N'RZRQ',      N'入职日期',      N'YGZT',  N'3' -- 员工状态 = 3-离职
        UNION ALL SELECT 3,   N'RZRQ',      N'入职日期',      N'YGZT',  N'4' -- 员工状态 = 4-停职
        UNION ALL SELECT 3,   N'RZRQ',      N'入职日期',      N'YGZT',  N'5' -- 员工状态 = 5-退休
      --UNION ALL SELECT 3,   N'RZRQ',      N'入职日期',      N'YGZT',  N'6' -- 员工状态 = 6-长期休假
      --UNION ALL SELECT 3,   N'RZRQ',      N'入职日期',      N'YGZT',  N'7' -- 员工状态 = 7-其他

        UNION ALL SELECT 3,   N'LZRQ',     N'离职日期',       N'YGZT',  N'3' -- 员工状态 = 3-离职

        UNION ALL SELECT 3,   N'BGDQ',     N'办公地区',       N'BGGB',  N'CHN'  --办公国家 = CHN-中国

    --```

    --## 3.4.   N'A04', N'关联方'
    --```sql
    INSERT INTO TEREPORTFIELD(REPORT_ID,FIELD_CODE,FIELD_NAME,DATA_TYPE,DATA_LENGTH,DATA_PRECISION,DATA_METHOD,DATA_REF,VERIFY_FLAG,REF_FIELD_CODE,HINT,MESSAGE)
                  SELECT 4,'GLFBH'      ,'关联方编号'           ,'C',   40      ,0      ,'input'        ,''        ,1      ,''            ,'必填'                                                                          ,N'填写关联方编号。信托公司自定义：信托公司内部对关联方的统一编号'
        UNION ALL SELECT 4,'GLFLX'      ,'关联方类型'           ,'C',   30      ,0      ,'selected'     ,'2003'    ,1      ,''            ,'必填'                                                                          ,N'填写枚举值。自然人/个体工商户/广义政府/非金融企业/金融机构（实体）/特定目的载体/境外 '
        UNION ALL SELECT 4,'GLLX'       ,'关联类型'             ,'C',   500     ,0      ,'multiselected','2015'    ,1      ,''            ,'必填'                                                                          ,N'填写枚举值。关联类型指该信托客户和本信托公司的关联关系类型。其中，关系密切的家庭成员包括配偶、父母、及配偶的父母、兄弟姐妹及其配偶、配偶的兄弟姐妹、年满18周岁的子女及其配偶和子女配偶的父母'
        UNION ALL SELECT 4,'GLFMC'      ,'关联方名称'           ,'C',   200     ,0      ,'input'        ,''        ,1      ,''            ,'必填'                                                                          ,N'填写名称'
        UNION ALL SELECT 4,'GLFZJLX'    ,'关联方证件类型'       ,'C',   40      ,0      ,'selected'     ,'2004'    ,1      ,''            ,'必填'                                                                          ,N'填写枚举值。对自然人关联方，优先填报关联方身份证件号码，对金融机构关联方，优先填报关联方金融许可证号，对于非金融机构或其他则填报社会信用代码'
        UNION ALL SELECT 4,'GLFZJHM'    ,'关联方证件号码'       ,'C',   60      ,0      ,'input'        ,''        ,1      ,''            ,'必填'                                                                          ,N'填写证件号码。若关联方为自然人，则关联方的身份证件号码为隐私，信托机构变形'
        UNION ALL SELECT 4,'GLFJYFW'    ,'关联方业务或经营范围' ,'C',   200     ,0      ,'input'        ,''        ,1      ,''            ,'必填'                                                                          ,N'填写经营范围，应与工商注册中的经营范围一致。填写关联方的业务或经营范围'
        UNION ALL SELECT 4,'HYFL'       ,'行业分类'             ,'C',   20      ,0      ,'selected'     ,'2008'    ,2      ,'GLFLX'       ,'条件性必填,若关联方是自然人，非必填'                                           ,N'填写枚举值，基础产业/房地产/证券/金融机构/工商企业/其他'
        UNION ALL SELECT 4,'HYMX'       ,'行业明细'             ,'C',   12      ,0      ,'selected'     ,'1002'    ,2      ,'GLFLX'       ,'条件性必填,若关联方是自然人，非必填'                                           ,N'填写机构所属行业明细代码，行业分类按《国民经济行业分类》（GB/T 4754）执行。境外机构按“境外”填报。填报所属行业的小类代码对应的行业'
        UNION ALL SELECT 4,'QYZCLB'     ,'企业注册类别'         ,'C',   30      ,0      ,'selected'     ,'2007'    ,2      ,'GLFLX'       ,'条件性必填，若关联方类型选择非金融企业、金融机构（实体）、境外的，需填写'      ,N'填写枚举值，有限责任公司/股份有限公司/分公司/非公司企业法人/营业单位/企业非法人分支机构/个人独资企业/合伙企业/中外合作企业/中外合资企业/外资企业'
        UNION ALL SELECT 4,'GSZCRQ'     ,'工商注册日期'         ,'C',   8       ,0      ,'input'        ,''        ,2      ,'GLFLX'       ,'条件性必填,若关联方是自然人，非必填'                                           ,N'机构成立日期，YYYYMMDD，默认值99991231'
        UNION ALL SELECT 4,'ZCZB'       ,'注册资本'             ,'D',   20      ,2,     'input'         ,''        ,2      ,'GLFLX'       ,'条件性必填,若关联方是自然人，非必填'                                           ,N'按实际金额填写。"以工商注册金额为准若金额涉及到外币，由信托公司自行转换成人民币进行填报"'
        UNION ALL SELECT 4,'ZCGB'       ,'注册国别'             ,'C',   12      ,0      ,'selected'     ,'1003'    ,2      ,'GLFLX'       ,'条件性必填,若关联方是自然人，非必填'                                           ,N'填写关联方注册地区代码。境内：按国标GB/T 2260中华人民共和国行政区划6位代码填报。参照身份证前六位的行政区域代码对应的省（区、市）、地（区、市、州、盟）、县（区、市、旗）。 境外：按照《GB/T 2659 世界各国和地区名称代码》填报国家（地区）代码'        
        UNION ALL SELECT 4,'ZCDQ'       ,'注册地区'             ,'C',   12      ,0      ,'selected'     ,'1001'    ,2      ,'ZCGB'        ,'条件性必填,若关联方是自然人，非必填'                                           ,N'填写关联方注册地区代码。境内：按国标GB/T 2260中华人民共和国行政区划6位代码填报。参照身份证前六位的行政区域代码对应的省（区、市）、地（区、市、州、盟）、县（区、市、旗）。 境外：按照《GB/T 2659 世界各国和地区名称代码》填报国家（地区）代码'
        UNION ALL SELECT 4,'ZCDZ'       ,'注册地址'             ,'C',   200     ,0      ,'input'        ,''        ,2      ,'GLFLX'       ,'条件性必填,若关联方是自然人，非必填'                                           ,N'填写关联方注册地地址，按照工商注册信息中的注册地填报，要写明省（区、市）、地（区、市、州、盟）、县（区、市、旗）'
        UNION ALL SELECT 4,'SJBGDZ'     ,'实际办公地址'         ,'C',   200     ,0      ,'input'        ,''        ,2      ,'GLFLX'       ,'条件性必填,若关联方是自然人，非必填'                                           ,N'填写关联方实际办公地址，按照机构实际办公地址填报，要写明省（区、市）、地（区、市、州、盟）、县（区、市、旗）'

    INSERT INTO TEREPORTFIELDVERIFY(REPORT_ID,FIELD_CODE,FIELD_NAME,REF_FIELD_CODE,REF_FIELD_VALUE )
                  SELECT 4,   N'HYFL',      N'行业分类',      N'GLFLX',     N'2'      -- 关联方类型 = 2-个体工商户
        UNION ALL SELECT 4,   N'HYMX',      N'行业明细',      N'GLFLX',     N'2'      -- 关联方类型 = 2-个体工商户
        UNION ALL SELECT 4,   N'GSZCRQ',    N'工商注册日期',  N'GLFLX',     N'2'      -- 关联方类型 = 2-个体工商户
        UNION ALL SELECT 4,   N'ZCZB',      N'注册资本',      N'GLFLX',     N'2'      -- 关联方类型 = 2-个体工商户
        --UNION ALL SELECT 4,   N'ZCDQ',      N'注册地区',      N'GLFLX',     N'2'      -- 关联方类型 = 2-个体工商户
        UNION ALL SELECT 4,   N'ZCGB',      N'注册国别',      N'GLFLX',     N'2'      -- 关联方类型 = 2-个体工商户
        UNION ALL SELECT 4,   N'ZCDZ',      N'注册地址',      N'GLFLX',     N'2'      -- 关联方类型 = 2-个体工商户
        UNION ALL SELECT 4,   N'SJBGDZ',    N'实际办公地址',  N'GLFLX',     N'2'      -- 关联方类型 = 2-个体工商户

        UNION ALL SELECT 4,   N'HYFL',      N'行业分类',      N'GLFLX',     N'3'      -- 关联方类型 = 3-广义政府
        UNION ALL SELECT 4,   N'HYMX',      N'行业明细',      N'GLFLX',     N'3'      -- 关联方类型 = 3-广义政府
        UNION ALL SELECT 4,   N'GSZCRQ',    N'工商注册日期',  N'GLFLX',     N'3'      -- 关联方类型 = 3-广义政府
        UNION ALL SELECT 4,   N'ZCZB',      N'注册资本',      N'GLFLX',     N'3'      -- 关联方类型 = 3-广义政府
        --UNION ALL SELECT 4,   N'ZCDQ',      N'注册地区',      N'GLFLX',     N'3'      -- 关联方类型 = 3-广义政府
        UNION ALL SELECT 4,   N'ZCGB',      N'注册国别',      N'GLFLX',     N'3'      -- 关联方类型 = 3-广义政府
        UNION ALL SELECT 4,   N'ZCDZ',      N'注册地址',      N'GLFLX',     N'3'      -- 关联方类型 = 3-广义政府
        UNION ALL SELECT 4,   N'SJBGDZ',    N'实际办公地址',  N'GLFLX',     N'3'      -- 关联方类型 = 3-广义政府

        UNION ALL SELECT 4,   N'HYFL',      N'行业分类',      N'GLFLX',     N'4'      -- 关联方类型 = 4-非金融企业
        UNION ALL SELECT 4,   N'HYMX',      N'行业明细',      N'GLFLX',     N'4'      -- 关联方类型 = 4-非金融企业
        UNION ALL SELECT 4,   N'GSZCRQ',    N'工商注册日期',  N'GLFLX',     N'4'      -- 关联方类型 = 4-非金融企业
        UNION ALL SELECT 4,   N'ZCZB',      N'注册资本',      N'GLFLX',     N'4'      -- 关联方类型 = 4-非金融企业
        --UNION ALL SELECT 4,   N'ZCDQ',      N'注册地区',      N'GLFLX',     N'4'      -- 关联方类型 = 4-非金融企业
        UNION ALL SELECT 4,   N'ZCGB',      N'注册国别',      N'GLFLX',     N'4'      -- 关联方类型 = 4-非金融企业
        UNION ALL SELECT 4,   N'ZCDZ',      N'注册地址',      N'GLFLX',     N'4'      -- 关联方类型 = 4-非金融企业
        UNION ALL SELECT 4,   N'SJBGDZ',    N'实际办公地址',  N'GLFLX',     N'4'      -- 关联方类型 = 4-非金融企业

        UNION ALL SELECT 4,   N'HYFL',      N'行业分类',      N'GLFLX',     N'5'      -- 关联方类型 = 5-金融机构（实体）
        UNION ALL SELECT 4,   N'HYMX',      N'行业明细',      N'GLFLX',     N'5'      -- 关联方类型 = 5-金融机构（实体）
        UNION ALL SELECT 4,   N'GSZCRQ',    N'工商注册日期',  N'GLFLX',     N'5'      -- 关联方类型 = 5-金融机构（实体）
        UNION ALL SELECT 4,   N'ZCZB',      N'注册资本',      N'GLFLX',     N'5'      -- 关联方类型 = 5-金融机构（实体）
        --UNION ALL SELECT 4,   N'ZCDQ',      N'注册地区',      N'GLFLX',     N'5'      -- 关联方类型 = 5-金融机构（实体）
        UNION ALL SELECT 4,   N'ZCGB',      N'注册国别',      N'GLFLX',     N'5'      -- 关联方类型 = 5-金融机构（实体）
        UNION ALL SELECT 4,   N'ZCDZ',      N'注册地址',      N'GLFLX',     N'5'      -- 关联方类型 = 5-金融机构（实体）
        UNION ALL SELECT 4,   N'SJBGDZ',    N'实际办公地址',  N'GLFLX',     N'5'      -- 关联方类型 = 5-金融机构（实体）

        UNION ALL SELECT 4,   N'HYFL',      N'行业分类',      N'GLFLX',     N'6'      -- 关联方类型 = 6-特定目的载体
        UNION ALL SELECT 4,   N'HYMX',      N'行业明细',      N'GLFLX',     N'6'      -- 关联方类型 = 6-特定目的载体
        UNION ALL SELECT 4,   N'GSZCRQ',    N'工商注册日期',  N'GLFLX',     N'6'      -- 关联方类型 = 6-特定目的载体
        UNION ALL SELECT 4,   N'ZCZB',      N'注册资本',      N'GLFLX',     N'6'      -- 关联方类型 = 6-特定目的载体
       -- UNION ALL SELECT 4,   N'ZCDQ',      N'注册地区',      N'GLFLX',     N'6'      -- 关联方类型 = 6-特定目的载体
        UNION ALL SELECT 4,   N'ZCGB',      N'注册国别',      N'GLFLX',     N'6'      -- 关联方类型 = 6-特定目的载体
        UNION ALL SELECT 4,   N'ZCDZ',      N'注册地址',      N'GLFLX',     N'6'      -- 关联方类型 = 6-特定目的载体
        UNION ALL SELECT 4,   N'SJBGDZ',    N'实际办公地址',  N'GLFLX',     N'6'      -- 关联方类型 = 6-特定目的载体

        UNION ALL SELECT 4,   N'HYFL',      N'行业分类',      N'GLFLX',     N'7'      -- 关联方类型 = 7-境外
        UNION ALL SELECT 4,   N'HYMX',      N'行业明细',      N'GLFLX',     N'7'      -- 关联方类型 = 7-境外
        UNION ALL SELECT 4,   N'GSZCRQ',    N'工商注册日期',  N'GLFLX',     N'7'      -- 关联方类型 = 7-境外
        UNION ALL SELECT 4,   N'ZCZB',      N'注册资本',      N'GLFLX',     N'7'      -- 关联方类型 = 7-境外
        --UNION ALL SELECT 4,   N'ZCDQ',      N'注册地区',      N'GLFLX',     N'7'      -- 关联方类型 = 7-境外
        UNION ALL SELECT 4,   N'ZCGB',      N'注册国别',      N'GLFLX',     N'7'      -- 关联方类型 = 7-境外
        UNION ALL SELECT 4,   N'ZCDZ',      N'注册地址',      N'GLFLX',     N'7'      -- 关联方类型 = 7-境外
        UNION ALL SELECT 4,   N'SJBGDZ',    N'实际办公地址',  N'GLFLX',     N'7'      -- 关联方类型 = 7-境外

        UNION ALL SELECT 4,   N'QYZCLB',   N'企业注册类别',   N'GLFLX',     N'4'      -- 关联方类型 = 4-非金融企业
        UNION ALL SELECT 4,   N'QYZCLB',   N'企业注册类别',   N'GLFLX',     N'5'      -- 关联方类型 = 5-金融机构（实体）
        UNION ALL SELECT 4,   N'QYZCLB',   N'企业注册类别',   N'GLFLX',     N'7'      -- 关联方类型 = 7-境外

        UNION ALL SELECT 4,   N'ZCDQ'  ,   N'注册地区',       N'ZCGB',      N'CHN'      -- 关联方类型 = 7-境外
    --```
GO
