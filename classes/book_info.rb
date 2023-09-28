require_relative 'book'
require 'json'

class BookData
  def store_book(books)
    existing_books = load_existing_books

    books_json = books.map do |book|
      map_book_to_json(book, existing_books)
    end

    save_books_to_file(existing_books.concat(books_json))
  end

  def store_label(labels)
    existing_labels = load_existing_labels

    label_json = labels.map do |label|
      map_label_to_json(label, existing_labels)
    end

    save_labels_to_file(existing_labels.concat(label_json))
  end

  private

  def load_existing_books
    file_path = './book_data/books.json'
    existing_books = []

    if File.exist?(file_path)
      begin
        existing_books = JSON.parse(File.read(file_path))
      rescue JSON::ParserError
        existing_books = []
      end
    end

    existing_books
  end

  def map_book_to_json(book, existing_books)
    id_mapping = create_id_mapping(existing_books)

    {
      id: id_mapping[book.id] || (existing_books.length + 1),
      publish_date: book.publish_date,
      publisher: book.publisher,
      cover_state: book.cover_state,
      label_ids: book.labels.map(&:id)
    }
  end

  def create_id_mapping(existing_books)
    id_mapping = {}
    existing_books.each_with_index do |book, index|
      id_mapping[book['id']] = index + 1
    end
    id_mapping
  end

  def save_books_to_file(books)
    file_path = './book_data/books.json'
    File.write(file_path, JSON.pretty_generate(books))
  end

  def load_existing_labels
    file_path = './book_data/labels.json'
    existing_labels = []

    if File.exist?(file_path)
      begin
        json_content = File.read(file_path)
        existing_labels = JSON.parse(json_content) unless json_content.strip.empty?
      rescue JSON::ParserError => e
        puts "Error parsing JSON in #{file_path}: #{e.message}"
      end
    end

    existing_labels
  end

  def map_label_to_json(label, existing_labels)
    label_id_mapping = create_label_id_mapping(existing_labels)
    item_id_mapping = {}

    unique_item_ids = label.items.map do |item|
      new_item_id = item_id_mapping[item.id] || (item_id_mapping.length + 1)
      item_id_mapping[item.id] = new_item_id
      new_item_id
    end.uniq

    {
      id: label_id_mapping[label.id] || (existing_labels.length + 1),
      title: label.title,
      color: label.color,
      items: unique_item_ids
    }
  end

  def create_label_id_mapping(existing_labels)
    label_id_mapping = {}
    existing_labels.each_with_index do |label, index|
      label_id_mapping[label['id']] = index + 1
    end
    label_id_mapping
  end

  def save_labels_to_file(labels)
    file_path = './book_data/labels.json'
    File.write(file_path, JSON.pretty_generate(labels))
  end
end
