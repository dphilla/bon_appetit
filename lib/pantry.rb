

class Pantry
  attr_reader :stock

  def initialize
    @stock = {}
  end

  def stock_check(item)
    if @stock[item] == nil
      return 0
    else
      @stock[item]
    end 
  end

  def restock(item, amount)

  end

end
