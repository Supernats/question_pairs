class QuestionLike
  def self.all
    results = QuestionsDatquestion_likesabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        question_likes
    SQL

    results.map { |result| QuestionLike.new(result) }
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, :id => id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        question_likes.id = :id
      LIMIT
        1
      SQL
      QuestionLike.new(result.first)
  end

  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase
      .instance.execute(<<-SQL, :question_id => question_id)
      SELECT
        users.*
      FROM
        question_likes
      JOIN
        users ON question_likes.user_id = users.id
      WHERE
        question_likes.question_id = :question_id
      SQL

    results.map { |result| User.new(result) }
  end

  def self.num_likes_for_question_id(question_id)
    result = QuestionsDatabase
      .instance.execute(<<-SQL, :question_id => question_id)
      SELECT
        COUNT(*)
      FROM
        question_likes
      WHERE
        :question_id = question_likes.question_id
      SQL
    result.first["COUNT(*)"]
  end

  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, :user_id => user_id)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      WHERE
        question_likes.user_id = :user_id
      SQL

    results.map { |result| Question.new(result) }
  end

  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, :n => n)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        :n
      SQL

    results.map { |result| Question.new(result) }
  end

  attr_accessor :id, :question_id, :user_id

  def initialize(options)
    @id = options["id"]
    @question_id = options["question_id"]
    @user_id = options["user_id"]
  end
end