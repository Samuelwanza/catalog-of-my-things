require 'rspec'
require_relative '../classes/label'

describe Label do
  before :each do
    @label = Label.new('Love of my life', nil)
  end

  context 'when label is created' do
    it 'should return @label as an instance of Label' do
      expect(@label).to be_instance_of Label
    end

    it 'should have title as Love of my life' do
      expect(@label.title).to eq('Love of my life')
    end

    it 'should have items as an empty array' do
      expect(@label.items).to be_empty
    end
  end
end
