class AddIndexesToTasks < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, [:name, :status]
  end
end
