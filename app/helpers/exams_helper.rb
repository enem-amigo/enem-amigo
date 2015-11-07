module ExamsHelper

  def generate_random_exam
    exam = Exam.new

    math_questions = Question.where(area: "matemática e suas tecnologias")
    humans_questions = Question.where(area: "ciências humanas e suas tecnologias")
    language_questions = Question.where(area: "linguagens, códigos e suas tecnologias")
    nature_questions = Question.where(area: "ciências da natureza e suas tecnologias")
    
    exam.questions.push((0...humans_questions.count).to_a.sample 22)
    exam.questions.push((0...math_questions.count).to_a.sample 22)
    exam.questions.push((0...language_questions.count).to_a.sample 23)
    exam.questions.push((0...nature_questions.count).to_a.sample 23)
    exam.save
    exam
  end

  def generate_exam exam_year
    exam = Question.where(year: exam_year)
  end

end