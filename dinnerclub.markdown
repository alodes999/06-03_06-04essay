# DinnerClub Assignment:

The assignment is to create a program to manage a DinnerClub.  This program is supposed to hold various individual clubs, and for each club, should be able to list members of the club, how much they've spent for club outings, and also list the restaurants visited and who all went to that restaurant.

To accomplish this, I wrote a DinnerClub class, which currently stores the values in two separate hashes, one hash listing the members with their hash values being the balance spent on DinnerClub outings.  The other hash stores the date of each outing and a value which is also a hash with the restaurant name as key and an array of attendees for that outing as value of that sub-hash.  

My DinnerClub class has two attributes to it, members, and "meal_list", which are the two hashes described above. 
There is one method in this class, that takes input from a user where date and restaurant are strings, cost and tip_percent are integers, attendees is an array, and treater is an optional argument, defaulting to nil.  This argument acts as a switch for my conditional statement:
```ruby

    def meal(date:, cost:, tip_percent:, attendees:, restaurant:, treater: nil)
      if treater == nil
        mealevent = CheckSplitter.new(cost: cost, num_of_diners: attendees.length, tip: tip_percent)
        amount_to_split = mealevent.split
    
        attendees.each do |a|
          @members[a] += amount_to_split
        end
      else
        mealevent = CheckSplitter.new(cost: cost, num_of_diners: 1, tip: tip_percent)
        amount_to_split = mealevent.split
        @members[treater] += amount_to_split
      end


```

for whether or not the bill should be split between one person, or the group when it is passed to my sub-class.  The rest of this method plugs the values into the prospective hashes, by using the .store method in Ruby's Hash class:

```ruby

      restaurants = {}
      restaurants.store(restaurant, attendees)
      @meal_list.store(date, restaurants)
    
      return @members
    end

``` 

CheckSplitter is my sub-class which calculates the amount to split between each person, given meal amounts, tip percentages and number of people eating.  

```ruby

    # @cost - Integer of meal cost, entered with the cost: keyword
    # @diners - Integer of the number of diners(num_of_diners) with the num_of_diners: keyword
    # @tip - Integer (or float) of the tip value, entered with the tip: keyword
    def initialize(cost:, num_of_diners:, tip:)
      @cost = cost
      @diners = num_of_diners
      @tip = tip
    end

    #figures out the split for each of the diners
    #returns a float
    def split
      splitbill = total_cost / @diners 
      splitbill = splitbill.round(2)
    end

```
total_cost in this case is a sub method to calculate the cost of the meal plus the tip.
 
In this assignment I also use an app.rb file as an interface to pull the information I need to use via puts/gets information, and to run the methods I've designed in DinnerClub.  From it, I gather the date of the event, who all attended, how much the meal cost, how much of a tip was there, and whether the meal was a treat from one person or not, and if so, who did the treating:

```ruby

    puts "Did anyone treat the group?"
    treat_choice = gets.chomp
    if treat_choice == "yes"
      puts "Which member treated the group?"
      treater = gets.chomp
      attendees_array = attendees.split(", ")
      puts club1.meal(date: date, cost: cost, tip_percent: tip_per, attendees: attendees_array, restaurant: where_we_ate, treater: treater)
    else
      attendees_array = attendees.split(", ")
      puts club1.meal(date: date, cost: cost, tip_percent: tip_per, attendees: attendees_array, restaurant: where_we_ate)
    end

```
I use a while loop to enable multiple event entry, so when we say yes when prompted if we want to add a meal or additional meals, it loops through to add another event, and when we say something other than yes, it ends the loop and gives us our final values for that club.
