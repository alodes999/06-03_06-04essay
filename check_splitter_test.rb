require 'minitest/autorun'
require_relative 'check_splitter.rb'

class CheckSplitterTest < MiniTest::Test
  
  def setup
    @check_test = CheckSplitter.new(cost: 40, num_of_diners: 3, tip: 15)
  end
  # tests that cost is set as an integer
  def test_cost
    
    assert_equal(@check_test.cost, @check_test.cost.to_i)
  end
  # tests that num_of_diners is set as an integer
  def test_diners
    
    assert_equal(@check_test.diners, @check_test.diners.to_i)
  end
  #tests to make sure a default is set as a tip.
  def test_tip
  
    assert_equal(@check_test.tip, @check_test.tip.to_i)
  end
  # one of my specs should check to ensure tip returns a float.
  def test_tip_method
    assert_equal(0.15, @check_test.tip_calc)
  end
  # one of my specs should check to ensure total_cost returns and rounds a float.
  def test_total_cost
    assert_equal(46.0, @check_test.total_cost)
  end
  # one of my specs should check to ensure split returns and rounds a float.
  def test_split
    assert_equal((46 / 3.0).round(2), @check_test.split.to_f)
  end
end
