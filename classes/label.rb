class Label
    attr_accessor :name, :item

    def initialize(name)
      @name = name
      @item = nil  # Initialize item as nil
    end

    def associate_item(item)
      @item = item
      item.labels << self
    end
  end
