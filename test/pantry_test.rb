require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

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
end

pantry = Pantry.new
require 'pry'; binding.pry
