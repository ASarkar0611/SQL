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

-- Question: You want to calculate the total number of legs in the meadow. Given the table creatures, build a new
-- table that only contains one column summary_legs and has only one row with the total number of legs that you can see.

SELECT sum(IF(type='human',2,4)) as summary_legs
    FROM creatures
    ORDER BY id;

-- Question: The combination lock consists of several rotating discs, where each disc has its own set of possible
-- characters. You have a table discs which stores the information about these discs
-- Calculate the total number of all possible combinations that the lock has, and return it as a table that has
-- only one column combinations and one row.

SET @comb = 1;
SELECT max(@comb:= @comb*length(characters)) as combinations
FROM discs;
-- OR
SELECT ROUND(EXP(SUM(LOG(CHAR_LENGTH(characters))))) AS combinations
    FROM discs;

