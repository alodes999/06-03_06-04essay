require 'sqlite3'

# Creates or connects to our database "splitterdb.db"
SPLITTER = SQLite3::Database.new('splitterdb.db')
# Creates our table "meals" in our database
SPLITTER.execute('CREATE TABLE IF NOT EXISTS meals (id INTEGER PRIMARY KEY, mealcost INTEGER, numberdiners INTEGER, tip FLOAT);')
# Shows our results as a hash.
SPLITTER.results_as_hash = true;
# This method ensures our entered tip gets passed into our DB as a float.  This method is referenced in our
# row storing method.
#
# This method may take 1 argument, either a Float or Integer.  If an Integer, divides by 100.0, to return a decimal Float
# If a Float, returns the entered Float.  If no argument is passed, returns a default Float value of 0.15.
#
# This method returns a float
def tip_to_use(entered_tip = 0.15)
  if entered_tip >= 1
    tip_use = entered_tip / 100.0
  else
    entered_tip > 0
    tip_use = entered_tip
  end
end

# Creates meal rows in our database using the defined parameters
def add_meal(cost, num_of_diners, given_tip)
  SPLITTER.execute("INSERT INTO meals (mealcost, numberdiners, tip) VALUES (#{cost}, #{num_of_diners}, #{tip_to_use(given_tip)});")
end
# Checks our table for all meals entered
def check_meals
  SPLITTER.execute("SELECT * FROM meals;")
end
# This method checks our table at a certain id entered, and calculates the total amount plus tip to split.
#
# This method takes 1 argument, an Integer of the id of the table row to use.  The primary use of this is to be referenced in our
# split_cost method
#
# This method returns a Float of our total meal cost
def total_to_split(id)
  grabber = SPLITTER.execute("SELECT * FROM meals WHERE id = #{id};")
  cost = grabber.first["mealcost"]
  tip = grabber.first["tip"]
  (1 + tip) * cost
end
# This method figures out the split amount of each payee.  It references the total_to_split method to figure out the amount to split
#
# This method takes 1 argument, the Integer id where the record is we want to calculate
#
# This method returns a Float of the amount each person pays.
def split_cost(id)
  splitd = SPLITTER.execute("SELECT numberdiners FROM meals WHERE id = #{id}")
  splitd = splitd.first["numberdiners"]
  total_to_split(id) / splitd
end