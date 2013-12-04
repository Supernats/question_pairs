require_relative 'questions_database'
require_relative 'question'
require_relative 'reply'
require_relative 'question_follower'
require_relative 'question_like'
require_relative 'user'

nathan = User.find_by_id(1)
p nathan_followed_quest = nathan.followed_questions
nathan_followed_quest.first.followers