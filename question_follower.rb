class QuestionFollower
  def self.all
    results = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        question_followers
    SQL

    results.map { |result| QuestionFollower.new(result) }
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, :id => id)
      SELECT
        *
      FROM
        question_followers
      WHERE
        question_followers.id = :id
      LIMIT
        1
      SQL
      QuestionFollower.new(result.first)
  end

  def self.followers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, :id => question_id)
      SELECT
        *
      FROM
        users
      JOIN
        (SELECT
          user_id
        FROM
          question_followers
        WHERE
          question_followers.question_id = :id) AS followers
      ON users.id = followers.user_id
      SQL

    results.map { |result| User.new(result) }
  end

  def self.followed_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, :id => user_id)
      SELECT
        *
      FROM
        questions
      JOIN
        (SELECT
          question_id
         FROM
          question_followers
         WHERE
          question_followers.user_id = :id
         ) AS questions_followed
       ON questions.id = questions_followed.question_id
    SQL

    results.map { |result| Question.new(result) }
  end

  attr_accessor :id, :user_id, :question_id

  def initialize(options)
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
  end
end