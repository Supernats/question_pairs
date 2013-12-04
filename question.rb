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
      SQL
      Question.new(result)
  end

  attr_accessor :id, :title, :body, :user_id

  def initialize(options)
    @id = options["id"]
    @title = options["title"]
    @body = options["body"]
    @user_id = options["user_id"]
  end

end

p Question.all