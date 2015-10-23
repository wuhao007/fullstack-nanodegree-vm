-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP DATABASE IF EXISTS tournament;

CREATE DATABASE tournament;
\c tournament;

CREATE TABLE Players (
    id SERIAL PRIMARY KEY,
    name varchar NOT NULL
);

CREATE TABLE Matches (
    id SERIAL PRIMARY KEY,
    winner int REFERENCES Players(id) ON DELETE CASCADE,
    loser int REFERENCES Players(id) ON DELETE CASCADE,
    CHECK (winner <> loser)
);

CREATE VIEW Wins AS
    SELECT Players.id, COUNT(Matches.winner) AS n
    FROM Players
    LEFT JOIN Matches
    ON Players.id = Matches.winner
    GROUP BY Players.id;

CREATE VIEW Count AS
    SELECT Players.id, COUNT(Matches.*) AS n
    FROM Players
    LEFT JOIN Matches
    ON Players.id = Matches.winner OR Players.id = Matches.loser
    GROUP BY Players.id;

CREATE VIEW Standings AS
    SELECT Players.id, Players.name, Wins.n as wins, Count.n as matches
    FROM Players, Count, Wins
    WHERE Players.id = Wins.id AND Wins.id = Count.id
    ORDER BY wins DESC
