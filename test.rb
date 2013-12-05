require_relative 'questions_database'
require_relative 'question'
require_relative 'reply'
require_relative 'question_follower'
require_relative 'question_like'
require_relative 'user'
#
nathan = User.find_by_id(1)
# p nathan_followed_quest = nathan.followed_questions
# nathan_followed_quest.first.followers
#
# p followed_questions = QuestionFollower.most_followed_questions(1)
#
# p followed_questions[0].followers
# p followed_questions[1].followers
# p QuestionFollower.followers_for_question_id(1)
# p QuestionLike.num_likes_for_question_id(2).class

p nathan.average_karma
