require_relative 'app'

def display_menu
  puts '------------------------------------------------------'
  puts 'Welcome to the Catalog of My Things!'
  puts '------------------------------------------------------'
  puts '1 - List all books'
  puts '2 - List all music albums'
  puts '3 - List of games'
  puts "4 - List all genres (e.g 'Comedy', 'Thriller')"
  puts "5 - List all labels (e.g. 'Gift', 'New')"
  puts "6 - List all authors (e.g. 'Stephen King')"
  puts '7 - Add a book'
  puts '8 - Add a music album'
  puts '9 - Add a game'
  puts '10 - Exit'
end

app = App.new
app.load_data
loop do
  display_menu
  option = gets.chomp.to_i
  case option
  when 1
    app.booklist
  when 2
    app.listmusicalbums
  when 3
    app.game_author_handler.list_all_games
  when 4
    app.listgenres
  when 5
    app.labellist
  when 6
    app.game_author_handler.list_all_authors
  when 7
    app.create_book
  when 8
    app.createmusicalbum
  when 9
    app.game_author_handler.add_game
  when 10
    app.save_data
    puts 'Thanks for using Catalog of My Things app!'
    break
  else
    puts 'Invalid Option, please choose from 1-10'
  end
end
