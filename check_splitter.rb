class CheckSplitter
  attr_reader :cost, :diners, :tip
  # @cost - Integer of meal cost, entered with the cost: keyword
  # @diners - Integer of the number of diners(num_of_diners) with the num_of_diners: keyword
  # @tip - Integer (or float) of the tip value, entered with the tip: keyword
  def initialize(cost:, num_of_diners:, tip:)
    @cost = cost
    @diners = num_of_diners
    @tip = tip
  end
  
  #sets the tip value into a float no matter the value added  
  def tip_calc
    if @tip >= 1 
      @tip / 100.0
    else
      @tip
    end
  end
  
  #figures out the total cost
  #returns a float
  def total_cost
    overallcost = @cost * (tip_calc + 1)
    overallcost = overallcost.round(2)
  end
  
  #figures out the split for each of the diners
  #returns a float
  def split
    splitbill = total_cost / @diners 
    splitbill = splitbill.round(2)
  end

end