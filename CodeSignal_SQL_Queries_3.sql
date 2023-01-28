-- Question: Given the people_interests table, find the people who will attend the next meeting, i.e.
-- those who are fond of both drawing and reading. The resulting table should consist of a single name column,
-- and the records should be sorted by people's names.

SELECT name
    FROM people_interests
    WHERE interests & 1 AND interests & 8
    ORDER BY name

-- Question: Given the people_hobbies table, your goal is to return the sorted names of people who have sports
-- and reading in their list of hobbies.

SELECT name FROM people_hobbies
	WHERE hobbies & 1 AND hobbies & 2
	ORDER BY name;

-- Question: Given the catalogs table, you want to find out which authors you have represented in your library.
-- Your task is to create a new table with the author column that will contain all the distinct authors, sorted by
-- their names.

SELECT ExtractValue(xml_doc,'//book[1]//author[1]') AS author FROM catalogs
	ORDER BY author;

-- Question: Now you want to find the area of the animal's habitat. You decided that the convex hull of the
-- marked points is a good first approximation of the habitat, so you want to find the area of this hull.
-- Given the places table, write a select statement which returns only one column area and consists of a single row:
-- the area of the convex hull. It is guaranteed that the resulting area is greater than 0.

SELECT ST_Area(ST_ConvexHull(ST_MPointFromText(concat('multipoint(',group_concat(concat_ws(' ',x,y)),')'))))
 AS area FROM places;