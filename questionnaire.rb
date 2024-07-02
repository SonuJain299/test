require "pstore" # https://github.com/ruby/pstore

STORE_NAME = "tendable.pstore"
store = PStore.new(STORE_NAME)
attr_accessor :answer_list
QUESTIONS = {
  "q1" => "Can you code in Ruby?",
  "q2" => "Can you code in JavaScript?",
  "q3" => "Can you code in Swift?",
  "q4" => "Can you code in Java?",
  "q5" => "Can you code in C#?"
}.freeze

 
def do_prompt
# Ask each question and get an answer from the user's input.
  answers = []
  QUESTIONS.each do |question_key, question|
    print "#{question} "
    ans = gets.chomp
    answers.push ans
  end
  store_answers(answers)
end

def store_answers(answers)
  store = PStore.new(STORE_NAME)
  store.transaction do
    store[:answers] = answers
  end
end

def do_report
  store = PStore.new(STORE_NAME)
  store.transaction do
    answers = store[:answers]
    if answers.empty?
      puts "No answers found!!"
    else   
        que = QUESTIONS.to_a  
        answers.each_with_index do |answer,question_key|
          puts "#{que[question_key][1]}: #{answer}"
        end
    end
  end
end

do_prompt
do_report