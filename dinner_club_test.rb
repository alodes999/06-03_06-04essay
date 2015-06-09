require 'minitest/autorun'
require_relative 'dinner_club_multitreat'
require_relative 'check_splitter'

class DinnerClubTest < MiniTest::Test
  #Setup our future test instance
  def setup
    @tester = DinnerClub.new(["Jim", "Tom"])
  end
  # Tests our DinnerClub initialize output
  def test_initialize
    assert(@tester.members == {"Jim" => 0, "Tom" => 0})
    assert(@tester.meal_list == {})
  end
  # Tests our DinnerClub attributes after an instance of the meal method
  def test_meal
    @tester.meal(date: "06-05", cost: 40, tip_percent: 15, attendees: ["Jim", "Tom"], restaurant: "Sudz")
    assert(@tester.members == {"Jim" => 23.0, "Tom" => 23.0})
    assert(@tester.meal_list == {"06-05" => {"Sudz" => ["Jim", "Tom"]}})
  end
end