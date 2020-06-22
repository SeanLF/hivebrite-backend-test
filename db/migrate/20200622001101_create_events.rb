class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.json :custom_attributes

      t.timestamps
    end
  end
end
