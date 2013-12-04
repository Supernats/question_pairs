class User

  def self.all
    results = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        users
    SQL

    results.map { |result| User.new(result) }
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, :id => id)
      SELECT
        *
      FROM
        users
      WHERE
        users.id = :id
      SQL
      User.new(result)
  end

  def self.find_by_fname(fname)
    result = QuestionsDatabase.instance.execute(<<-SQL, :fname => fname)
      SELECT
        *
      FROM
        users
      WHERE
        users.fname = :fname
      SQL
      User.new(result)
  end

  def self.find_by_lname(lname)
    result = QuestionsDatabase.instance.execute(<<-SQL, :lname => lname)
      SELECT
        *
      FROM
        users
      WHERE
        users.lname = :lname
      SQL
      User.new(result)
  end

  attr_accessor :id, :fname, :lname

  def initialize(options)
    @id = options["id"]
    @fname = options["fname"]
    @lname = options["lname"]
  end

end



