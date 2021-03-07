class MusicLibraryController

  def initialize(path = './db/mp3s')
    importer = MusicImporter.new(path)
    importer.import
  end

  def call
    puts("Welcome to your music library!")
    puts("To list all of your songs, enter 'list songs'.")
    puts("To list all of the artists in your library, enter 'list artists'.")
    puts("To list all of the genres in your library, enter 'list genres'.")
    puts("To list all of the songs by a particular artist, enter 'list artist'.")
    puts("To list all of the songs of a particular genre, enter 'list genre'.")
    puts("To play a song, enter 'play song'.")
    puts("To quit, type 'exit'.")
    puts("What would you like to do?")

    input = gets

    case input
    when "list songs"
      self.list_songs
    when "list artists"
      self.list_artists
    when "list genres"
      self.list_genres
    when "list artist"
      self.list_songs_by_artist
    when "list genre"
      self.list_songs_by_genre
    when "play song"
      self.play_song
    end

    self.call if gets != "exit"
  end

  def list_songs
    # binding.pry
    songs_in_order = Song.all.sort {|a, b| a.name <=> b.name}
    # binding.pry

    num = 1
    songs_in_order.each do |song|
      puts "#{num}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      num += 1
    end
  end

  def list_artists
    artists_in_order = Artist.all.sort {|a, b| a.name <=> b.name}

    num = 1
    artists_in_order.each do |artist|
      puts "#{num}. #{artist.name}"
      num += 1
    end
  end

  def list_genres
    genres_in_order = Genre.all.sort {|a, b| a.name <=> b.name}
    num = 1
    genres_in_order.each do |genre|
      puts "#{num}. #{genre.name}"
      num += 1
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    target = gets

    if(Artist.find_by_name(target))
      songs_sorted = Artist.find_by_name(target).songs.sort {|a, b| a.name <=> b.name}
      num = 1
      songs_sorted.each do |song|
        puts "#{num}. #{song.name} - #{song.genre.name}"
        num += 1
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    target = gets

    if(Genre.find_by_name(target))
      genres_sorted = Genre.find_by_name(target).songs.sort {|a, b| a.name <=> b.name}
      num = 1
      genres_sorted.each do |song|
        puts "#{num}. #{song.artist.name} - #{song.name}"
        num += 1
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"

    # self.list_songs

    song_number = gets
    # binding.pry
    if 1 <= song_number.to_i && song_number.to_i <= Song.all.size
      # binding.pry
      selection = Song.all.sort {|a, b| a.name <=> b.name}[song_number.to_i - 1]
      puts "Playing #{selection.name} by #{selection.artist.name}"
    end
  end
end
