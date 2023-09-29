require_relative '../classes/musicalbum'
require 'rspec'

describe MusicAlbum do
  before :each do
    @musicalbum = MusicAlbum.new('2001-02-02', true)
  end

  describe '#new' do
    it 'Returning an instance of the MusicAlbum class' do
      expect(@musicalbum).to be_an_instance_of(MusicAlbum)
    end
  end

  describe '#publish_date' do
    it 'Returns the date which music album published at' do
      expect(@musicalbum.publish_date).to eq('2001-02-02')
    end
  end



  describe '#on_spotify' do
    it 'Checks whether the album is on spotify' do
      expect(@musicalbum.on_spotify).to eq(true)
    end
  end

  describe '#can_be_archived?' do
    it 'Returns true if the it is more than 10 years and its on spotify, otherwise false' do
      expect(@musicalbum.can_be_archived?).to eq(true)
    end
  end
end
