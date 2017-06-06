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
    skip
    r = Recipe.new("Spicy Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry
    pantry.add_to_shopping_list(r)
    result = r.ingredients
    assert_equal pantry.shopping_list, r.ingredients
  end


end

#
# r = Recipe.new("Spicy Cheese Pizza")
# r.add_ingredient("Cayenne Pepper", 0.025)
# r.add_ingredient("Cheese", 75)
# r.add_ingredient("Flour", 500)
# pantry = Pantry.new
# require 'pry'; binding.pry
