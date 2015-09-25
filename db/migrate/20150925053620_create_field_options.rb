class CreateFieldOptions < ActiveRecord::Migration
  def change
    create_table :field_options do |t|
      t.string :value
      t.string :label
      t.string :type
      t.references :field

      t.timestamps null: false
    end
  end
end
