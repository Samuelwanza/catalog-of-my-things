require_relative 'classes/book'
require_relative 'classes/label'

class App
  attr_accessor :books, :labels

  def initialize
    @books = []
    @labels = []
  end

  # Add book
  def create_book
    puts 'Create book'
    puts '-----------------'
    puts 'Add the publisher name'
    publisher = gets.chomp
    puts 'Add the state of the cover "bad or good"'
    cover_state = gets.chomp.downcase
    puts 'The date of publishing dd/mm/yy'
    publish_date = gets.chomp
    book = Book.new(publish_date, publisher, cover_state)
    label = add_label
    book.add_label(label)
    @books << book
    @labels << label
    puts 'Book added successfully'
  end

  def add_label
    # Add a label
    puts 'Assign a label to the book'
    puts '-------------------------'
    puts 'Enter a title for the label:'
    title = gets.chomp
    puts 'Assign a color to the label:'
    color = gets.chomp
    Label.new(title, color)
  end

  # List all books
  def list_books
    puts 'List of Books in the library'
    puts "\nBook list (#{@books.length}):"
    puts '--------------'
    return puts 'No books added yet!' if @books.empty?

    @books.each.with_index(1) do |book, index|
      publisher = "Publisher: #{book.publisher}, " unless book.publisher.nil?
      publish_date = "Publish date: #{book.publish_date}, " unless book.publish_date.nil?
      cover_state = "Cover state: #{book.cover_state}" unless book.cover_state.nil?
      puts "#{index}. #{publisher}#{publish_date}#{cover_state}"
    end
  end

  # List all labels
  def list_labels
    puts 'List of Labels'
    puts '---------------'
    return puts 'No labels added yet!' if @labels.empty?

    @labels.each.with_index(1) do |label, index|
      puts "#{index}. Title: #{label.title}, Color: #{label.color}"
    end
  end

  # Display the main menu
  def display_menu
    puts "\nPlease choose an option according to the numbers below:"
    puts '1. List all books'
    puts '2. List all labels'
    puts '3. Add a book'
    puts '4. Exit'
  end

  # Entry point
  def start
    loop do
      display_menu
      choice = gets.chomp.to_i

      case choice
      when 1
        list_books
      when 2
        list_labels
      when 3
        create_book
      when 4
        puts 'Thanks for using the app'
        break
      else
        puts 'Invalid option. Please choose a valid option.'
      end
    end
  end
end

# Initialize and start the app
app = App.new
app.start
