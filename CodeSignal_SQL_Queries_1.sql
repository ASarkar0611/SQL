-- Question: gradeDistribution
-- As a Teaching Assistant (TA), you need to query the name and id of all the students whose best grade comes from 
-- Option 3, sorted based on the first 3 characters of their name. If the first 3 characters of two names are the same, 
-- then the student with the lower ID value comes first.

-- Answer:
select name, id from (select *, ((0.25*midterm1)+(0.25*midterm2)+(0.5*final)) option1,
	((0.5*midterm1)+(0.5*midterm2)) option2, final as option3 from grades) tbl
	where option3 > option1 and option3 > option2
	order by substring(name, 1, 3), id;
-------------------------------------------------------------------------------------------------------------------------

-- Question: mischievousNephews
-- The resulting table should contain four columns, weekday, mischief_date, author, and title, where weekday is
-- the weekday of mischief_date (0 for Monday, 1 for Tuesday, and so on, with 6 for Sunday). The table should be
-- sorted by the weekday column, and for each weekday Huey's mischief should go first, Dewey's should go next,
-- and Louie's should go last. In case of a tie, mischief_date should be a tie-breaker. If there's still a tie,
-- the record with the lexicographically smallest title should go first.

-- Answer:
select weekday(mischief_date) as weekday, mischief_date, author, title from mischief order by weekday,
	field(author, "Huey", "Dewey", "Louie"),
	mischief_date, title asc;
-------------------------------------------------------------------------------------------------------------------------

-- Question:
-- To make the list of suspects smaller, you would like to filter out the suspects who can't possibly be guilty
-- according to the information obtained from the clues. For each remaining suspect, you want to save his/her id,
-- name and surname. Please note that the information obtained from the clue should be considered case-insensitive,
-- so for example "bill Green", and "Bill green", and "Bill Green" should all be included in the new table.
-- Given the table Suspect, build the resulting table as follows: the table should have columns id, name and
-- surname and its values should be ordered by the suspects' ids in ascending order.

-- Answer:
select id, name, surname from suspect where height <= 170 and name like 'B%'
	and upper(surname) like 'GRE_N';
-------------------------------------------------------------------------------------------------------------------------

-- Question:
-- Given the table Suspect, build the resulting table as follows: the table should have columns id, name and
-- surname and its values should be ordered by the suspects' ids in ascending order.

-- Answer:
select id, name, surname
	from suspect
	where height <= 170
	or upper(name) NOT LIKE 'B%'
	or upper(surname) NOT LIKE 'GRE_N'
	order by id;
---------------------------------------------------------------------------------------------------------------------

-- Question: securityBreach
-- After analyzing the server logs today you found out that the website security has been breached and the
-- data of some of your users might have been compromised.

-- Answer:
SELECT first_name, second_name, attribute
	FROM users u
	WHERE attribute LIKE binary concat('_%\%', u.first_name, '\_', u.second_name, '\%%');
---------------------------------------------------------------------------------------------------------------------

-- Question: testCheck
-- return the table with a column id and a column checks, where for each answers id the following string should be returned:
-- "no answer" if the given_answer is empty;
-- "correct" if the given_answer is the same as the correct_answer;
-- "incorrect" if the given_answer is not empty and is incorrect.

-- Answer:
SELECT id, IF (given_answer = correct_answer, "correct", if(given_answer != correct_answer, "incorrect", "no answer")) AS checks
    FROM answers
    ORDER BY id;
---------------------------------------------------------------------------------------------------------------------

-- Question: expressionsVerification
-- The homework you're going to give is simple: For each expression, the student needs to determine whether
-- it's correct or not, i.e. whether it's true that the expression to the left of the = sign equals c.

-- Answer:
select * from expressions
	where case operation
	when '+' then a+b
	when '/' then a/b
	when '-' then a-b
	when '*' then a*b
	end = c;
---------------------------------------------------------------------------------------------------------------------

-- Question: newsSubscribers
-- Given the full_year and half_year tables, compose the result as follows: The resulting table should have one
-- column subscriber that contains all the distinct names of anyone who is subscribed to a newspaper with the word
-- Daily in its name. The table should be sorted in ascending order by the subscribers' first names.

-- Answer:
SELECT DISTINCT subscriber FROM full_year WHERE newspaper LIKE '%Daily%'
	UNION
	SELECT DISTINCT subscriber FROM half_year WHERE newspaper LIKE '%Daily%'
	order by subscriber;
---------------------------------------------------------------------------------------------------------------------

-- Question: countriesInfo
-- Here's the task: Given a list of countries, your friend should calculate the average population and total
-- population of all the countries in the list. To help her, you have decided to write a function that will calculate
-- the required values for any number of countries.

-- Answer:
SELECT count(name) as number,
	avg(population) as average,
	sum(population) as total
	from countries;
---------------------------------------------------------------------------------------------------------------------

-- Question: itemCounts
-- Given the availableItems table, write a select statement which returns the following three columns: item_name,
-- item_type and item_count, containing the names of the items, their types, and the amount of those items, respectively.
-- The output should be sorted in ascending order by item type, with items of the same type sorted in ascending order by
-- their names.

-- Answer:
SELECT item_name, item_type, count(item_name) as item_count from availableItems
	group by item_name, item_type ORDER BY item_type, item_name;
---------------------------------------------------------------------------------------------------------------------

-- Question: usersByContinent
-- Your task now is to calculate the number of users on each continent.

-- Answer:
SELECT continent, sum(users) as users FROM countries group by continent ORDER BY users DESC;
---------------------------------------------------------------------------------------------------------------------

-- Question: movieDirectors
-- The resulting table should have a single director column and contain the names of film directors such that:
-- they shot movies after the year 2000;
-- the total number of Oscar awards these movies received is more than 2.
-- The table should be sorted by the directors' names in ascending order.

-- Answer:
select distinct director FROM moviesInfo WHERE year > 2000 group by director HAVING sum(oscars) > 2 ORDER BY director;
---------------------------------------------------------------------------------------------------------------------

-- Question: travelDiary
-- Given this diary table, create a semicolon-separated list of all the distinct countries you've visited,
-- sorted lexicographically, and put the list in a table that has a single countries column.

-- Answer:
SELECT group_concat(DISTINCT country ORDER BY country separator ';') as countries FROM diary;
---------------------------------------------------------------------------------------------------------------------

-- Question: soccerPlayers
-- Create a semicolon-separated list of all the players, sorted by their numbers, and put this list in a table
-- under a column called players. The information about each player should have the following format: first_name
-- surname #number.

-- Answer:
SELECT 
group_concat(concat(first_name, ' ', surname, ' #', player_number) ORDER BY player_number separator '; ') as players 
FROM soccer_team;
---------------------------------------------------------------------------------------------------------------------

-- Question: marketReport
-- ("Total:", total_number_of_competitors)
-- Given the foreignCompetitors table, compose the resulting table with two columns: country and competitors.
-- The first column should contain the country name, and the second column should contain the number of competitors
-- in this country. The table should be sorted by the country names in ascending order. 

-- Answer:
(SELECT * FROM (SELECT country, count(competitor) AS competitors FROM foreignCompetitors
	GROUP BY country ORDER BY country) FIRST)
	UNION
	(SELECT 'Total:' country, count(competitor) FROM foreignCompetitors LAST)