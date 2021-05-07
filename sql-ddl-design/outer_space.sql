-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

CREATE TABLE galaxy 
(
  id SERIAL PRIMARY KEY, 
  name TEXT NOT NULL
); 

CREATE TABLE orbited_planet
(
  id SERIAL PRIMARY KEY, 
  name TEXT NOT NULL
);

CREATE TABLE planets
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  orbital_period_years FLOAT NOT NULL,
  galaxy_id INTEGER REFERENCES galaxy, 
  orbited_planet_id INTEGER REFERENCES orbited_planet
);

CREATE TABLE moons
(
  id SERIAL PRIMARY KEY, 
  name TEXT NOT NULL, 
  planet_id INTEGER REFERENCES planets
);





INSERT INTO galaxy (name)
VALUES
('Milky Way'), 
('Proxima Centauri'); 

INSERT INTO orbited_planet (name)
VALUES
('Sun'), 
('Proxima Centauri'), 
('Gliese 876'); 

INSERT INTO planets (name, orbital_period_years, galaxy_id, orbited_planet_id)
VALUES
('Earth', 1, 1, 1), 
('Mars', 1.88, 1, 1), 
('Venus', 0.62, 1, 1), 
('Neptune', 164.8, 1, 1), 
('Proxima Centuauri b', 0.03, 2, 2), 
('Gliese 876 b', 0.23, 2, 3); 

INSERT INTO moons (name, planet_id)
VALUES
('The Moon', 1), 
('Phobos', 2), 
('Deimos', 2), 
('Thalassa', 3),
('Despina', 3),
('Galatea', 3),
('Larissa', 3),
('S/2004 N 1', 3),
('Proteus', 3),
('Triton', 3),
('Nereid', 3),
('Halimede', 3),
('Sao', 3),
('Laomedeia', 3),
('Psamathe', 3),
('Neso', 3);

---* Query

SELECT p.name AS planet,  g.name AS galaxy, m.name AS moon, o.name AS orbits, p.orbital_period_years AS orbital_years
FROM moons m
FULL JOIN planets p
ON m.planet_id = p.id
JOIN galaxy g
ON g.id = p.galaxy_id
JOIN orbited_planet o 
ON o.id = p.orbited_planet_id
ORDER BY p.name; 