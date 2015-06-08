require_relative 'dinner_club_multitreat'
#Script that uses the dinner_club and check_splitter classes
#
#Lines 5-8 set the array of members in the dinner_club
puts "Who is in this dinner club?  Please enter a list separated with commas:"
people = gets.chomp

club1 = DinnerClub.new(people.split(", "))
#This block allows for multiple meals to be entered, with prompts for the user to enter their info
puts "Enter a meal? (Please enter yes or no)"
choice = gets.chomp
while choice == "yes"
  puts "What date is this? (If there is more than one meal on a day, please enter a -1 or -2 after the next, etc)"
  date = gets.chomp
  
  puts "Enter the meal cost:"
  cost = gets.chomp.to_i
  
  puts "Enter the tip percent given:"
  tip_per = gets.chomp.to_i
  
  puts "Enter the attendees who went:"
  attendees = gets.chomp
  
  puts "Where did the group eat?"
  where_we_ate = gets.chomp
  #This conditional loop allows for a user to define whether or not there is a treater of the group (one person paying for the whole group)
  puts "Did anyone treat the group?"
  treat_choice = gets.chomp
  if treat_choice == "yes"
    puts "Which member or members treated the group?"
    treater = gets.chomp
    attendees_array = attendees.split(", ")
    treater_array = treater.split(", ")
    puts club1.meal(date: date, cost: cost, tip_percent: tip_per, attendees: attendees_array, restaurant: where_we_ate, treater: treater_array)
  else
    attendees_array = attendees.split(", ")
    puts club1.meal(date: date, cost: cost, tip_percent: tip_per, attendees: attendees_array, restaurant: where_we_ate)
  end
  
  puts "Enter another meal?"
  choice = gets.chomp
end
#This outputs the list of members and their balances, and the list of restaurants and attendees keyed to the date they were attended.
puts club1.members
puts club1.meal_list