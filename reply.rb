class Reply
  def self.all
    results = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        replies
    SQL

    results.map { |result| Reply.new(result) }
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, :id => id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.id = :id
      LIMIT
        1
      SQL
      Reply.new(result.first)
  end

  def self.find_by_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, :id => user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.user_id = :id
    SQL

    results.map { |result| Reply.new(result) }
  end

  def self.find_by_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, :id => question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.user_id = :id
    SQL

    results.map { |result| Reply.new(result) }
  end

  def self.find_by_parent_id(parent_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, :id => parent_id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.parent_id = :id
    SQL

    results.map { |result| Reply.new(result) }
  end


  attr_accessor :id, :question_id, :parent_id, :user_id, :body

  def initialize(options)
    @id = options["id"]
    @question_id = options["question_id"]
    @parent_id = options["parent_id"]
    @user_id = options["user_id"]
    @body = options["body"]
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    Reply.find_by_parent_id(@id)
  end


end