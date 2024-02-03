class GroceryStore
  attr_reader :items

  def initialize
    @items = Hash.new(0)
  end

  def purchase(input)
    input.split(',').each { |item| @items[item.strip.capitalize] += 1 }
  end
end