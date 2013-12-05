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
      LIMIT
        1
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
      LIMIT
        1
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

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    result = QuestionsDatabase.instance.execute(<<-SQL, :user_id => @id)
    SELECT
      (COUNT(question_likes.id)*1.0)/(COUNT(questions.id)*1.0) AS average_karma
    FROM
      questions
    LEFT JOIN
      question_likes ON questions.id = question_likes.question_id
    JOIN
      users ON questions.user_id = users.id
    WHERE
      users.id = :user_id
    LIMIT
      1
    SQL

    result.first["average_karma"]
  end

  def save
    raise "already saved" unless self.id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, :fname => @fname, :lname => @lname)
      INSERT INTO
        users (fname, lname)
      VALUES
        (:fname, :lname)
      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
  end
end





