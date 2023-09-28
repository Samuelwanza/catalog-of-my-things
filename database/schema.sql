-- Create the 'items' table to represent common properties for both books and labels
CREATE TABLE IF NOT EXISTS items (
    id UUID PRIMARY KEY,
    publish_date DATE,
    archived BOOLEAN
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

-- Create a many-to-many relationship table between items and labels
CREATE TABLE IF NOT EXISTS item_labels (
    item_id UUID REFERENCES items (id),
    label_id INT REFERENCES labels (id),
    PRIMARY KEY (item_id, label_id)
);
