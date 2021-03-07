class MusicImporter

  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    # binding.pry
    files = Dir[self.path + "/*.mp3"]
    # binding.pry

    formatted = files.collect {|file| file[/[ '\w-]+\.mp3/]}
  end

  def import
    self.files.each {|file| Song.create_from_filename(file)}    
  end






end
