class AddPriorityToTodo < ActiveRecord::Migration[6.0]
  def change
    add_column :todos, :priority, :integer, default: 0
  end
end
