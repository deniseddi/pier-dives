CREATE TABLE piers(
    id SERIAL PRIMARY KEY,
    title VARCHAR(300),
    image_url TEXT
);

CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    email VARCHAR(300),
    -- username VARCHAR(300)
    password_digest VARCHAR(400)
);

CREATE TABLE comments(
    id SERIAL PRIMARY KEY,
    body TEXT,
    pier_id INTEGER,
    user_id INTEGER
);

CREATE TABLE photos(
    id SERIAL PRIMARY KEY,
    image_url VARCHAR(400),
    pier_id INTEGER,
    user_id INTEGER
);
INSERT INTO piers (title,image_url) VALUES('Flinders','https://i.pinimg.com/originals/b2/77/95/b277954c06f979146c6a5b2ae20771b5.jpg');

-- DO:
ALTER TABLE users ADD COLUMN username VARCHAR(300);

ALTER TABLE piers ADD COLUMN paragraph_1 VARCHAR(400);

ALTER TABLE piers ADD COLUMN paragraph_2 VARCHAR(400);

UPDATE piers SET paragraph_1 ='', paragraph_2='' WHERE id =;
