require 'pry'
class Song

  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    # binding.pry
    @name = name
    self.artist = artist if artist
    self.genre = genre
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    song = self.new(name)
    song.save
    song
  end

  def artist=(artist)
    # binding.pry
    @artist = artist
    # binding.pry
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre if self.genre == nil
  end

  def self.find_by_name(name)
    self.all.find {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    # binding.pry
    if self.find_by_name(name)
      self.find_by_name(name)
    else
      self.create(name)
    end
  end

  def self.new_from_filename(filename)
    song_info = filename.split(" - ")

    name = song_info[1]
    artist = song_info[0]
    genre = song_info[2].split(".mp3")[0]

    song = Song.new(name)
    song.artist = Artist.find_or_create_by_name(artist)
    song.genre = Genre.find_or_create_by_name(genre)
    song
  end

  def self.create_from_filename(filename)
    song = new_from_filename(filename)
    song.save
  end


end
