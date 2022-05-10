--Quesion 1 The names of the animals in a given enclosure

SELECT name,enclosure_id FROM animals ORDER BY enclosure_id;

--Question 2 The names of the staff working in a given enclosure

SELECT name, enclosure_id 
FROM assignments
INNER JOIN employees
ON employees.id = assignments.employee_id
ORDER BY enclosure_id;

--Question 3 The names of staff working in enclosures which are closed for maintenance

SELECT employees.name, enclosure_id
FROM employees
INNER JOIN assignments
ON employees.id = assignments.employee_id
INNER JOIN enclosures
ON enclosures.id = assignments.enclosure_id
WHERE enclosures.closed_for_maintenance IS TRUE;

--Question 4 The name of the enclosure where the oldest animal lives. 
--If there are two animals who are the same age choose the first one alphabetically.

SELECT enclosures.name, animals.age
FROM enclosures
INNER JOIN animals
ON enclosures.id = animals.enclosure_id
ORDER BY animals.age DESC LIMIT 1;

--Question 5 The number of different animal types a given keeper has been assigned to work with.

SELECT count(animals.type), employees.name
FROM animals
INNER JOIN assignments
ON animals.enclosure_id = assignments.enclosure_id
INNER JOIN employees
ON employees.id = assignments.employee_id
GROUP BY employees.name;

--Question 6 The number of different keepers who have been assigned to work in a given enclosure

SELECT COUNT(DISTINCT employees.name), enclosures.name
FROM employees
INNER JOIN assignments
ON employees.id = assignments.employee_id
INNER JOIN enclosures
ON enclosures.id = assignments.enclosure_id
GROUP BY enclosures.name;

--Question 7 The names of the other animals sharing an enclosure with a given animal 
--(eg. find the names of all the animals sharing the big cat field with Tony)

SELECT animals.name 
FROM animals 
WHERE enclosure_id = (SELECT enclosure_id from animals WHERE animals.name = 'Leo') 
AND animals.name != 'Leo';