module ExamsHelper

  def generate_right_answers exam, index
    right_answers = []
      exam.questions[index].each do |t|
        if index == 0
          right_answers.push(@humans_questions[t].right_answer)
        elsif index == 1
          right_answers.push(@math_questions[t].right_answer)
        elsif index == 2
          right_answers.push(@language_questions[t].right_answer)
        elsif index == 3
          right_answers.push(@nature_questions[t].right_answer)
        end
      end
    right_answers
  end

end
