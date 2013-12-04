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
      SQL
      Reply.new(result)
  end

  attr_accessor :id, :question_id, :parent_id, :user_id, :body

  def initialize(options)
    @id = options["id"]
    @question_id = options["question_id"]
    @parent_id = options["parent_id"]
    @user_id = options["user_id"]
    @body = options["body"]
  end
end