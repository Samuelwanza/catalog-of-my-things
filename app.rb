require_relative 'classes/book'
require_relative 'classes/label'
require_relative 'classes/book_info'
require_relative 'classes/game'
require_relative 'classes/author'

class App
  attr_accessor :books, :labels, :games, :authors, :game_author_handler

  def initialize
    @books = []
    @labels = []
    @game_author_handler = GameAuthorHandler.new
  end

  # Add book
  def create_book
    book_data = BookData.new
    puts 'Create book'
    puts '-----------------'
    puts 'Add the publisher name'
    publisher = gets.chomp
    puts 'Add the state of the cover "bad or good"'
    cover_state = gets.chomp.downcase
    puts 'The date of publishing dd/mm/yy'
    publish_date = gets.chomp
    book = Book.new(publish_date, publisher, cover_state)

    # Add labels to the book
    label = add_label
    book.add_label(label)

    # Associate book with label
    label.add_item(book) # Add the book to the label

    @books << book
    book_data.store_book(@books) # Store the entire @books array
    @labels << label
    book_data.store_label(@labels) # Store the entire @labels array
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
    # Remove the line that clears @books
    book_data = BookData.new
    book_data.load_book(@books, @labels) # Load books from JSON

    puts 'List of Books in the library'
    puts "\nBook list(#{@books.length}):"
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
    # Remove the line that clears @labels
    book_data = BookData.new
    book_data.load_label(@labels) # Load labels from JSON

    puts 'List of Labels'
    puts '---------------'
    return puts 'No labels added yet!' if @labels.empty?

    @labels.each.with_index(1) do |label, index|
      puts "#{index}. Title: #{label.title}, Color: #{label.color}"
    end
  end


  # methods for perserving data

  def save_data
    @game_author_handler.save_games
    @game_author_handler.save_authors
  end

  def load_data
    @game_author_handler.load_games
    @game_author_handler.load_authors
  end



  # Display the main menu
  # def display_menu
  #   puts "\nPlease choose an option according to the numbers below:"
  #   puts '1. List all books'
  #   puts '2. List all labels'
  #   puts '3. Add a book'
  #   puts '4. Exit'
  # end

  # Entry point
  # def start
  #   loop do
  #     display_menu
  #     choice = gets.chomp.to_i

  #     case choice
  #     when 1
  #       list_books
  #     when 2
  #       list_labels
  #     when 3
  #       create_book
  #     when 4
  #       puts 'Thanks for using the app'
  #       break
  #     else
  #       puts 'Invalid option. Please choose a valid option.'
  #     end
  #   end
  # end
end

class GameAuthorHandler
  def initialize
    @games = []
    @authors = []
  end

  # methods for game :
  def ask_multiplayer_for_game
    print 'Is the game multiplayer [Y/N] : '
    loop do
      user_input = gets.chomp.downcase
      case user_input
      when 'y'
        return true
      when 'n'
        return false
      else
        print "Invalid input. Please enter 'Y' or 'N': "
      end
    end
  end

  def add_author
    puts 'Add an anuthor!'
    print "Write the author's first name : "
    first_name = gets.chomp
    print "Write the author's last name : "
    last_name = gets.chomp
    author = Author.new(first_name, last_name)
    @authors << author
  end

  def add_game
    puts 'Add a Game!'
    print 'Enter the publish date of the Game [yyyy/mm/dd] : '
    pb_date = gets.chomp
    multi = ask_multiplayer_for_game
    print 'Last time which the game was played at [yyyy/mm/dd] : '
    last = gets.chomp
    game = Game.new(pb_date, multi, last)
    @games << game
    add_author
    puts 'Game added successfully!'
  end

  def list_all_games
    if @games.empty?
      puts 'No game added yet'
    else
      @games.each_with_index do |game, idx|
        print "Game #{idx + 1} -"
        print "  Publish Date: #{game.publish_date},"
        print "  Multiplayer: #{game.multiplayer},"
        print "  Last Played at: #{game.last_played_at}\n"
      end
    end
  end

  def list_all_authors
    if @authors.empty?
      puts 'No author added yet'
    else
      @authors.each_with_index do |author, idx|
        puts "Author #{idx + 1} - FullName : #{author.first_name} #{author.last_name}"
      end
    end
  end

  def save_games
    File.open('data/game.json', 'w') do |file|
      game_data = @games.map do |game|
        {
          'publish_date' => game.publish_date,
          'multiplayer' => game.multiplayer,
          'last_played' => game.last_played_at
        }
      end
      file.write(JSON.generate(game_data))
    end
  end

  def load_games
    if File.exist?('data/game.json')
      game_data = JSON.parse(File.read('data/game.json'))
      @games = game_data.map { |game| Game.new(game['publish_date'], game['multiplayer'], game['last_played']) }
    else
      []
    end
  end

  def save_authors
    File.open('data/author.json', 'w') do |file|
      author_data = @authors.map do |author|
        {
          'first_name' => author.first_name,
          'last_name' => author.last_name
        }
      end
      file.write(JSON.generate(author_data))
    end
  end

  def load_authors
    if File.exist?('data/author.json')
      author_data = JSON.parse(File.read('data/author.json'))
      @authors = author_data.map { |author| Author.new(author['first_name'], author['last_name']) }
    else
      []
    end
  end
end

# Initialize and start the app
# app = App.new
# app.start
