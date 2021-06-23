class TodosController < ApplicationController

  before_action :set_todo, only: [ :check, :show ]

  def new
    @todo = Todo.new
  end

  def index
    @todos = current_user.todos
  end

  def show
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.user = current_user
    if @todo.save!
      redirect_to root_path
    else
      render "new"
    end
  end

  def check
    if @todo.not_done?
      @todo.do_task!
    else
      @todo.undo_task!
    end
    redirect_to todos_path
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :description, :date)
  end

  def set_todo
    @todo = current_user.todos.where(id: params[:id] ).first
  end

end
