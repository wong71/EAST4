USE EAST4
GO

-- # 1.F_SPLIT 
--> - ��ָ���ָ������ַ��� תΪ��ά������
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[F_SPLIT]') and xtype in (N'FN', N'IF', N'TF'))
    drop function [dbo].[F_SPLIT]
GO
CREATE FUNCTION F_SPLIT(@IN_STR NVARCHAR(MAX)       ,   --��Ҫ�������ַ���
                        @IN_SPL NVARCHAR(2)     =',' )    --�ָ���
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