USE EAST4
GO

-- # 1.F_SPLIT 
--> - 将指定分隔符的字符串 转为二维表返回
-- ```sql
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[F_SPLIT]') and xtype in (N'FN', N'IF', N'TF'))
    drop function [dbo].[F_SPLIT]
GO
CREATE FUNCTION F_SPLIT(@IN_STR NVARCHAR(MAX)       ,   --需要处理的字符串
                        @IN_SPL NVARCHAR(2)     =',' )    --分隔符
RETURNS @TABLE TABLE
(
    ID      INTEGER IDENTITY(1,1),
    VALUE   NVARCHAR(MAX)
)
AS
BEGIN
    /*SET @IN_STR = '<ROOT><DATA><TEXT>' + REPLACE(@IN_STR,@IN_SPL,'</EMAIL></DATA><DATA><TEXT>') + '</TEXT></DATA></ROOT>'  
    EXEC SP_XML_PREPAREDOCUMENT @XMLID OUTPUT, @IN_STR  
    INSERT INTO @TABLE TABLE(TEXTSTR)
        SELECT * FROM OPENXML(@XMLID, '/ROOT/DATA', 2) WITH(EMAIL VARCHAR(50) 'TEXT')  
    EXEC SP_XML_REMOVEDOCUMENT @XMLID  */

    DECLARE @XML XML  
    SET @XML = CAST('<TEXT>' + REPLACE(@IN_STR,@IN_SPL,'</TEXT><TEXT>')+'</TEXT>' AS XML)  
    INSERT INTO @TABLE (VALUE)
        SELECT T.I.value('.', 'VARCHAR(max)') 
            FROM @XML.nodes('TEXT') T(I)
            WHERE T.I.value('.', 'VARCHAR(max)') <> ''

RETURN
END
GO
--```

-- # 2.GET_TYPE_CONTENT 
--> - 根据字典编号 及 码值 取得 实际名称
-- ```sql
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GET_TYPE_CONTENT]') and xtype in (N'FN', N'IF', N'TF'))
    drop function [dbo].[GET_TYPE_CONTENT]
GO
CREATE FUNCTION dbo.GET_TYPE_CONTENT(@V_TYPE_ID NVARCHAR(10),@V_TYPE_VALUE NVARCHAR(100)
) RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @V_TYPE_CONTENT NVARCHAR(100)
    SELECT @V_TYPE_CONTENT=TYPE_CONTENT FROM TEDICTPARAM WHERE TYPE_ID = @V_TYPE_ID AND TYPE_VALUE = @V_TYPE_VALUE
  
    RETURN @V_TYPE_CONTENT
END
GO
--```