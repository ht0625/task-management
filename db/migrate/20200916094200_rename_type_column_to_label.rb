class RenameTypeColumnToLabel < ActiveRecord::Migration[5.2]
  def change
    rename_column :labels, :type, :label_type
  end
end
