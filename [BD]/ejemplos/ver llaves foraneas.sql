SELECT 
  TABLE_NAME,COLUMN_NAME,CONSTRAINT_NAME, REFERENCED_TABLE_NAME,REFERENCED_COLUMN_NAME
FROM
  INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
  REFERENCED_TABLE_SCHEMA = 'venta2022b'
    -- TABLE_NAME = 'boletosvendidos'
--   REFERENCED_TABLE_NAME 
--   REFERENCED_COLUMN_NAME = '<column>';

LIMIT 999