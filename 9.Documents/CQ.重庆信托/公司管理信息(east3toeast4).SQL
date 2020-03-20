USE EAST3
GO

--2.股东信息
select --GDLX,GDZJLX,KGFS,GDZT,
       CASE  GDLX WHEN '个人'      THEN '1-自然人'
                  WHEN '1'         THEN '1-自然人'
                  WHEN '金融机构'  THEN '5-金融机构（实体）'
                  WHEN '2'         THEN '5-金融机构（实体）'
                  WHEN '非金融机构'THEN '4-非金融企业'
                  WHEN '3'         THEN '4-非金融企业'
                                   ELSE ''
       END               AS GDLX, 
       GDMC              AS GDMC,
        CASE GDLX WHEN '个人'      THEN CASE GDZJLX WHEN  '居民身份证'                THEN '01-居民身份证'
                                                    WHEN '户口簿'                    THEN '03-户口薄'
                                                    WHEN '护照'                      THEN '04-普通护照'
                                                                                        --'05-外交护照'
                                                                                        --'06-公务护照'
                                                                                        --'07-公务普通护照'
                                                    WHEN '军官证'                    THEN '08-中国人民解放军军官证'
                                                    WHEN '士兵证'                    THEN '09-中国人民解放军士兵证'
                                                    WHEN '港澳居民来往内地通行证'    THEN '13-港澳居民来往内地通行证'
                                                                                        --'11-港澳居民居住证'
                                                    WHEN '台湾同胞来往内地通行证'    THEN '14-台湾居民来往大陆通行证'
                                                                                        --'12-台湾居民居住证'
                                                    WHEN '临时身份证'                THEN '02-临时居民身份证'
                                                    WHEN '外国人居留证'              THEN '15-外国人永久居留身份证'
                                                                                        --'16-外国人居留或居留许可'
                                                                                        --'17-外国人临时居留证'
                                                    WHEN '警官证'                    THEN '10-人民警察证'
                                                    WHEN '无证件'                    THEN ''
                                                    WHEN '其他'                      THEN '18-其他个人有效身份证件'
                                        END
                                   ELSE CASE GDZJLX WHEN '统一社会信用代码' THEN '23-社会信用代码'
                                                    WHEN '组织机构代码'    THEN '21-组织机构代码'
                                                    WHEN '金融许可证'      THEN '33-业务许可证'
                                                    WHEN '营业执照号'      THEN '22-营业执照号(工商注册号)'
                                                    WHEN '210801'      THEN '22-营业执照号(工商注册号)'
                                                    WHEN '税务登记号'      THEN '31-登记信息'
                                                    WHEN 'TITOT内部产品'   THEN '99-其他'
                                                    WHEN 'TETOT外部产品'   THEN '99-其他'
                                                    WHEN '其他'           THEN '99-其他'
                                                                            ELSE ''
                                        END
        END             AS GDZJLX,
       GDZJHM            AS GDZJHM,
       ''                AS FDDBR,
       ''                AS GDJYFW,
       CASE KGFS WHEN '绝对控股' THEN '1-绝对控股'
                 WHEN '相对控股' THEN '2-相对控股'
                                ELSE '3-一般持股'
       END AS KGFS,
       CONVERT(FLOAT,CGBL / 100) AS CGBL,
       CASE GDZT WHEN '有效' THEN '1-有效'
                 WHEN '无效' THEN '0-无效'
                 ELSE ''
       END AS GDZT,
       ''               AS JGXZ,
       ''               AS QYZCLB,
       ''               AS HYFL,
       ''               AS HYMX,
       ''               AS GSZCRQ,
       ''               AS ZCZB,
       ''               AS ZCDQ,
       ''               AS ZCDZ,
       ''               AS SJBGDZ,
       ''               AS SJKZRBS,
       ''               AS SJKZRLX,
       ''               AS SJKZRMC,
       ''               AS SJKZRZJLX,
       ''               AS SJKZRZJHM,
       ''               AS ZZSYRMC,
       ''               AS ZZSYRZJLX,
       ''               AS ZZSYRZJHM,
       ''               AS GDZT,
       ''               AS YZXDRBS,
       ''               AS YZXDRZB,
       ''               AS GQSFZY,
       ''               AS GQZYBL,
       ''               AS GQSFDJ,
       ''               AS GQDJBL
    FROM TE300103GDXXB


--2.员工信息
SELECT
YGGH AS YGH,
YGXM AS YGXM,
CASE ZJLX WHEN '居民身份证'                THEN '01-居民身份证'
          WHEN '户口簿'                    THEN '03-户口薄'
          WHEN '护照'                      THEN '04-普通护照'
                                              --'05-外交护照'
                                              --'06-公务护照'
                                              --'07-公务普通护照'
          WHEN '军官证'                    THEN '08-中国人民解放军军官证'
          WHEN '士兵证'                    THEN '09-中国人民解放军士兵证'
          WHEN '港澳居民来往内地通行证'    THEN '13-港澳居民来往内地通行证'
                                              --'11-港澳居民居住证'
          WHEN '台湾同胞来往内地通行证'    THEN '14-台湾居民来往大陆通行证'
                                              --'12-台湾居民居住证'
          WHEN '临时身份证'                THEN '02-临时居民身份证'
          WHEN '外国人居留证'              THEN '15-外国人永久居留身份证'
                                              --'16-外国人居留或居留许可'
                                              --'17-外国人临时居留证'
          WHEN '警官证'                    THEN '10-人民警察证'
          WHEN '无证件'                    THEN ''
          WHEN '其他'                      THEN '18-其他个人有效身份证件'
END  AS YGZJLX,
ZJHM AS ZJHM,
''   AS ZZMM,
ISNULL(LXDH,'') AS LXDH,
ISNULL(SSBM,'') AS SSBM,
''              AS SSBMFL,
ISNULL(ZW  ,'') AS YGZW,
CASE SFGG WHEN '是' THEN '1-是' ELSE '0-否' END AS SSGG,

CASE YGZT WHEN '正式员工在职'     THEN '1-正式员工(默认)'
          WHEN '非正式员工在职'   THEN '2-非正式员工'
          WHEN '正式员工离职'     THEN '1-正式员工(默认)'
          WHEN '非正式员工离职'   THEN '2-非正式员工'
                                  ELSE ''
END AS YGBZ,

CASE YGZT WHEN '正式员工在职'     THEN '2-在职(默认)'
          WHEN '非正式员工在职'   THEN '2-在职(默认)'
          WHEN '正式员工离职'     THEN '3-离职'
          WHEN '非正式员工离职'   THEN '3-离职'
          WHEN '其他'             THEN '7-其他'
END AS YGZT,
'' AS RZRQ,
'' AS LZRQ,
'' AS BGDQ,
'' AS GWMC,
'' AS GWMS

FROM  TE300102YGXXB

--关联方 
--A.1.1信托客户（自然人）
SELECT 
''           AS GLFBH          ,  -- 关联方编号          
'1-自然人'    AS GLFLX          ,  -- 关联方类型(2003)    
''           AS GLLX           ,  -- 关联类型(2015)      
KHQC         AS GLFMC          ,  -- 关联方名称          
CASE ZJLX WHEN '居民身份证'                THEN '01-居民身份证'
          WHEN '身份证'                   THEN '01-居民身份证'
          WHEN '户口簿'                    THEN '03-户口薄'
          WHEN '护照'                      THEN '04-普通护照'
                                              --'05-外交护照'
                                              --'06-公务护照'
                                              --'07-公务普通护照'
          WHEN '军官证'                    THEN '08-中国人民解放军军官证'
          WHEN '士兵证'                    THEN '09-中国人民解放军士兵证'
          WHEN '港澳居民来往内地通行证'    THEN '13-港澳居民来往内地通行证'
                                              --'11-港澳居民居住证'
          WHEN '台湾同胞来往内地通行证'    THEN '14-台湾居民来往大陆通行证'
                                              --'12-台湾居民居住证'
          WHEN '临时身份证'                THEN '02-临时居民身份证'
          WHEN '外国人居留证'              THEN '15-外国人永久居留身份证'
                                              --'16-外国人居留或居留许可'
                                              --'17-外国人临时居留证'
          WHEN '警官证'                    THEN '10-人民警察证'
          WHEN '无证件'                    THEN ''
          WHEN '其他'                      THEN '18-其他个人有效身份证件'
END          AS GLFZJLX        ,  -- 关联方证件类型 (2004)
ZJHM         AS GLFZJHM        ,  -- 关联方证件号码  必填
''           AS GLFJYFW        ,  -- 关联方业务或经营范围
''           AS HYFL           ,  -- 行业分类 (2008)     
''           AS HYMX           ,  -- 行业明细 (1002)     
''           AS QYZCLB         ,  -- 企业注册类别 (2007) 
''           AS GSZCRQ         ,  -- 工商注册日期        
''           AS ZCZB           ,  -- 注册资本            
''           AS ZCDQ           ,  -- 注册地区 (1001)     
''           AS ZCDZ           ,  -- 注册地址            
''           AS SJBGDZ            -- 实际办公地址     
FROM TE300301XTKHGR WHERE isnull(GLLX,'') not in('无','')
UNION ALL
--A.1.2信托客户（机构）
SELECT 
''           AS GLFBH          ,  -- 关联方编号  
CASE KHLX WHEN '银行'               THEN '5-金融机构（实体）'
          WHEN '证券公司'            THEN '5-金融机构（实体）'
          WHEN '基金公司或基金子公司'  THEN '5-金融机构（实体）'
          WHEN '保险公司'            THEN '5-金融机构（实体）'
          WHEN '信托公司'            THEN '5-金融机构（实体）'
          WHEN '其他金融机构'        THEN '5-金融机构（实体）'
          WHEN '普通法人机构'        THEN '4-非金融企业'
          WHEN '普通非法人机构'       THEN '4-非金融企业'
          WHEN '政府类'             THEN '3-广义政府'
          WHEN '合伙人'             THEN '4-非金融企业'
          WHEN '私募基金管理人'       THEN '6-特定目的载体'
          WHEN '其他'               THEN ''
END          GLFLX          ,  -- 关联方类型(2003)    
''           AS GLLX           ,  -- 关联类型(2015)      
KHQC        AS GLFMC          ,  -- 关联方名称      

CASE ZJLX WHEN '统一社会信用代码' THEN '23-社会信用代码'
          WHEN '组织机构代码'    THEN '21-组织机构代码'
          WHEN '金融许可证'      THEN '33-业务许可证'
          WHEN '营业执照号'      THEN '22-营业执照号(工商注册号)'
          WHEN '营业执照'      THEN '22-营业执照号(工商注册号)'
          WHEN '税务登记号'      THEN '31-登记信息'
          WHEN 'TITOT内部产品'   THEN '99-其他'
          WHEN 'TETOT外部产品'   THEN '99-其他'
          WHEN '其他'           THEN '99-其他'
                               ELSE ''
END          AS GLFZJLX        ,  -- 关联方证件类型 (2004)
ZJHM         AS GLFZJHM        ,  -- 关联方证件号码  必填
''           AS GLFJYFW        ,  -- 关联方业务或经营范围
''           AS HYFL           ,  -- 行业分类 (2008)     
''           AS HYMX           ,  -- 行业明细 (1002)     
''           AS QYZCLB         ,  -- 企业注册类别 (2007) 
''           AS GSZCRQ         ,  -- 工商注册日期        
''           AS ZCZB           ,  -- 注册资本            
''           AS ZCDQ           ,  -- 注册地区 (1001)     
''           AS ZCDZ           ,  -- 注册地址            
''           AS SJBGDZ            -- 实际办公地址     
FROM TE300302XTKHJG WHERE isnull(GlLX,'') not in('无','')


UNION ALL
--A.2.1交易对手（自然人）
SELECT 
''           AS GLFBH          ,  -- 关联方编号          
'1-自然人'    AS GLFLX          ,  -- 关联方类型(2003)    
''           AS GLLX           ,  -- 关联类型(2015)      
SYRQC        AS GLFMC          ,  -- 关联方名称          
CASE ZJLX WHEN '居民身份证'                THEN '01-居民身份证'
          WHEN '户口簿'                    THEN '03-户口薄'
          WHEN '护照'                      THEN '04-普通护照'
                                              --'05-外交护照'
                                              --'06-公务护照'
                                              --'07-公务普通护照'
          WHEN '军官证'                    THEN '08-中国人民解放军军官证'
          WHEN '士兵证'                    THEN '09-中国人民解放军士兵证'
          WHEN '港澳居民来往内地通行证'    THEN '13-港澳居民来往内地通行证'
                                              --'11-港澳居民居住证'
          WHEN '台湾同胞来往内地通行证'    THEN '14-台湾居民来往大陆通行证'
                                              --'12-台湾居民居住证'
          WHEN '临时身份证'                THEN '02-临时居民身份证'
          WHEN '外国人居留证'              THEN '15-外国人永久居留身份证'
                                              --'16-外国人居留或居留许可'
                                              --'17-外国人临时居留证'
          WHEN '警官证'                    THEN '10-人民警察证'
          WHEN '无证件'                    THEN ''
          WHEN '其他'                      THEN '18-其他个人有效身份证件'
END          AS GLFZJLX        ,  -- 关联方证件类型 (2004)
ZJHM         AS GLFZJHM        ,  -- 关联方证件号码  必填
''           AS GLFJYFW        ,  -- 关联方业务或经营范围
''           AS HYFL           ,  -- 行业分类 (2008)     
''           AS HYMX           ,  -- 行业明细 (1002)     
''           AS QYZCLB         ,  -- 企业注册类别 (2007) 
''           AS GSZCRQ         ,  -- 工商注册日期        
''           AS ZCZB           ,  -- 注册资本            
''           AS ZCDQ           ,  -- 注册地区 (1001)     
''           AS ZCDZ           ,  -- 注册地址            
''           AS SJBGDZ            -- 实际办公地址     
FROM TE300303JYDSGR WHERE isnull(GXLX,'') not in('无','')

UNION ALL
--A.2.2交易对手（机构）
SELECT 
''           AS GLFBH          ,  -- 关联方编号  
CASE XHLB WHEN '银行'               THEN '5-金融机构（实体）'
          WHEN '证券公司'            THEN '5-金融机构（实体）'
          WHEN '基金公司或基金子公司'  THEN '5-金融机构（实体）'
          WHEN '保险公司'            THEN '5-金融机构（实体）'
          WHEN '信托公司'            THEN '5-金融机构（实体）'
          WHEN '其他金融机构'        THEN '5-金融机构（实体）'
          WHEN '普通法人机构'        THEN '4-非金融企业'
          WHEN '普通非法人机构'       THEN '4-非金融企业'
          WHEN '政府类'             THEN '3-广义政府'
          WHEN '合伙人'             THEN '4-非金融企业'
          WHEN '私募基金管理人'       THEN '6-特定目的载体'
          WHEN '其他'               THEN ''
END          AS GLFLX          ,  -- 关联方类型(2003)    
''           AS GLLX           ,  -- 关联类型(2015)      
JYDSQC       AS GLFMC          ,  -- 关联方名称          
CASE ZJLX WHEN '统一社会信用代码' THEN '23-社会信用代码'
          WHEN '组织机构代码'    THEN '21-组织机构代码'
          WHEN '金融许可证'      THEN '33-业务许可证'
          WHEN '营业执照号'      THEN '22-营业执照号(工商注册号)'
          WHEN '税务登记号'      THEN '31-登记信息'
          WHEN 'TITOT内部产品'   THEN '99-其他'
          WHEN 'TETOT外部产品'   THEN '99-其他'
          WHEN '其他'           THEN '99-其他'
END          AS GLFZJLX        ,  -- 关联方证件类型 (2004)
ZJHM         AS GLFZJHM        ,  -- 关联方证件号码  必填
''           AS GLFJYFW        ,  -- 关联方业务或经营范围
CASE HYFL 
WHEN '基础产业' THEN '1-基础产业'
WHEN '房地产'  THEN '2-房地产'
WHEN '证券'    THEN '3-证券'
WHEN '金融机构' THEN '4-金融机构'
WHEN '工商企业' THEN '5-工商企业'
WHEN '其他'    THEN '6-其他'
               ELSE ''
END          AS HYFL           ,  -- 行业分类 (2008)     
''           AS HYMX           ,  -- 行业明细 (1002)     
''           AS QYZCLB         ,  -- 企业注册类别 (2007) 
''           AS GSZCRQ         ,  -- 工商注册日期        
''           AS ZCZB           ,  -- 注册资本            
''           AS ZCDQ           ,  -- 注册地区 (1001)     
''           AS ZCDZ           ,  -- 注册地址            
''           AS SJBGDZ            -- 实际办公地址     
FROM TE300304JYDSJG WHERE isnull(GlLX,'') not in('无','')



--SELECT * FROM TE300301XTKHGR WHERE isnull(GLLX,'') not in('无','')
--SELECT * FROM TE300302XTKHJG WHERE isnull(GLLX,'') not in('无','')
--SELECT * FROM TE300303JYDSGR WHERE isnull(GXLX,'') not in('无','','0')
--SELECT * FROM TE300304JYDSJG WHERE isnull(GLLX,'') not in('无','')


