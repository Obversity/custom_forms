class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.text :data
      t.string :ip
      t.references :form

      t.timestamps null: false
    end
  end
end
