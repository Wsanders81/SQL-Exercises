
DROP DATABASE IF EXISTS soccer_league; 
CREATE DATABASE soccer_league; 
\c soccer_league; 

CREATE TABLE teams 
(
    id SERIAL PRIMARY KEY, 
    name TEXT NOT NULL
); 

CREATE TABLE referees 
(
    id SERIAL PRIMARY KEY, 
    name TEXT NOT NULL
);

CREATE TABLE players 
(
    id SERIAL PRIMARY KEY, 
    name TEXT NOT NULL, 
    team_id INTEGER REFERENCES teams
); 

CREATE TABLE seasons
(
    id SERIAL PRIMARY KEY, 
    start_date DATE NOT NULL, 
    end_date DATE NOT NULL
);

CREATE TABLE results 
(
    id SERIAL PRIMARY KEY, 
    team_id INTEGER REFERENCES teams NOT NULL, 
    result TEXT,
    CONSTRAINT chk_result CHECK (result IN('win','lose','draw'))
); 

CREATE TABLE matches 
(
    id SERIAL PRIMARY KEY, 
    home_team_id INTEGER REFERENCES teams NOT NULL, 
    away_team_id INTEGER REFERENCES teams NOT NULL, 
    referee_id INTEGER REFERENCES referees NOT NULL, 
    season_id INTEGER REFERENCES seasons NOT NULL
    
);

CREATE TABLE goals 
(
    id SERIAL PRIMARY KEY, 
    player_id INTEGER REFERENCES players, 
    match_id INTEGER REFERENCES matches
);

INSERT INTO teams (name)
VALUES
('Chelsea F.C.'), 
('Real Madrid'), 
('Manchester United'), 
('Liverpool F.C.'), 
('FC Barcelona'); 

INSERT INTO referees (name)
VALUES
('I dont watch soccer'), 
('too much time to look up referee names'); 

INSERT INTO players (name)
VALUES
('David Beckham',1), 
('Nancy Pelosi',2), 
('Donald Glover',3), 
('Nancy Kerrigan',4), 
('Steve Buscemi',5); 

INSERT INTO seasons (start_date, end_date)
VALUES
('2020-01-01', '2020-01-02'); 

INSERT INTO results (team_id, result)
VALUES 
(1, 'win'), 
(2, 'lose'), 
(3, 'draw'); 

INSERT INTO matches (home_team_id, away_team_id, referee_id, season_id)
VALUES
(1,2,1,1), 
(2,3,1,1); 

INSERT INTO goals (player_id, match_id)
VALUES
(1,2), 
(4,1), 
(5,2); 