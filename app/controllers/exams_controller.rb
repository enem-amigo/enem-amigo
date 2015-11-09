class ExamsController < ApplicationController

  include ExamsHelper

  def random_exam
    @exam = Exam.new
    exam_right_answers = []

    @math_questions = Question.where(area: "matemática e suas tecnologias")
    @humans_questions = Question.where(area: "ciências humanas e suas tecnologias")
    @language_questions = Question.where(area: "linguagens, códigos e suas tecnologias")
    @nature_questions = Question.where(area: "ciências da natureza e suas tecnologias")

    @exam.questions.push((0...@humans_questions.count).to_a.sample 22)
    exam_right_answers.push(generate_right_answers(@exam, 0))
    @exam.questions.push((0...@math_questions.count).to_a.sample 22)
    exam_right_answers.push(generate_right_answers(@exam, 1))
    @exam.questions.push((0...@language_questions.count).to_a.sample 23)
    exam_right_answers.push(generate_right_answers(@exam, 2))
    @exam.questions.push((0...@nature_questions.count).to_a.sample 23)
    exam_right_answers.push(generate_right_answers(@exam, 3))
    @exam.save
    @exam
  end

  def exam_result
    exam_answers = []

    puts '='*80
    puts params[:exam_id]
    puts '='*80

    for i in 0...4
      puts Exam.last.questions[i]
    end

    for i in 0...4
      if i == 0
        Exam.last.questions[i].each do |t|
          exam_answers.push(params[:"alternative_#{Question.where(area: "ciências humanas e suas tecnologias")[t].id}"])
        end
      elsif i == 1
        Exam.last.questions[i].each do |t|
          exam_answers.push(params[:"alternative_#{Question.where(area: "matemática e suas tecnologias")[t].id}"])
        end
      elsif i == 2
        Exam.last.questions[i].each do |t|
          exam_answers.push(params[:"alternative_#{Question.where(area: "linguagens, códigos e suas tecnologias")[t].id}"])
        end
      elsif i == 3
        Exam.last.questions[i].each do |t|
          exam_answers.push(params[:"alternative_#{Question.where(area: "ciências da natureza e suas tecnologias")[t].id}"])
        end
      end
    end

    puts '#'*80
    puts exam_answers
  end

end
