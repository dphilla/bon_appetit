require_relative 'recipe'

class Pantry
  attr_reader :stock, :r, :shopping_list

  def initialize
    @stock = {}
    @r = Recipe.new #this needs to be more dynamic, take out
    @shopping_list = shopping_list
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
    r.ingredients.map do |key, value|
      if value > 100
        r.ingredients[key] = {quantity: (value / 100), units: "Centi-Units"}
      elsif value < 1
        r.ingredients[key] = {quantity: (value * 1000), units: "Milli-Units"}
      else
        r.ingredients[key] = {quantity: value, units: "Universal Units"}
      end
    end
    r.ingredients
  end

  def add_to_shopping_list(r)
    if @shopping_list == nil
      @shopping_list =  r.ingredients
    elsif
      r.ingredients.map do |key, value|
        if key != @shopping_list.key
          @shopping_list[key] = value
        else
          @shopping_list[key] = @shopping_list[key] + value
        end
      end
    end
    @shopping_list
  end


  def print_shopping_list
    @shopping_list.each { |key, value| puts "#{key}: #{value}"}
  end


end
