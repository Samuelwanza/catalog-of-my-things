require_relative 'classes/book'
require_relative 'classes/label'
require_relative 'classes/book_info'
require_relative 'classes/game'
require_relative 'classes/author'
require_relative 'classes/genre'
require_relative 'classes/musicalbum'

class App
  attr_accessor :books, :labels, :games, :authors, :game_author_handler

  def initialize
    @books = []
    @labels = []
    @game_author_handler = GameAuthorHandler.new
    @genres=[]
    @musicalbums=[]
  end

  # add book
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
    label = add_label
    book.add_label(label)
    @books << book
    book_data.store_book(book)
    @books.clear
    @labels << label
    book_data.store_label(label)
    @labels.clear
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
  def creategenre
    puts 'Enter genre type'
    genre = gets.chomp
    newgenre = Genre.new(genre)
    @genres.push(newgenre)
    puts 'genre added successfully'
  end
  def createmusicalbum
    creategenre
    puts 'Enter publish date'
    publishdate = gets.chomp
    puts 'Is the music album on spotify [y/n]'
    on_spotify = gets.chomp
    on_spotify = on_spotify == 'y'
    newmusicalbum = MusicAlbum.new(publishdate,on_spotify)
    @musicalbums.push(newmusicalbum)
    puts 'Music album created successfully'
  end
  def listmusicalbums
    if @musicalbums.empty?
      puts "No music albums added"
    else
      @musicalbums.each_with_index do |musicalbum,index|
        puts "(#{index}) Onspotify: #{musicalbum.on_spotify} publish date: #{musicalbum.publish_date} archived: #{musicalbum.archived} "
      end
    end
  end
  def listgenres
    if @genres.empty?
      puts 'No genres added yet'
    else
      @genres.each_with_index do |genre, index|
      puts "(#{index})#{genre.name}"
     end
    end
  end

  # List all books
  def booklist
    @books.clear
    book_data = BookData.new
    book_data.load_book(@books, []) # Pass an empty array as the second argument
    puts 'book list in library'
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
  def labellist
    @labels.clear
    book_data = BookData.new
    book_data.load_label(@labels)
    puts "\nLabel list(#{@labels.length}):"
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
