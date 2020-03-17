IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'SP_QUERY_VERIFY_DATA') 
    DROP PROCEDURE SP_QUERY_VERIFY_DATA
GO

CREATE PROCEDURE SP_QUERY_VERIFY_DATA @IN_REPORT_ID       INTEGER,
                                      @IN_TABLE_SN        NVARCHAR(MAX)
    
WITH ENCRYPTION
AS
    DECLARE @V_SQL_STATEMENT NVARCHAR(MAX),@V_SQL_STATEMENT2 NVARCHAR(MAX),@V_SQL_STATEMENT3 NVARCHAR(MAX),
            @V_SQL_STRUC NVARCHAR(MAX),@V_SQL_FIELD_LIST NVARCHAR(MAX)
    DECLARE @V_TABLE_NAME NVARCHAR(512)
    
    SELECT @V_TABLE_NAME = TABLE_NAME FROM TEREPORT WHERE REPORT_ID = @IN_REPORT_ID
    
    --1.根据配置生校对语句
    SELECT @V_SQL_STATEMENT = STUFF((
            SELECT ','  + 
                CASE A.VERIFY_FLAG 
                    WHEN 1 THEN
                        CASE DATA_METHOD WHEN '01' THEN  CASE DATA_TYPE WHEN 'D' THEN 'CASE WHEN        ' + A.FIELD_CODE + ' IS NULL       THEN  1  END  AS ' + A.FIELD_CODE
                                                                        WHEN 'I' THEN 'CASE WHEN        ' + A.FIELD_CODE + ' IS NULL       THEN  1  END  AS ' + A.FIELD_CODE
                                                                                 ELSE 'CASE WHEN ISNULL('  + A.FIELD_CODE + ','''') = '''' THEN  1  END  AS ' + A.FIELD_CODE
                                                         END  
                                         WHEN '02' THEN  CASE DATA_REF WHEN '1002' THEN 'CASE WHEN NOT EXISTS(SELECT 1 FROM TINDUSTRYCATEGORY WHERE TYPE_CODE = ' + A.FIELD_CODE + ' ) THEN  1  END AS '   + A.FIELD_CODE 
                                                                                   ELSE 'CASE WHEN NOT EXISTS(SELECT 1 FROM TEDICTPARAM       WHERE TYPE_ID   = ' + CONVERT(NVARCHAR,DATA_REF) + ' AND ' + A.FIELD_CODE + ' =  TYPE_CONTENT) THEN 1 END AS ' + A.FIELD_CODE 
                                                         END
                        END 
                    ELSE 
                        CASE DATA_METHOD WHEN '01' THEN  CASE DATA_TYPE WHEN 'D' THEN ' CASE WHEN ' + A.REF_FIELD_CODE + ' IN(' + STUFF((SELECT ',' + '''' + V.REF_FIELD_VALUE + '''' FROM TEREPORTFIELDVERIFY V WHERE V.REPORT_ID = A.REPORT_ID AND V.FIELD_CODE = A.FIELD_CODE FOR XML PATH('') ),1,1,'') + ') THEN  CASE WHEN        ' + FIELD_CODE + ' IS NULL      THEN  1  END END AS ' + FIELD_CODE
                                                                        WHEN 'I' THEN ' CASE WHEN ' + A.REF_FIELD_CODE + ' IN(' + STUFF((SELECT ',' + '''' + V.REF_FIELD_VALUE + '''' FROM TEREPORTFIELDVERIFY V WHERE V.REPORT_ID = A.REPORT_ID AND V.FIELD_CODE = A.FIELD_CODE FOR XML PATH('') ),1,1,'') + ') THEN  CASE WHEN        ' + FIELD_CODE + ' IS NULL      THEN  1  END END AS ' + FIELD_CODE
                                                                                 ELSE ' CASE WHEN ' + A.REF_FIELD_CODE + ' IN(' + STUFF((SELECT ',' + '''' + V.REF_FIELD_VALUE + '''' FROM TEREPORTFIELDVERIFY V WHERE V.REPORT_ID = A.REPORT_ID AND V.FIELD_CODE = A.FIELD_CODE FOR XML PATH('') ),1,1,'') + ') THEN  CASE WHEN ISNULL(' + FIELD_CODE + ','''') = '''' THEN  1  END END AS ' + FIELD_CODE
                                                         END
                                         WHEN '02' THEN  CASE DATA_REF WHEN '1002' THEN ' CASE WHEN ' + A.REF_FIELD_CODE + ' IN(' + STUFF((SELECT ',' + '''' + V.REF_FIELD_VALUE + '''' FROM TEREPORTFIELDVERIFY V WHERE V.REPORT_ID = A.REPORT_ID AND V.FIELD_CODE = A.FIELD_CODE FOR XML PATH('') ),1,1,'') + ') THEN CASE WHEN NOT EXISTS(SELECT 1 FROM TINDUSTRYCATEGORY WHERE TYPE_CODE = ' + FIELD_CODE + ' ) THEN  1  END END AS ' + FIELD_CODE 
                                                                                     ELSE ' CASE WHEN ' + A.REF_FIELD_CODE + ' IN(' + STUFF((SELECT ',' + '''' + V.REF_FIELD_VALUE + '''' FROM TEREPORTFIELDVERIFY V WHERE V.REPORT_ID = A.REPORT_ID AND V.FIELD_CODE = A.FIELD_CODE FOR XML PATH('') ),1,1,'') + ') THEN CASE WHEN NOT EXISTS(SELECT 1 FROM TEDICTPARAM       WHERE TYPE_ID   = ' + CONVERT(NVARCHAR,DATA_REF) + ' AND ' + FIELD_CODE + ' =  TYPE_CONTENT) THEN 1 END END AS ' + FIELD_CODE 
                                         END
                        END 

                END

                FROM TEREPORTFIELD A 
                WHERE REPORT_ID = @IN_REPORT_ID AND VERIFY_FLAG != 0
                ORDER BY SERIAL_NO
                FOR XML PATH('')),1,1,'')
            

    

    SELECT @V_SQL_STATEMENT2 = STUFF((
        SELECT '+  ISNULL(' + FIELD_CODE + ',0) '
            FROM TEREPORTFIELD A
            WHERE REPORT_ID = @IN_REPORT_ID AND VERIFY_FLAG != 0
            ORDER BY SERIAL_NO
        FOR XML PATH('')),1,1,'')
    ------------------------------------

    --动态创建临时表
    CREATE TABLE #TVERIFY(ID     INTEGER)
    SELECT @V_SQL_STRUC = STUFF((
        SELECT ', ' + FIELD_CODE + ' INTEGER '  FROM TEREPORTFIELD
            WHERE REPORT_ID = @IN_REPORT_ID AND VERIFY_FLAG != 0
            ORDER BY SERIAL_NO
        FOR XML PATH('')),1,1,'')
    SELECT @V_SQL_FIELD_LIST= STUFF((
        SELECT ', ' + FIELD_CODE  FROM TEREPORTFIELD
            WHERE REPORT_ID = @IN_REPORT_ID AND VERIFY_FLAG != 0
            ORDER BY SERIAL_NO
        FOR XML PATH('')),1,1,'')
    SELECT @V_SQL_STRUC = 'ALTER TABLE #TVERIFY ADD ' + @V_SQL_STRUC
    EXEC SP_EXECUTESQL @V_SQL_STRUC

    --SELECT * FROM  #TVERIFY
    ------------------------------------

    CREATE TABLE #TABLESN(ID  INTEGER)


    IF ISNULL(@IN_TABLE_SN,'0') = '0'
        SELECT @V_SQL_STATEMENT  = 'INSERT INTO #TVERIFY (ID,' + @V_SQL_FIELD_LIST + ') SELECT ID, ' + @V_SQL_STATEMENT + ' FROM ' + @V_TABLE_NAME
    ELSE BEGIN
        INSERT INTO #TABLESN(ID)
            SELECT TEXTSTR FROM dbo.F_SPLIT1(@IN_TABLE_SN,',')
        SELECT @V_SQL_STATEMENT  = 'INSERT INTO #TVERIFY (ID,' + @V_SQL_FIELD_LIST + ') SELECT ID, ' + @V_SQL_STATEMENT + ' FROM ' + @V_TABLE_NAME + ' A INNER JOIN  #TABLESN B ON A.ID = B.ID '
    END
    
    EXEC SP_EXECUTESQL @V_SQL_STATEMENT

    SELECT @V_SQL_STATEMENT2 = STUFF((SELECT 'UNION ALL SELECT ' + ' ID,'''+  FIELD_CODE + ''' AS  FIELD_NAME FROM #TVERIFY WHERE ISNULL(' + FIELD_CODE + ',0) != 0 '
                                        FROM TEREPORTFIELD WITH(NOLOCK)
                                        WHERE REPORT_ID = @IN_REPORT_ID  AND VERIFY_FLAG != 0
                                        FOR XML PATH('')),
                                    1,10,'')
    
    EXEC SP_EXECUTESQL @V_SQL_STATEMENT2
GO
