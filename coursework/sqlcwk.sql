/*
Adam Bennett

This is an sql file to put your queries for SQL coursework. 
You can write your comment in sqlite with -- or /* * /

To read the sql and execute it in the sqlite, simply
type .read sqlcwk.sql on the terminal after sqlite3 musicstore.db.
*/

/* =====================================================
   WARNNIG: DO NOT REMOVE THE DROP VIEW
   Dropping existing views if exists
   =====================================================
*/
DROP VIEW IF EXISTS vNoCustomerEmployee; 
DROP VIEW IF EXISTS v10MostSoldMusicGenres; 
DROP VIEW IF EXISTS vTopAlbumEachGenre; 
DROP VIEW IF EXISTS v20TopSellingArtists; 
DROP VIEW IF EXISTS vTopCustomerEachGenre; 

/*
============================================================================
Task 1: Complete the query for vNoCustomerEmployee.
DO NOT REMOVE THE STATEMENT "CREATE VIEW vNoCustomerEmployee AS"
============================================================================
*/
CREATE VIEW vNoCustomerEmployee
AS SELECT EmployeeId,FirstName,LastName,Title 
FROM employees 
WHERE EmployeeId NOT IN (SELECT SupportRepid FROM customers);

/*
============================================================================
Task 2: Complete the query for v10MostSoldMusicGenres
DO NOT REMOVE THE STATEMENT "CREATE VIEW v10MostSoldMusicGenres AS"
============================================================================
*/
CREATE VIEW v10MostSoldMusicGenres(Genre, Sales) AS
SELECT g.Name AS Genre, SUM(i.Quantity) AS Sales 
FROM genres g, tracks t, invoice_items i 
WHERE t.GenreId == g.GenreId AND i.TrackId == t.TrackId 
GROUP BY Genre
ORDER BY Sales DESC
LIMIT 10;

/*
============================================================================
Task 3: Complete the query for vTopAlbumEachGenre
DO NOT REMOVE THE STATEMENT "CREATE VIEW vTopAlbumEachGenre AS"
============================================================================
*/
CREATE VIEW vTopAlbumEachGenre(Genre, Album, Artist, Sales) AS
SELECT g.Name, al.Title, art.Name, i.Quantity AS Sales 
FROM genres g, tracks t, albums al, artists art, invoice_items i
WHERE al.AlbumId == t.AlbumId AND t.TrackId == i.TrackId AND g.GenreId == t.GenreId
GROUP BY art.Name, al.Title
ORDER BY Sales DESC
;


/*
============================================================================
Task 4: Complete the query for v20TopSellingArtists
DO NOT REMOVE THE STATEMENT "CREATE VIEW v20TopSellingArtists AS"
============================================================================
*/

CREATE VIEW v20TopSellingArtists(Artist, TotalAlbum, TrackSold) AS
SELECT DISTINCT art.Name AS Artist, COUNT(DISTINCT al.Title) AS TotalAlbum, SUM(i.Quantity) AS TrackSold
FROM artists art, tracks t, invoice_items i, albums al
WHERE al.AlbumId == t.AlbumId AND t.TrackId == i.TrackId AND art.ArtistId == al.ArtistId
GROUP BY Artist
ORDER BY TrackSold DESC
LIMIT 20;


/*
============================================================================
Task 5: Complete the query for vTopCustomerEachGenre
DO NOT REMOVE THE STATEMENT "CREATE VIEW vTopCustomerEachGenre AS" 
============================================================================
*/
CREATE VIEW vTopCustomerEachGenre(Genre, TopSpender, TotalSpending) AS
SELECT *
FROM genres;

