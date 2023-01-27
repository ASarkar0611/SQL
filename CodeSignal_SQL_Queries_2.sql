-- Question: The query you have access to gathers some information about the users who have the "user" type.
-- You don't want to get caught, so you want to carefully update it so that the query will return the records of
-- all existing types.

SELECT id,login,name
    FROM users
    WHERE type='user'
    OR type NOT IN ('user')
    ORDER BY id

-- Question: He used the following values to indicate NULL:
-- NULL: just a regular NULL value;
-- '<spaces>NULL<spaces>': NULL as a case insensitive (i.e. NuLl is also OK) string with an arbitrary number of
-- spaces at the beginning and at the end;
-- '<spaces>nil<spaces>': nil as a case insensitive (i.e. niL is also OK) string with an arbitrary number of spaces
-- at the beginning and at the end;
-- '<spaces>-<spaces>': a single dash with an arbitrary number of spaces at the beginning and at the end.
-- Given the departments table, compose the resulting table with the single column number_of_nulls containing a
-- single value: the number of rows in the departments table that are supposed to have NULL in the description.

SELECT count(*) AS number_of_nulls FROM departments
	WHERE trim(description) IN ('null', 'nil', '-') OR description IS NULL;