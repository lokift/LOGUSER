
  CREATE OR REPLACE EDITIONABLE FUNCTION "LOGUSER"."GET_ENV" (in_name IN VARCHAR2) RETURN VARCHAR2 IS
  l_result env.env_value%TYPE;
BEGIN
  SELECT t.env_value
    INTO l_result
    FROM env t
   WHERE t.env_name = in_name;
  RETURN l_result;
EXCEPTION
  WHEN no_data_found THEN
    RETURN NULL;
END get_env;
