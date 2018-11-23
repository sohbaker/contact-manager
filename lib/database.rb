require 'pg'

class Database

  def initialize
    conn = PG.connect(
      dbname: 'postgres',
      host: 'localhost',
      user: 'postgres',
      password: 'dataadmin')
    results = conn.exec("SELECT * FROM fruits")

    puts results.getvalue(0,0)
  end
end
