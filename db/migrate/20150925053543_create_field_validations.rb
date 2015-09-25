class CreateFieldValidations < ActiveRecord::Migration
  def change
    create_table :field_validations do |t|
      t.integer :validation_id
      t.references :field

      t.timestamps null: false
    end
  end
end
