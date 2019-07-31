CREATE TABLE dives(
    id SERIAL PRIMARY KEY,
    pier VARCHAR(300),
    image_url TEXT
);

CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    email VARCHAR(300),
    username VARCHAR(300)
);

CREATE TABLE comments(

);

CREATE TABLE photos(

);??