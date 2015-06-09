require 'minitest/autorun'
require_relative 'dinner_club_multitreat'
require_relative 'check_splitter'

class DinnerClubTest < MiniTest::Test
  
  def setup
    @tester = DinnerClub.new(["Jim", "Tom"])
  end
  
  def test_initialize
    assert(@tester.members == {"Jim" => 0, "Tom" => 0})
    assert(@tester.meal_list == {})
  end
  
  def test_meal
    @tester.meal(date: "06-05", cost: 40, tip_percent: 15, attendees: ["Jim", "Tom"], restaurant: "Sudz")
    assert(@tester.members == {"Jim" => 23.0, "Tom" => 23.0})
    assert(@tester.meal_list == {"06-05" => {"Sudz" => ["Jim", "Tom"]}})
  end
end