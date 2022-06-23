/*
Creating the table and loading the dataset
*/
DROP TABLE IF EXISTS ratings;
CREATE TABLE ratings (userid INT, temp1 VARCHAR(10),  movieid INT , temp3 VARCHAR(10),  rating REAL, temp5 VARCHAR(10), timestamp INT);
COPY ratings FROM 'test_data1.txt' DELIMITER ':';
ALTER TABLE ratings DROP COLUMN temp1, DROP COLUMN temp3, DROP COLUMN temp5, DROP COLUMN timestamp;

-- Do not change the above code except the path to the dataset.
-- make sure to change the path back to default provided path before you submit it.

-- Part A
/* Write the queries for Part A*/

--Query 1 
--Select query
SELECT *
FROM ratings
where movieid > 100 and movieid < 200
and rating > 3.5

-- Query 2
--Using Between operator
SELECT * 
FROM ratings 
WHERE rating BETWEEN 3 AND 5;

--Query 3 
--Count query
SELECT COUNT(rating)
FROM ratings
WHERE movieid > 100 ;

--Query 4
--Minimum of records
SELECT MIN(rating)
FROM ratings;

--Query 5 
--Distinct Function
SELECT DISTINCT rating 
FROM ratings;


-- Part B
/* Create the fragmentations for Part B1 */
DROP TABLE IF EXISTS frag1;
DROP TABLE IF EXISTS frag2;
DROP TABLE IF EXISTS frag3;
CREATE TABLE frag1 AS SELECT * FROM ratings WHERE rating BETWEEN 0 AND 3;
CREATE TABLE frag2 AS SELECT * FROM ratings WHERE rating BETWEEN 2 AND 4;
CREATE TABLE frag3 AS SELECT * FROM ratings WHERE rating BETWEEN 3 AND 5;

/* Write reconstruction query/queries for Part B1 */
-- Reconstructed the table using fragments
DROP TABLE IF EXISTS Reconstruct;
CREATE TABLE Reconstruct AS
SELECT * FROM frag1
UNION
SELECT * FROM frag2
UNION
SELECT * FROM frag3;

SELECT * FROM Reconstruct;

-- Comparing the original and reconstructed table 
SELECT * FROM ratings
EXCEPT
SELECT * FROM Reconstruct;

/* Write your explanation as a comment */

/* n how your fragmentation satisfies reconstruction and completeness but not disjointness

The queries above satisfy reconstruction and completeness and donot satisfy disjointness in the following way
1.Reconstruction - When we reconstruct the table from fragments frag1,frag2,frag3 we get a complete table (tablne name= Reconstruct) with perfectly
same number of rows as the original database (test_data1 )
2.Completness- No data loss is found .Each and every tuple/record is present in atleast one fragment .
3. No disjointness- 
Ratings table  is divided into 3 Fragments viz-
frag1,frag2,frag3
frag1 contains tuples for rating < 2 and 
frag2 contains tuples for rating = 2 and 
frag3 contains tuples for rating > 1
The fragments are not disjoint as we have an overlapping condition where the data is repeated in the fragments
like - the condition rating <2 and rating >1 both have an overlap .
Hence, the disjointness condition is not satisfied. */

/* Create the fragmentations for Part B2 */
DROP TABLE IF EXISTS frag1;
DROP TABLE IF EXISTS frag2;
DROP TABLE IF EXISTS frag3;
CREATE TABLE frag1 AS SELECT movieid FROM ratings;
CREATE TABLE frag2 AS SELECT userid FROM ratings;
CREATE TABLE frag3 AS SELECT rating from ratings;

/* Write your explanation as a comment */
/* Performed a vertical fragmentation
   f1: Contains movieid 
   f2: Contains userid
   f3: Conatins rating
   Completeness: Decomposition of relation R into fragments R1, R2, ..., Rn is complete if and 
   only if each data item in R can also be found in some Ri
		All movieid column data items are present in f1
        All userid column values are present in f2.
		All rating column values are present in f3
        So all data items are present in the formed fragments.
        Hence it satified Completeness.
	Disjointness: If relation R is decomposed into fragments R1, R2, ..., Rn, and data item di is in Rj, 
	then di should not be in any other fragment Rk (k ≠ j ).
		There are no common columns in f1, f2 and f3, so no data item of f1 is present in f2. 
        Hence it satisfied disjointness.
    Recontruction: If relation R is decomposed into fragments R1, R2, ..., Rn, then 
    there should exist some relational operator ∇ such that R = ∇1≤i≤nRi
        As there is no common attribute which can act as a join attribute, we cannot join the fragments 
        and get back the original table.
        Hence it doesn't satify the reconstruction.
*/


/* Create the fragmentations for Part B3 */
-- rating are from 0 to 5 with incrementing value of 0.5
DROP TABLE IF EXISTS frag1;
DROP TABLE IF EXISTS frag2;
DROP TABLE IF EXISTS frag3;
CREATE TABLE frag1 AS SELECT * FROM ratings WHERE rating BETWEEN 0 AND 2;
CREATE TABLE frag2 AS SELECT * FROM ratings WHERE rating BETWEEN 2.5 AND 4;
CREATE TABLE frag3 AS SELECT * FROM ratings WHERE rating BETWEEN 4.5 AND 5;

/* Write reconstruction query/queries for Part B3 */
-- Reconstructed the table using fragments
DROP TABLE IF EXISTS Reconstruct;
CREATE TABLE Reconstruct AS
SELECT * FROM frag1
UNION
SELECT * FROM frag2
UNION
SELECT * FROM frag3;

-- Comparing the original and reconstructed table 
SELECT * FROM ratings
EXCEPT
SELECT * FROM Reconstruct;

/* Write your explanation as a comment */
/* Fragments:
	f1: 0 <= rating <= 2
	f2: 2.5 <= rating <= 4
	f3: 4.5 <= rating <= 5
	
	Completeness: Decomposition of relation R into fragments R1, R2, ..., Rn is complete if and only 
    if each data item in R can also be found in some Ri
		So every row in the ratings table is present in some fragment.
        Hence it satisfy completeness
	Recontruction: If relation R is decomposed into fragments R1, R2, ..., Rn, 
    then there should exist some relational operator ∇ such that R = ∇1≤i≤nRi
		When we merge all the fragments (f1,f2,f3) using union, 
        We are getting the original table back(ratings).
		Hence it satisfy reconstruction
	Disjointness: If relation R is decomposed into fragments R1, R2, ..., Rn, and data item di is in Rj, 
	then di should not be in any other fragment Rk (k ≠ j ).
		No item with is present in multiple fragments. 
        example: rating 2 is only present in f1 and not available in any other fragment.
        Hence it satisfy disjointness.
*/


-- Part C
/* Write the queries for Part C */
--Query 1
--Select query
SELECT *
from frag1
where movieid > 100 and movieid < 200
and rating > 3.5

SELECT *
from frag2
where movieid > 100 and movieid < 200
and rating > 3.5

SELECT *
from frag3
where movieid > 100 and movieid < 200
and rating > 3.5

--Query 2
--Between operator
SELECT * 
FROM frag1 
WHERE rating BETWEEN 3 AND 5;

SELECT * 
FROM frag2 
WHERE rating BETWEEN 3 AND 5;

SELECT * 
FROM frag3 
WHERE rating BETWEEN 3 AND 5;

--Query 3
--Count operator
SELECT COUNT(rating)
FROM frag1
WHERE movieid > 100 ;

SELECT COUNT(rating)
FROM frag2
WHERE movieid > 100 ;

SELECT COUNT(rating)
FROM frag3
WHERE movieid > 100 ;

--Query 4
--Minimum of records
SELECT MIN(rating)
FROM frag1;

SELECT MIN(rating)
FROM frag2;

SELECT MIN(rating)
FROM frag3;

--Query 5
--Distinct Function
SELECT DISTINCT rating From frag1;

SELECT DISTINCT rating From frag2;

SELECT DISTINCT rating From frag3;