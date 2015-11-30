class QuestionsController < ApplicationController

  before_action :authenticate_user
  before_action :authenticate_admin, only: [ :new, :create, :edit, :destroy, :update ]

  include QuestionsHelper

  def index
    @questions = Question.all.order(:year, :number)
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(question_params)
      flash[:success] = "Questão atualizada com sucesso!"
      redirect_to question_path
    else
      render 'edit'
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:success] = "Questão deletada com sucesso!"
    redirect_to questions_path
  end

  def answer
    question = Question.find(params[:id])
    @answer_letter = params[:alternative]

    if params[:alternative].blank?
      redirect_to_back(root_path)
    else
      current_user.update_attribute(:tried_questions, current_user.tried_questions << question.id)
      question.update_attribute(:users_tries, question.users_tries + 1)

      @correct_answer = (@answer_letter == question.right_answer)

      respond_to do |format|
        format.html { redirect_to questions_path }
        format.js { @correct_answer }
      end

      if @correct_answer
        question.update_attribute(:users_hits, question.users_hits + 1)
        unless current_user.accepted_questions.include? question.id
          current_user.accepted_questions.push(question.id)
          current_user.update_attribute(:points, current_user.points + 4)
        end
      end
    end
  end

  def category
  end

  def nature
    @questions = Question.where(area: "ciências da natureza e suas tecnologias").order(:year, :number)
  end

  def humans
    @questions = Question.where(area: "ciências humanas e suas tecnologias").order(:year, :number)
  end

  def languages
    @questions = Question.where(area: "linguagens, códigos e suas tecnologias").order(:year, :number)
  end

  def math
    @questions = Question.where(area: "matemática e suas tecnologias").order(:year, :number)
  end

  def recommended
    areas = ["ciências da natureza e suas tecnologias",
             "ciências humanas e suas tecnologias",
             "linguagens, códigos e suas tecnologias",
             "matemática e suas tecnologias"]
    @questions = []
    areas.each do |area|
      classification = current_user.classification(area)
      @questions = @questions | instance_eval("Question.#{classification}_questions('#{area}')")
    end
    @questions = @questions.select { |q| !current_user.accepted_questions.include? q.id }
  end

  def upload_questions
    uploaded_file = params[:questions_file]

    raise Exception if uploaded_file.nil?

    file_content = uploaded_file.read

    Parser.read_questions(file_content)

    flash[:success] = "Questões armazenadas com sucesso."
    redirect_to questions_path
  end

  def upload_candidates_data
    uploaded_file = params[:candidates_data_file]

    raise Exception if uploaded_file.nil?

    file_content = uploaded_file.read

    Parser.read_candidates_data(file_content, params[:test_year])

    flash[:success] = "Dados armazenados com sucesso."
    redirect_to questions_path
  end

  def next_question
    redirect_to Question.find(params[:id]).next_question
  end

  private

  def question_params
    params.require(:question).permit(:year,:area,:number,:enunciation,:reference,:image,:right_answer,:alternatives_attributes => [:id, :letter, :description])
  end

end
