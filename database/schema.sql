
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

