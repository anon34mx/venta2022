/*

FUNCIONA
CREATE OR REPLACE FUNCTION refrescar_asientos(IN_asientos text)
RETURNS TEXT
BEGIN
    DECLARE retorno INT DEFAULT 0;
    DECLARE vr_encontrados INT UNSIGNED;

    DECLARE vr_idAsiento INT;
    
    SET IN_asientos=CONCAT(IN_asientos, ",");

    WHILE (LOCATE(',',IN_asientos))DO
        SET vr_idAsiento = SUBSTRING(IN_asientos, 1, LOCATE(',',IN_asientos)); -- numero 1
        SET IN_asientos=SUBSTRING(IN_asientos, LOCATE(',',IN_asientos)+1);
        
        SELECT nAsiento into vr_encontrados
        FROM `disponibilidadasientos` as disa where disa.id=vr_idAsiento;
        IF vr_encontrados IS NOT NULL THEN
            SET retorno=retorno+1;
            UPDATE `disponibilidadasientos` SET last_update=now() WHERE id=vr_idAsiento;
        END IF;
    END WHILE;
RETURN retorno;
END;
*/
-- update `disponibilidadasientos` SET last_update='2025-01-16 15:28:51' WHERE id IN(13,14,15,16,17,18,19,20,21,22,23,24);
CREATE OR REPLACE FUNCTION refrescar_asientos(IN_asientos text, IN_vigencia datetime)
RETURNS TEXT
BEGIN
    DECLARE retorno INT DEFAULT 0;
    DECLARE vr_encontrados INT UNSIGNED;

    DECLARE vr_idAsiento INT;
    
    SET IN_asientos=CONCAT(IN_asientos, ",");
    
    WHILE (LOCATE(',',IN_asientos))DO
        SET vr_idAsiento = SUBSTRING(IN_asientos, 1, LOCATE(',',IN_asientos)); -- numero 1
        SET IN_asientos=SUBSTRING(IN_asientos, LOCATE(',',IN_asientos)+1);
        
        SELECT nAsiento into vr_encontrados
        FROM `disponibilidadasientos` as disa where disa.id=vr_idAsiento;
        IF vr_encontrados IS NOT NULL THEN
            IF IN_vigencia IS NULL THEN
                UPDATE `disponibilidadasientos` SET last_update=now() WHERE id=vr_idAsiento;
            ELSE
                UPDATE `disponibilidadasientos` SET
                    last_update=(SELECT DATE_ADD(IN_vigencia, INTERVAL 2 DAY)) WHERE id=vr_idAsiento;
            END IF;
            SET retorno=retorno+1;
        END IF;
    END WHILE;
RETURN retorno;
END;