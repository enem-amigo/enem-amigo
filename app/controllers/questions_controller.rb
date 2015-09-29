class QuestionsController < ApplicationController

  include QuestionsHelper

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
    5.times { @question.alternatives.build }
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = "Questão cadastrada com sucesso!"
      redirect_to @question
    else
      render 'new'
    end
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
    unless current_user.accepted_questions.include? question.id
      if params[:alternative] == question.right_answer
        current_user.accepted_questions.push(question.id)
        current_user.update_attribute(:points, current_user.points + 4)
      end
    end
    redirect_to questions_path
  end

  def category
  end

  def natureza
    @questions = Question.where(area: "natureza")
  end

  def humanas
    @questions = Question.where(area: "humanas")
  end

  def linguagens
    @questions = Question.where(area: "linguagens")
  end

  def matematica
    @questions = Question.where(area: "matematica")
  end

  private

  def question_params
    params.require(:question).permit(:year,:area,:number,:enunciation,:reference,:image,:right_answer,:alternatives_attributes => [:id, :letter, :description])
  end

end