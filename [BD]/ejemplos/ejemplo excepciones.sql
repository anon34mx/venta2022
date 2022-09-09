    -- IF IN_nVenta = 0 THEN
    --     SIGNAL SQLSTATE '45000' -- declarar el codigo de error
    --     SET MESSAGE_TEXT = 'Valió shit, compa', -- declarar mensaje de error
    --         MYSQL_ERRNO  = 1000;
    -- ELSE
    --     SET retorno="OK";
    -- END IF;

CREATE OR REPLACE FUNCTION exceptionTest(IN_val BOOLEAN)
RETURNS TEXT
BEGIN
    DECLARE specialty CONDITION FOR SQLSTATE '45000'; -- es como declarar una excepcion

    IF IN_val = 1 THEN
        SIGNAL SQLSTATE '45000' -- declarar el codigo de error
        SET MESSAGE_TEXT = 'this is fucked up', -- declarar mensaje de error
            MYSQL_ERRNO  = 1000;
    END IF;
    RETURN "success";
END;