require_relative '../classes/genre'

describe Genre do
  before :each do
    @genre = Genre.new('play')
  end

  describe '#new' do
    it 'Returns an instance of Genre class' do
      expect(@genre).to be_an_instance_of(Genre)
    end
  end

  describe '#name' do
    it 'Returns name of genre' do
      expect(@genre.name).to eq('play')
    end
  end

  describe '#items' do
    it 'Returns empty array for items' do
      expect(@genre.items).to eq []
    end
  end

  describe '#add_item' do
    it 'Adding item to the array of items' do
      mock_item = double('item')
      allow(mock_item).to receive(:genre=).with(@genre)
      @genre.add_item(mock_item)
      expect(@genre.items).to include(mock_item)
    end
  end
end
