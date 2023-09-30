require_relative 'book'
require_relative 'label'
require 'json'

class BookData
  # store the book into json file
  def store_book(books)
    books_json = {
      id: books.id,
      publish_date: books.publish_date,
      publisher: books.publisher,
      cover_state: books.cover_state,
      label_id: books.labels.first.id # Assuming a book can have multiple labels, change this accordingly
    }
    file_path = './data/books.json'
    if File.size?(file_path)
      books = JSON.parse(File.read(file_path))
      books << books_json
      File.write(file_path, JSON.pretty_generate(books))
    else
      File.write(file_path, JSON.pretty_generate([books_json]))
    end
  end

  # load the book data from JSON to book arr
  def load_book(book_arr, _label_arr)
    file_path = './data/books.json'
    return unless File.exist?(file_path) && !File.empty?(file_path)

    books = JSON.parse(File.read(file_path))
    books.each do |book|
      new_book = Book.new(book['publish_date'], book['publisher'], book['cover_state'])
      book_arr << new_book
    end
  end

  # store label data from array to Json file
  def store_label(labels)
    label_json = {
      id: labels.id,
      title: labels.title,
      color: labels.color,
      items: labels.items.map(&:id)
    }
    file_path = './data/labels.json'
    if File.exist?(file_path) && !File.empty?(file_path)
      labels = JSON.parse(File.read(file_path))
      labels << label_json
      File.write(file_path, JSON.pretty_generate(labels))
    else
      File.write(file_path, JSON.pretty_generate([label_json]))
    end
  end

  # load the label json data back to label array

  def load_label(label_arr)
    file_path = './data/labels.json'
    return unless File.size?(file_path)

    labels = JSON.parse(File.read(file_path))
    labels.each do |label|
      new_label = Label.new(label['title'], label['color'])
      label_arr << new_label
    end
  end
end
