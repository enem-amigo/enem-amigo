class QuestionsController < ApplicationController

  include QuestionsHelper

  def index
    if category_selected?
      @questions = Question.where(area: current_category)
    else
      @questions = Question.all
    end
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

  def category

  end

  def select_category
    self.category = params[:category]
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:year,:area,:number,:enunciation,:reference,:image,:alternatives_attributes => [:id, :letter, :description])
  end

end