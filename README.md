# DDS-Assignment1

CSE 512 Assignment 1

The required task is to understand data fragmentation technique on-top of an open-source relational database management system (i.e., PostgreSQL) and write some SQL queries to verify the understanding of various properties of fragmentation.

Input Data: The input data is a Movie Rating data set collected from the MovieLens website (http://movielens.org). The raw data is available in the given file ratings.dat. You can download the full rating.dat file from the MovieLens website: https://files.grouplens.org/datasets/movielens/ml-10m.zip. You can also use the partial dataset provided with assignment instructions for testing purpose. For your testing, we provide test_data.txt which provides a small fraction of rating.dat file. Be noted that we will use a larger dataset during evaluation.

The rating.dat file contains 10 million ratings and 100,000 tag applications applied to 10,000 movies by 72,000 users. Each line of this file represents one rating of one movie by one user, and has the following format:

UserID::MovieID::Rating::Timestamp

Ratings are made on a 5-star scale, with half-star increments. Timestamps represent seconds since midnight Coordinated Universal Time (UTC) of January 1, 1970. A sample of the file contents is given below:

1::122::5::838985046 1::185::5::838983525

We load all ratings into a table (saved in PostgreSQL) named ratings that has the following schema (note that we don't load timestamps of ratings):
userid(int) – movieid(int) – rating(float)

Part A: Write five SQL queries on top of ratings table that can be executed in a PostgreSQL database. Each query should return some tuples from the ratings table.

Part B: Provide a fragmentation for each of the following scenario of fragmentation properties such that the provided fragmentation decomposes the ratings table into 3 fragments. For each of the given scenario, write one or more SQL queries that can decompose the ratings table into 3 fragments satisfying the given scenario. Your SQL queries for each of the fragmentations should create three tables. So, your fragmentations should be available in the form of three tables for each of B1, B2, and B3.
  
• B1): The fragmentation satisfies reconstruction and completeness properties but does not satisfy the disjointness property. After writing the queries for fragmentation, write another query on top of constructed fragments which shows that the ratings table can be reconstructed from the fragments. Explain how your fragmentation satisfies reconstruction and completeness but not disjointness. You can provide explanations as comments in the script.
• B2) The fragmentation satisfies completeness and disjointness properties but does not satisfy the reconstruction property. Explain how your fragmentation satisfies completeness and disjointness but not reconstruction. You can provide explanations as comments in the script.
• B3) The fragmentation satisfies all completeness, reconstruction and disjointness properties. Table names for this fragmentation should be f1, f2, and f3. After writing the queries for fragmentation, write another query on top of constructed fragments which shows that the ratings table can be reconstructed from the fragments. Explain how your fragmentation satisfies all three properties. You can provide explanations as comments in the script.

Part C: For the five queries that you wrote in Part A, rewrite all those queries in terms of the fragments created in part B3 (f1, f2, and f3) instead of the original rating table.

