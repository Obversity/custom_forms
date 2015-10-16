class RemoveColumnsFromFieldOptions < ActiveRecord::Migration
  def up
    remove_column :field_options, :type
  end

  def down
    add_column :field_options, :type, :string
  end
end
