class TodosController < ApplicationController

  def new
    @todo = Todo.new
  end

  def index
    @todos = current_user.todos
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

  private

  def todo_params
    params.require(:todo).permit(:title, :description, :date)
  end


end
