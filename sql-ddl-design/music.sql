-- from the terminal run:
-- psql < music.sql

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

CREATE TABLE albums
(
  id SERIAL PRIMARY KEY, 
  name TEXT NOT NULL 

); 

CREATE TABLE artists 
(
  id SERIAL PRIMARY KEY, 
  name TEXT  
); 

CREATE TABLE producers 
(
  id SERIAL PRIMARY KEY, 
  name TEXT 
); 

CREATE TABLE songs
(
  id SERIAL PRIMARY KEY, 
  release_date DATE NOT NULL, 
  song_name TEXT NOT NULL, 
  runtime_secs INTEGER NOT NULL, 
  artist1_id INTEGER REFERENCES artists, 
  artist2_id INTEGER REFERENCES artists, 
  album_id INTEGER REFERENCES albums, 
  producer1_id INTEGER REFERENCES producers, 
  producer2_id INTEGER REFERENCES producers  


);



INSERT INTO albums (name)
VALUES
('Middle of Nowhere'), 
('A Night at the Opera'), 
('Daydream'), 
('A Star Is Born'), 
('Silver Side Up'), 
('The Blueprint 3'), 
('Prism'), 
('Hands All Over'), 
('Let Go'), 
('The Writing''s on the Wall');

INSERT INTO artists (name)
VALUES 
('Hanson'), 
('Queen'), 
('Mariah Carey'), 
('Boyz II Men'), 
('Lady Gaga'), 
('Bradley Cooper'), 
('Nickelback'), 
('Jay Z'), 
('Alicia Keys'), 
('Katy Perry'), 
('Juicy J'), 
('Maroon 5'), 
('Christina Aguilera'), 
('Avril Lavigne'), 
('Destiny''s Child'); 

 INSERT INTO producers (name)
 VALUES
 ('Dust Brothers'), 
 ('Stephen Lironi'), 
 ('Roy Thomas Baker'), 
 ('Walter Afanasieff'), 
 ('Benjamin Rice'), 
 ('Rick Parashar'), 
 ('Al Shux'), 
 ('Max Martin'), 
 ('Cirkut'), 
 ('Shellback'), 
 ('Benny Blanco'), 
 ('The Matrix'), 
 ('Darkchild');

 INSERT INTO songs(release_date, song_name, runtime_secs, artist1_id, artist2_id, album_id, producer1_id, producer2_id)
 VALUES
 ('04-15-1997', 'MMMBop', 238, 1, null, 1, 1, 2),
 ('10-31-1975', 'Bohemian Rhapsody', 355, 2, null, 2, 3, null),
 ('11-14-1995', 'One Sweet Day', 282, 3, 4, 3, 4, null), 
 ('09-27-2018', 'Shallow', 216, 5, 6, 4, 5, null), 
 ('08-21-2001', 'How You Remind Me', 223, 7, null, 5, 6, null), 
 ('10-20-2009', 'New York State of Mind', 276, 8, 9, 6, 7, null), 
 ('12-17-2013', 'Dark Horse', 215, 10, 11, 7, 8, 9), 
 ('06-21-2011', 'Moves Like Jagger', 201, 12, 13, 8, 10, 11), 
 ('05-14-2002', 'Complicated', 244, 14, null, 9, 12, null), 
 ('11-07-1999', 'Say My Name', 240, 15, null, 10, 13, null);   

 --*********** Query ************
 
 SELECT s.release_date,
  s.song_name, 
  s.runtime_secs, 
  ar1.name AS artist1,
  ar2.name AS artist2,
  al.name AS album, 
  p1.name AS producer1, 
  p2.name AS producer2        
 FROM songs s 
 JOIN artists AS ar1
 ON  ar1.id = s.artist1_id
 LEFT JOIN artists AS ar2 
 ON ar2.id = s.artist2_id 
 JOIN albums al 
 ON al.id = s.album_id
 JOIN producers AS p1
 ON p1.id = s.producer1_id
 LEFT JOIN producers AS p2
 ON p2.id = s.producer2_id



