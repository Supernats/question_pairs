require_relative 'questions_database'

class Question

  def self.all
    results = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        questions
    SQL

    results.map { |result| Question.new(result) }
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, :id => id)
      SELECT
        *
      FROM
        questions
      WHERE
        questions.id = :id
      LIMIT
        1
      SQL
    Question.new(result.first)
  end

  def self.find_by_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, :id => user_id)
      SELECT
        *
      FROM
        questions
      WHERE
        questions.user_id = :id
    SQL

    results.map { |result| Question.new(result) }
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end
  attr_accessor :id, :title, :body, :user_id

  def initialize(options)
    @id = options["id"]
    @title = options["title"]
    @body = options["body"]
    @user_id = options["user_id"]
  end

  def author
    User.find_by_id(@user_id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollower.followers_for_question_id(@id)
  end
end