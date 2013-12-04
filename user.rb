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
      User.new(result.first)
  end

  def self.find_by(fname, lname)
    result = QuestionsDatabase.instance.execute(<<-SQL, :fname => fname, :lname => lname)
      SELECT
        *
      FROM
        users
      WHERE
        users.fname = :fname AND users.lname = :lname
      SQL
      User.new(result)
  end

  attr_accessor :id, :fname, :lname

  def initialize(options)
    p options
    @id = options["id"]
    @fname = options["fname"]
    @lname = options["lname"]
  end

  def authored_questions
    Question.find_by_user_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(@id)
  end
end





