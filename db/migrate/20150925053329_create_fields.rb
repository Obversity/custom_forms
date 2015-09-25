class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :field_type
      t.string :label
      t.text :hint
      t.integer :ordinal
      t.boolean :required
      t.text :placeholder
      t.string :class_name
      t.string :wrapper_class
      t.references :form

      t.timestamps null: false
    end
  end
end
