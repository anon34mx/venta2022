INSERT INTO `corridasprogramadas`(`nItinerario`, `nTipoServicio`, `hSalida`,
`lLunes`, `lMartes`, `lMiercoles`, `lJueves`, `lViernes`, `lSabado`, `lDomingo`, `fInicio`, `fFin`, `lBaja`)
VALUES
(1,1,'10:00:00',
true,true,true,true,true,false,false,'2022-01-01','2023-06-30',false),
(1,1,'10:01:00',
true,true,true,true,true,false,false,'2022-03-01','2023-06-30',true),
(1,1,'10:30:00',
false,false,false,false,false,true,true,'2022-01-01','2022-06-30',false),
(3,3,'12:00:00',
true,true,true,true,true,true,true,'2022-03-01','2022-12-31',false),
(3,3,'23:30:00',
true,false,false,true,true,true,true,'2022-03-01','2022-12-31',false);


-- ## corridas disponibles
INSERT INTO `corridasdisponibles`(`nNumero`, `nProgramada`, `nItinerario`, `nTipoServicio`, `fSalida`, `hSalida`,
    `aEstado`, `nNumeroAutobus`, `nNumeroConductor`) VALUES
(1,3,3,2,'2022-08-01','12:00:00','AC',1,2),
(2,2,3,2,'2022-08-02','10:30:00','AC',2,1),
(3,3,3,2,'2022-08-08','12:00:00','AC',1,2)

SELECT cordis.nNumero,cordis.nItinerario, itiOri.*
from corridasdisponibles cordis
inner join itinerario as itiOri on cordis.nItinerario=itiOri.nItinerario

-- #####################################################################################################


--                              [CREAR LAS CORRIDAS DISPONIBLES]
-- https://stackoverflow.com/questions/17417385/mysql-set-multiple-variables-from-one-select
-- https://stackoverflow.com/questions/5817395/how-can-i-loop-through-all-rows-of-a-table-mysql
-- https://www.mysqltutorial.org/mysql-error-handling-in-stored-procedures/
-- https://stackoverflow.com/questions/11000802/calling-a-stored-procedure-in-a-stored-procedure-in-mysql
