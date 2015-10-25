module QuestionsHelper

  def category=(category)
    session[:category] = category
  end

  def current_category
    session[:category]
  end

  def category_selected?
    !!current_category
  end

  class Parser
    class << self

      def read_questions json_questions
        questions = JSON.parse(json_questions)["questions"]
        questions.each do |question|
          q = Question.new
          question.each do |attr, value|
            if value.is_a? Hash
              5.times do |i|
                q.alternatives.build
                q.alternatives[i].letter = value.keys[i]
                q.alternatives[i].description = value[value.keys[i]]
              end
            else
              eval "q.#{attr} = value"
            end
          end
          q.save
          t = Topic.create(name: "Questão #{q.number} - Ano #{q.year}", question_id: q.id, post_at: Time.now, description: "Dúvidas e respostas sobre a questão #{q.number} da prova do ano #{q.year}")
        end
      end

      def read_candidates_data candidates_data, test_year
        candidates_data.each_line do |line|
          next if line == "\n"
          student_responses = line[/(A|B|C|D|E|'*'){180}/, 0]
          enem_feedback = line[/(0|1){1}(A|B|C|D|E){185}/, 0]
          test_booklet_types = line[/[0-9]{13}(A|B|C|D|E){185}/, 0]
          test_booklet_types_array = test_booklet_types.scan /.{3}/
          language_choice = enem_feedback.slice!(0).to_i
          enem_feedback.slice!(95 - (5 * language_choice), 5)
          student_hits = 0
          180.times do |i|
            question = Question.where(number: i, year: test_year).take
            next if question.nil?
            if student_responses[i] == enem_feedback[i]
              student_hits += 1
              question.hits += 1
            end
            question.tries += 1
            question.save
          end
          Candidate.create general_average: (100 * student_hits.to_f / 180).round(2)
        end
      end
    end
  end

end