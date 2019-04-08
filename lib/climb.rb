class Climb

    attr_accessor :difficulty, :name, :url, :type, :star_rating
    @@all = []

    def initialize(difficulty, name, url)
      @difficulty = difficulty
      @name = name
      @url = url
      @@all << self 
    end

    def self.all
      @@all
    end
end
