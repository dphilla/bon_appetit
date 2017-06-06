require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/recipe'

class PantryTest < Minitest::Test
  attr_reader :pantry

  def setup
    @pantry = Pantry.new
  end

  def test_it_exists
    assert_instance_of Pantry, Pantry.new
  end

  def test_stock_is_empty
    assert_equal pantry.stock, {}
  end

  def test_stock_check_0
    assert_equal pantry.stock_check("Cheese"), 0
  end

  def test_stock_can_add_one_item
    pantry.restock("Cheese", 10)
    assert_equal pantry.stock_check("Cheese"), 10
  end

  def test_can_add_to_existing_stock
    pantry.restock("Cheese", 10)
    assert_equal pantry.stock_check("Cheese"), 10
    pantry.restock("Cheese", 20)
    assert_equal pantry.stock_check("Cheese"), 30
  end

  def test_can_convert_units
    r = Recipe.new("Spicy Cheese Pizza")
    r.add_ingredient("Cayenne Pepper", 0.025)
    r.add_ingredient("Cheese", 75)
    r.add_ingredient("Flour", 500)
    result ={ "Cayenne Pepper" => {quantity: 25, units: "Milli-Units"},
              "Cheese"         => {quantity: 75, units: "Universal Units"},
              "Flour"          => {quantity: 5, units: "Centi-Units"}}
    assert_equal pantry.convert_units(r), result
  end

  def test_can_add_to_shopping_list
    r = Recipe.new("Spicy Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r)
    result = r.ingredients
    assert_equal pantry.shopping_list, r.ingredients
  end

  def test_can_can_add_more_to_shopping_list
    r = Recipe.new("Spicy Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r)
    result = r.ingredients
    assert_equal pantry.shopping_list, r.ingredients
    r = Recipe.new("Spaghetti")
    r.add_ingredient("Noodles", 10)
    r.add_ingredient("Sauce", 10)
    r.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r)
    result = {"Cheese" => 25, "Flour" => 20, "Noodles" => 10, "Sauce" => 10}
  assert_equal pantry.shopping_list, result
  end

  def test_can_print_shopping_list
    r = Recipe.new("Spicy Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r)
    result = r.ingredients.each { |key, value| puts "#{key}: #{value}"}
    assert_equal pantry.print_shopping_list,result
  end
end
