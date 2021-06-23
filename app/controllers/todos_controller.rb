class TodosController < ApplicationController

  before_action :set_todo, only: [ :check, :show, :prioritize, :unprioritize ]

  def new
    @todo = Todo.new
  end

  def index
    @todos = current_user.todos.order(priority: :asc)
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

  def prioritize
    if @todo.priority != Todo.minimum(:priority)
      priority = @todo.priority
      higher_todo = Todo.where(priority: priority - 1).first
      @todo.priority = higher_todo.priority
      higher_todo.priority += 1
      higher_todo.save
      @todo.save
      redirect_to todos_path
    end
  end

  def unprioritize
    if @todo.priority != Todo.maximum(:priority)
      priority = @todo.priority
      lower_todo = Todo.where(priority: priority + 1).first
      @todo.priority = lower_todo.priority
      lower_todo.priority -= 1
      lower_todo.save
      @todo.save
      redirect_to todos_path
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :description, :date)
  end

  def set_todo
    @todo = current_user.todos.where(id: params[:id] ).first
  end

end
