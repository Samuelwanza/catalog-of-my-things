require 'rspec'
require_relative '../classes/book'

describe Book do
  before :each do
    @book = Book.new('1-2-2023', 'publisher A', 'bad')
  end
  context 'When a book is created it ' do
    it 'should return @book as instance of Books' do
      expect(@book).to be_instance_of Book
    end
  end

  it 'should have publisher A as the publisher' do
    expect(@book.publisher).to eq('publisher A')
  end
end
