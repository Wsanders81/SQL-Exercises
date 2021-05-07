-- from the terminal run:
-- psql < air_traffic.sql

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic


CREATE TABLE passenger (
    id SERIAL PRIMARY KEY,
    first_name TEXT   NOT NULL,
    last_name TEXT NOT NULL
    );

CREATE TABLE airline (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
    
);

CREATE TABLE country (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
    
);

CREATE TABLE cities (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    country_id INTEGER REFERENCES country
);

CREATE TABLE flight_info (
    id SERIAL PRIMARY KEY,
    airline_id INTEGER REFERENCES airline,
    passenger_id INTEGER REFERENCES passenger, 
    seat_number VARCHAR(5) NOT NULL,
    departure_time time ,
    arrival_time time ,
    
    origin_city_id INTEGER REFERENCES cities,
    origin_country_id INTEGER REFERENCES country,
    destination_city_id INTEGER REFERENCES cities,
    destination_country_id INTEGER REFERENCES country
    
);





-- INSERT INTO tickets
--   (first_name, last_name, seat, departure, arrival, airline, from_city, from_country, to_city, to_country)
-- VALUES
--   ('Jennifer', 'Finch', '33B', '2018-04-08 09:00:00', '2018-04-08 12:00:00', 'United', 'Washington DC', 'United States', 'Seattle', 'United States'),
--   ('Thadeus', 'Gathercoal', '8A', '2018-12-19 12:45:00', '2018-12-19 16:15:00', 'British Airways', 'Tokyo', 'Japan', 'London', 'United Kingdom'),
--   ('Sonja', 'Pauley', '12F', '2018-01-02 07:00:00', '2018-01-02 08:03:00', 'Delta', 'Los Angeles', 'United States', 'Las Vegas', 'United States'),
--   ('Jennifer', 'Finch', '20A', '2018-04-15 16:50:00', '2018-04-15 21:00:00', 'Delta', 'Seattle', 'United States', 'Mexico City', 'Mexico'),
--   ('Waneta', 'Skeleton', '23D', '2018-08-01 18:30:00', '2018-08-01 21:50:00', 'TUI Fly Belgium', 'Paris', 'France', 'Casablanca', 'Morocco'),
--   ('Thadeus', 'Gathercoal', '18C', '2018-10-31 01:15:00', '2018-10-31 12:55:00', 'Air China', 'Dubai', 'UAE', 'Beijing', 'China'),
--   ('Berkie', 'Wycliff', '9E', '2019-02-06 06:00:00', '2019-02-06 07:47:00', 'United', 'New York', 'United States', 'Charlotte', 'United States'),
--   ('Alvin', 'Leathes', '1A', '2018-12-22 14:42:00', '2018-12-22 15:56:00', 'American Airlines', 'Cedar Rapids', 'United States', 'Chicago', 'United States'),
--   ('Berkie', 'Wycliff', '32B', '2019-02-06 16:28:00', '2019-02-06 19:18:00', 'American Airlines', 'Charlotte', 'United States', 'New Orleans', 'United States'),
--   ('Cory', 'Squibbes', '10D', '2019-01-20 19:30:00', '2019-01-20 22:45:00', 'Avianca Brasil', 'Sao Paolo', 'Brazil', 'Santiago', 'Chile');

  INSERT INTO country (name) 
  VALUES 
  ('United States'), 
  ('Japan'), 
  ('France'), 
  ('UAE'), 
  ('Brazil'), 
  ('United Kingdom'), 
  ('Mexico'), 
  ('Morocco'), 
  ('Chile'), 
  ('China'); 

  INSERT INTO passenger (first_name, last_name)
  VALUES 
  ('Mr.','Blippi'),
  ('Will', 'Smith'),
  ('Johnny', 'Cage'),
  ('Tristan', 'Thorn'),
  ('Will', 'IAM'),
  ('Slim', 'Shady'),
  ('Nick', 'Cannon');

  INSERT INTO airline (name)
  VALUES 
  ('United'),
  ('British Airways'),
  ('Delta'),
  ('TUI Fly Belgium'),
  ('Air China'),
  ('American Airlines');

  INSERT INTO cities (name, country_id)
  VALUES
  ('Seattle', 1), 
  ('London', 6), 
  ('Las Vegas', 1), 
  ('Dubai', 4), 
  ('Sao Paolo', 5),
  ('Tokyo', 2), 
  ('Mexico City', 7), 
  ('Washington DC', 1),
  ('Paris', 3), 
  ('Cedar Rapids',1 ), 
  ('Charlotte', 1), 
  ('Los Angeles', 1), 
  ('Casablanca', 8), 
  ('Chicago', 1), 
  ('New Orleans', 1), 
  ('Beijing', 10), 
  ('Santiago', 9); 

  INSERT INTO flight_info (airline_id, passenger_id, seat_number, departure_time, arrival_time, origin_city_id, origin_country_id, destination_city_id, destination_country_id )
  VALUES
  (1,1,'28E', '07:30:00', '12:00:00', 1,1,2,6),
  (2,2,'1F', '12:30:00', '18:00:00', 3,1,4,4),
  (3,3,'35C', '02:30:00', '17:20:01', 5,5,6,2),
  (4,4,'12B', '10:30:00', '14:45:00', 7,7,8,1),
  (5,5,'67A', '01:59:59', '24:00:00', 9,3,10,1),
  (6,6,'32E', '1:30:00', '15:56:00', 11,1,12,1),
  (3,2,'1C', '17:22:00', '10:00:00', 12,1,16,10),
  (3,3,'99D', '08:30:00', '21:00:00', 3,1,9,3),
  (3,3,'4X', '11:50:00', '11:49:59', 1,1,1,1);

  ----***** Query ******
  SELECT a.name, p.first_name, p.last_name, f.seat_number, f.departure_time, f.arrival_time, ct1.name, cy1.name, ct2.name, cy2.name
  FROM airline a 
  JOIN flight_info f 
  ON a.id = f.airline_id
  JOIN passenger p 
  ON p.id = f.passenger_id
  JOIN cities ct1
  ON ct1.id = f.origin_city_id 
  LEFT JOIN cities ct2
  ON ct2.id = f.destination_city_id
  JOIN country cy1
  ON cy1.id = f.origin_country_id 
  LEFT JOIN country cy2
  ON cy2.id = f.destination_country_id
  ORDER BY a.name; 
