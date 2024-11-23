SET GLOBAL wait_timeout = 600;
SET GLOBAL interactive_timeout = 600;
SET GLOBAL net_read_timeout = 600;
SET GLOBAL net_write_timeout = 600;

USE advdb;

CREATE TABLE Friends (
    person1 INT,
    person2 INT
);

CREATE TABLE Likes (
    person INT,
    artist INT
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\friends.csv'
INTO TABLE Friends
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(person1, person2);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\like.csv'
INTO TABLE Likes
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(person, artist);

INSERT INTO Friends (person1, person2)
SELECT t.person2, t.person1
FROM Friends t
LEFT JOIN Friends t2 ON t.person2 = t2.person1 AND t.person1 = t2.person2
WHERE t2.person1 IS NULL;

CREATE TABLE UniqueFriends AS
SELECT DISTINCT person1, person2 FROM Friends;

DROP TABLE Friends;

CREATE TABLE UniqueLike AS
SELECT DISTINCT person, artist FROM Likes;

DROP TABLE Likes;

CREATE INDEX idx_tfriends_person1 ON UniqueFriends(person1);
CREATE INDEX idx_tfriends_person2 ON UniqueFriends(person2); 
CREATE INDEX idx_tlike_person ON UniqueLike(person);
CREATE INDEX idx_tlike_person_artist ON UniqueLike(person, artist);

SELECT DISTINCT
    f.person1 AS u1,
    f.person2 AS u2,
    l.artist AS a
FROM
    UniqueFriends f
    INNER JOIN UniqueLike l ON f.person2 = l.person
    LEFT JOIN UniqueLike l2 ON f.person1 = l2.person AND l.artist = l2.artist
WHERE
    l2.person IS NULL
INTO OUTFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\result.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

DROP INDEX idx_tfriends_person1 ON UniqueFriends;
DROP INDEX idx_tfriends_person2 ON UniqueFriends;
DROP INDEX idx_tlike_person ON UniqueLike;
DROP INDEX idx_tlike_person_artist ON UniqueLike;
