-- liberar asiento
-- DELETE from disponibilidadasientos 
-- where id IN (
--     SELECT
--     disa.id
--     FROM `disponibilidadasientos` disa
--     INNER JOIN disponibilidad disp
--     on disa.nDisponibilidad=disp.nNumero
--     WHERE disp.nCorridaDisponible=:nCorrida
--     and disa.nAsiento=:nAsiento
-- )

CREATE OR REPLACE PROCEDURE liberarAsiento(
    IN IN_nCorrida bigint(20),
    IN IN_nAsiento smallint(6)
)
BEGIN
    DELETE from disponibilidadasientos 
    where id IN (
        SELECT
        disa.id
        FROM `disponibilidadasientos` disa
        INNER JOIN disponibilidad disp
        on disa.nDisponibilidad=disp.nNumero
        WHERE disp.nCorridaDisponible=IN_nCorrida
        and disa.nAsiento=IN_nAsiento
    );
END;