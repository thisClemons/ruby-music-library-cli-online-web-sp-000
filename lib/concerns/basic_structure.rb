module BasicStructure
  module InstanceMethods

    attr_accessor :name
    #
    def initialize(name)
      @name = name
    end

    def save
      self.class.all << self
    end



  end
  module ClassMethods
    @@all = []

    def all
      @@all
    end

    def destroy_all
      @@all.clear
    end

    def create(name)
      item = self.new(name)
      item.save
      item
    end

  end
end
