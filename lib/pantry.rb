require_relative 'recipe'

class Pantry
  attr_reader :stock, :r

  def initialize
    @stock = {}
    @r = Recipe.new("Spicy Cheese Pizza")
    r.add_ingredient("Cayenne Pepper", 0.025)
    r.add_ingredient("Cheese", 75)
    r.add_ingredient("Flour", 500)
  end

  def stock_check(item)
    if @stock[item] == nil
      return 0
    else
      @stock[item]
    end
  end

  def restock(item, amount)
    if @stock[item] == nil
      @stock[item] = amount
    else
      @stock[item] = @stock[item] + amount
    end
  end

  def convert_units(r)
    @r.ingredients.map do |key, value|
      if value > 100
        @r.ingredients[key] = {quantity: (value / 100), units: "Centi-Units"}
      elsif value < 1
        @r.ingredients[key] = {quantity: (value * 1000), units: "Milli-Units"}
      else
        @r.ingredients[key] = {quantity: value, units: "Universal Units"}
      end
    end
    @r.ingredients
  end
end
