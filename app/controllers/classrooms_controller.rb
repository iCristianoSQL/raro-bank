class ClassroomsController < ApplicationController
  before_action :set_classroom, only: %i[show edit update destroy]
  before_action :authenticate_administrator!

  def index
    @classrooms = Classroom.all
  end

  def show
    @students = @classroom.users
  end

  def new
    @classroom = Classroom.new
  end

  def edit
  end

  def create
    @classroom = Classroom.new(classroom_params)

    respond_to do |format|
      if @classroom.save
        format.html { redirect_to classroom_url(@classroom), notice: "Turma criada com sucesso." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @classroom.update(classroom_params)
        format.html { redirect_to classroom_url(@classroom), notice: "Turma atualizada com sucesso." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @classroom.destroy

    respond_to do |format|
      format.html { redirect_to classrooms_url, notice: "Turma excluída com sucesso." }
    end
  end

  private

  def set_classroom
    @classroom = Classroom.find(params[:id])
  end

  def classroom_params
    params.require(:classroom).permit(:name)
  end

  private

  def authenticate_administrator!
    unless current_user.administrator?
      flash[:alert] = "Acesso negado. Você não é um administrador."
      redirect_to root_path
    end
  end

end
