class Genre
  def initialize(name)
    @id = Random.rand(1..1000)
    @name = name
    @items = []
  end
  attr_accessor :name, :id
  attr_reader :items
end
