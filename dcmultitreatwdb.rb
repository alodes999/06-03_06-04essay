class DinnerClub

  CLUBTABLE = SQLite3::Database.new("'#{clubname}'dcdb.db")

  CLUBTABLE.execute("CREATE TABLE IF NOT EXISTS eventoutings (date DATE, restaurant TEXT, attendees TEXT);")
  CLUBTABLE.execute("CREATE TABLE IF NOT EXISTS members (membername TEXT, amountspent FLOAT, timesout INTEGER);")
  
  attr_reader :members, :meal_list
  # member_name  - Array of names to plug into @members
  #
  # @members - Hash of names and total bills
  # @meal_list - Hash of dates, and restaurant hashes
  def initialize(member_name, clubname)
    @members = {}
    @meal_list = {}
    @clubname = clubname
    
    member_name.each do |name|
      CLUBTABLE.execute("INSERT INTO members (name, amountspent, timesout) VALUES ('#{name}', 0.0, 0);")
    end
  end
  # meal is each event where people go out and add to their club balance
  #
  # date - String of what the date the meal occurs on
  # cost - Integer of price of meal
  # tip_percent - Integer of percentage of tip paid
  # attendees - Array of people attending each meal
  # restaurant - Name of restaurant club is attending
  # treater - String of a person treating the group,  Defaults to nil.  Will adjust only one member's total if there is a value.
  #
  # Modifies the @meal_list hash, adding in the date as a Hash key, and a Hash of restaurant visited as key and attendee array as value, as value
  #
  # Returns the updated @members hash
  def meal(date:, cost:, tip_percent:, attendees:, restaurant:, treater: nil)
    if treater == nil
      mealevent = CheckSplitter.new(cost: cost, num_of_diners: attendees.length, tip: tip_percent)
      amount_to_split = mealevent.split
    
      attendees.each do |a|
        @members[a] += amount_to_split
      end
    else
      mealevent = CheckSplitter.new(cost: cost, num_of_diners: treater.length, tip: tip_percent)
      amount_to_split = mealevent.split
      
      treater.each do |a|
        @members[a] += amount_to_split
      end
    end
    
    restaurants = {}
    restaurants.store(restaurant, attendees)
    @meal_list.store(date, restaurants)
    
    return @members
  end
end