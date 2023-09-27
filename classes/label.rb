class Label
  attr_accessor :name, :item

  def initialize(name)
    @name = name
    @item = nil # Initialize item as nil
  end

  def add_item(item)
    if item.is_a?(Item)
      @item = item
      item.add_label(self)
    else
      puts 'Invalid item type. Expected an instance of Item class.'
    end
  end
end
