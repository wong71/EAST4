IF EXISTS(SELECT 1 FROM  sysobjects WHERE name = 'SP_CHECK_TA01JGXXB')
    DROP PROCEDURE SP_CHECK_TA01JGXXB
GO

CREATE PROCEDURE SP_CHECK_TA01JGXXB @IN_ID          NVARCHAR(MAX),
                                    @IN_CHECK_FLAG  INTEGER     --1.审核不通过 2.审核通过
WITH ENCRYPTION
AS
    DECLARE @V_CURRENT_MONTH INTEGER
    DECLARE @V_CHECK_FLAG INTEGER,@V_INSERT_MONTH INTEGER,@V_SYNC_STATUS INT
    DECLARE @VT TABLE(ID            INTEGER,
                      CHECK_FLAG    INTEGER)

    BEGIN TRY


    INSERT INTO @VT(ID,CHECK_FLAG)
    SELECT B.ID,B.CHECK_FLAG
        FROM dbo.F_SPLIT(@IN_ID,',') A INNER JOIN TA01JGXXB B ON A.VALUE = B.ID
        WHERE B.CHECK_FLAG = 1



    SELECT @V_CURRENT_MONTH = CURRENT_MONTH FROM TESYSTEMINFO


    BEGIN TRANSACTION


    IF @IN_CHECK_FLAG = 2 BEGIN
        --2.审核通过
        --处理当期（月）有已变动审核过的记录
        UPDATE EAST4History..HA01JGXXB
            SET XTJGMC       = B.XTJGMC      ,
                XTJGJRXKZDM  = B.XTJGJRXKZDM ,
                TYSHXYDM     = B.TYSHXYDM    ,
                XTGSJYFW     = B.XTGSJYFW    ,
                ZCZB         = B.ZCZB        ,
                ZCDQ         = B.ZCDQ        ,
                ZCDZ         = B.ZCDZ        ,
                SJBGDZ       = B.SJBGDZ      ,
                FDDBR        = B.FDDBR       ,
                SJKZRBS      = B.SJKZRBS     ,
                SJKZRLX      = B.SJKZRLX     ,
                SJKZRMC      = B.SJKZRMC     ,
                SJKZRZJLX    = B.SJKZRZJLX   ,
                SJKZRZJHM    = B.SJKZRZJHM   ,
                GSZCRQ       = B.GSZCRQ      ,
                INSERT_MONTH = B.INSERT_MONTH,
                SYNC_MONTH   = B.SYNC_MONTH  ,
                SYNC_STATUS  = B.SYNC_STATUS  
            FROM EAST4History..HA01JGXXB A INNER JOIN TA01JGXXB B ON A.ID = B.ID AND A.SYNC_MONTH = @V_CURRENT_MONTH
                                           INNER JOIN @VT       C ON B.ID = C.ID
        --处理当期首次审核的记录
        INSERT INTO EAST4History..HA01JGXXB(ID,XTJGMC,XTJGJRXKZDM,TYSHXYDM,XTGSJYFW,ZCZB,ZCDQ,ZCDZ,SJBGDZ,FDDBR,
                                            SJKZRBS,SJKZRLX,SJKZRMC,SJKZRZJLX,SJKZRZJHM,GSZCRQ,
                                            INSERT_MONTH,SYNC_MONTH,
                                            SYNC_STATUS)
            SELECT A.ID,A.XTJGMC,A.XTJGJRXKZDM,A.TYSHXYDM,A.XTGSJYFW,A.ZCZB,A.ZCDQ,A.ZCDZ,A.SJBGDZ,A.FDDBR,
                   A.A.SJKZRBS,A.SJKZRLX,A.SJKZRMC,A.SJKZRZJLX,A.SJKZRZJHM,A.GSZCRQ,
                   CASE A.SYNC_STATUS WHEN 1 THEN A.INSERT_MONTH ELSE @V_CURRENT_MONTH END,
                   @V_CURRENT_MONTH,
                   A.SYNC_STATUS
                FROM TA01JGXXB A INNER JOIN @VT                     T ON A.ID = T.ID
                                 LEFT  JOIN EAST4History..HA01JGXXB B ON A.ID = B.ID AND B.SYNC_MONTH = @V_CURRENT_MONTH
                WHERE B.ID IS NULL

        UPDATE TA01JGXXB
            SET CHECK_FLAG   = 2,
                CHECK_TIME   = GETDATE(),
                SYNC_MONTH   = @V_CURRENT_MONTH,
                INSERT_MONTH = CASE A.SYNC_STATUS WHEN 1 THEN A.INSERT_MONTH ELSE @V_CURRENT_MONTH END
            FROM TA01JGXXB A INNER JOIN @VT T ON A.ID = T.ID

    END 
    ELSE BEGIN
        --1审核不通过，恢复原来的数据
        UPDATE TA01JGXXB
            SET XTJGMC       = B.XTJGMC      ,
                XTJGJRXKZDM  = B.XTJGJRXKZDM ,
                TYSHXYDM     = B.TYSHXYDM    ,
                XTGSJYFW     = B.XTGSJYFW    ,
                ZCZB         = B.ZCZB        ,
                ZCDQ         = B.ZCDQ        ,
                ZCDZ         = B.ZCDZ        ,
                SJBGDZ       = B.SJBGDZ      ,
                FDDBR        = B.FDDBR       ,
                SJKZRBS      = B.SJKZRBS     ,
                SJKZRLX      = B.SJKZRLX     ,
                SJKZRMC      = B.SJKZRMC     ,
                SJKZRZJLX    = B.SJKZRZJLX   ,
                SJKZRZJHM    = B.SJKZRZJHM   ,
                GSZCRQ       = B.GSZCRQ      ,
              --INSERT_MONTH = B.INSERT_MONTH,
              --SYNC_MONTH   = B.SYNC_MONTH  ,
                SYNC_STATUS  = B.SYNC_STATUS ,
                CHECK_FLAG   = 2             ,
                CHECK_TIME   = B.CHECK_FLAG
            FROM TA01JGXXB A  INNER JOIN @VT                     T ON A.ID = T.ID
                              INNER JOIN EAST4History..HA01JGXXB B ON A.ID = B.ID AND B.SYNC_MONTH = A.SYNC_MONTH
    END

    COMMIT TRANSACTION

    END TRY


    BEGIN CATCH 
        
        IF @@TRANCOUNT > 0 BEGIN
            ROLLBACK TRANSACTION
        END
        
        DECLARE @V_ERROR_STR NVARCHAR(1000),@V_ERROR_NUMBER INT,@V_ERROR_SEVERITY INT,@V_ERROR_STATE INT,
                @V_ERROR_PROCEDURE sysname,@V_ERROR_LINE INT,@V_ERROR_MESSAGE NVARCHAR(4000)

        SELECT @V_ERROR_STR = 'Message:%s', --N'Message:%s,Procedure:%s,Line:%d',
               @V_ERROR_NUMBER = ERROR_NUMBER(),
               @V_ERROR_SEVERITY = ERROR_SEVERITY(),
               @V_ERROR_STATE = ERROR_STATE(),
               @V_ERROR_PROCEDURE = ERROR_PROCEDURE(),
               @V_ERROR_LINE = ERROR_LINE(),
               @V_ERROR_MESSAGE = ERROR_MESSAGE()

        --RAISERROR(@V_ERROR_STR,@V_ERROR_SEVERITY,1,@V_ERROR_MESSAGE,@V_ERROR_PROCEDURE,@V_ERROR_LINE)
        RAISERROR(@V_ERROR_STR,@V_ERROR_SEVERITY,1,@V_ERROR_MESSAGE)
        RETURN -100


    END CATCH



GO
