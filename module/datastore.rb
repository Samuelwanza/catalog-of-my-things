require 'json'

module LoadModule
  def savegenre
    genredata = @genres.map do |genre|
      {
        'id' => genre.id,
        'name' => genre.name
      }
    end
    File.write('data/genre.json', JSON.pretty_generate(genredata))
  end

  def savemusicalbums
    musicalbumsdata = @musicalbums.map do |musicalbum|
      musicalbumdata = {
        'publish_date' => musicalbum.publish_date,
        'archived' => musicalbum.archived,
        'on_spotify' => musicalbum.on_spotify,
        'id' => musicalbum.id
      }

      musicalbumdata
    end
    File.write('data/musicalbum.json', JSON.pretty_generate(musicalbumsdata))
  end

  def loadgenre
    return [] unless File.exist?('data/genre.json')

    data = File.read('data/genre.json')
    genredata = JSON.parse(data)
    genredata.map do |genre|
      newgenre = Genre.new(genre['name'])
      newgenre.id = genre['id']
      @genres.push(newgenre)
    end
  end

  def loadmusicalbums
    return [] unless File.exist?('musicalbum.json')

    data = File.read('musicalbum.json')
    musicalbumdata = JSON.parse(data)
    musicalbumdata.map do |musicalbum|
      musicalbum['publish_date'],
                     = musicalbum['archived'],
                     on_spotify = musicalbum['on_spotify'],
                     newmusicalbum = Book.new(genre, author, label, publish_date, archived, on_spotify)
      newmusicalbum.id = musicalbum['id']
      @musicalbums.push(newmusicalbum)
    end
  end
end
