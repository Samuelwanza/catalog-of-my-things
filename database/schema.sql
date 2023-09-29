-- Create the 'Items' table
CREATE TABLE Items (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY
);

-- Create the 'books' table with associations to items and publishers
CREATE TABLE IF NOT EXISTS books (
    id UUID PRIMARY KEY,
    item_id UUID REFERENCES items (id),
    publisher VARCHAR(255),
    cover_state VARCHAR(255)
);

-- Create the 'labels' table
CREATE TABLE IF NOT EXISTS labels (
    id INT PRIMARY KEY,
    title VARCHAR(255),
    color VARCHAR(255)
);

-- Create the 'games' table
CREATE TABLE games(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    publish_date DATE,
    archived BOOLEAN,
    multiplayer BOOLEAN,
    last_played_at DATE
)

-- Create the 'authors' table
CREATE TABLE authors(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(50)
    last_name VARCHAR(50)
)

ALTER TABLE books ADD FOREIGN KEY(label_id) REFERENCES labels(id)
ALTER TABLE books ADD FOREIGN KEY(author_id) REFERENCES authors(id)
-- ALTER TABLE books ADD FOREIGN KEY(genre_id) REFERENCES genres(id)

ALTER TABLE games ADD FOREIGN KEY(label_id) REFERENCES labels(id)
ALTER TABLE games ADD FOREIGN KEY(author_id) REFERENCES authors(id)
-- ALTER TABLE games ADD FOREIGN KEY(genre_id) REFERENCES genres(id)

CREATE INDEX ON books (label_id)
CREATE INDEX ON books (author_id)
-- CREATE INDEX ON books (genre_id)

CREATE INDEX ON games (label_id)
CREATE INDEX ON games (author_id)
-- CREATE INDEX ON games (genre_id)
