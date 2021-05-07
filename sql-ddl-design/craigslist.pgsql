
DROP DATABASE IF EXISTS craigslist ; 
CREATE DATABASE craigslist; 
\c craigslist; 

CREATE TABLE regions 
(
    id SERIAL PRIMARY KEY, 
    name TEXT NOT NULL 
); 

CREATE TABLE users 
(
    id SERIAL PRIMARY KEY, 
    username VARCHAR(25) NOT NULL, 
    region_id INTEGER DEFAULT 1
); 

CREATE TABLE categories
(
    id SERIAL PRIMARY KEY, 
    name VARCHAR(30) NOT NULL
); 

CREATE TABLE posts 
(
    id SERIAL PRIMARY KEY, 
    title TEXT NOT NULL, 
    text TEXT NOT NULL, 
    user_id INTEGER REFERENCES users ON DELETE SET NULL, 
    location TEXT, 
    category_id INTEGER REFERENCES categories, 
    region_id INTEGER REFERENCES regions
);

INSERT INTO regions (name)
VALUES 
('North County Inland'), 
('South Bay'), 
('Central San Diego'), 
('San Diego Coastal'); 

INSERT INTO users (username, region_id)
VALUES
('circus_freak911', 1), 
('2Old4This', 2), 
('Joe_Not_Exotic', 3), 
('Shaquille_Oatmeal',4); 

INSERT INTO categories (name)
VALUES
('Missed Connections'), 
('Goods (Subjective) For Sale'), 
('Dark Web'), 
('Sports Memorabilia'); 

INSERT INTO posts (title, text, user_id, location, category_id, region_id)
VALUES
('Missed Connection - Passing clown car', 'No funny business, serious replies only',1, 'Escondido', 1, 1), 
('Selling Used Dentures', 'I only ate soup, barely used. $400/obo.', 2, 'Chula Vista', 2, 2), 
('Looking for Endangered Animals to Exploit', 'Please do not contact if you are affiliated with Carol Baskin.', 3, 'La Jolla', 3,3 ), 
('Size 27 Shoes for Sale. Signed by Shaquille Oatmeal Himself', 'You can sail to Panama in these bad boys. $250/firm.',4,'Del Mar',4,4); 


--******** Query *******

-- SELECT  c.name, p.title, p.text, u.username, p.location, r.name 
-- FROM users u 
-- JOIN regions r
-- ON u.region_id = r.id
-- JOIN posts p
-- ON u.id = p.user_id
-- JOIN categories c
-- ON c.id = p.category_id; 