require 'sqlite3'

CLUBTABLE = SQLite3::Database.new('dcdb.db')

CLUBTABLE.execute("CREATE TABLE IF NOT EXISTS eventoutings (date DATE, restaurant TEXT, attendees TEXT);")
CLUBTABLE.execute("CREATE TABLE IF NOT EXISTS members (membername TEXT, amountspent FLOAT, timesout INTEGER);")

