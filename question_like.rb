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
      SQL
      QuestionLike.new(result)
  end

  attr_accessor :id, :question_id, :user_id
  def initialize(options)
    @id = options["id"]
    @question_id = options["question_id"]
    @user_id = options["user_id"]
  end
end