class CreateUserAttributeValues < ActiveRecord::Migration[6.0]
  def change
    create_table :user_attribute_values do |t|
      t.references :user, null: false, foreign_key: true
      t.references :user_attribute, null: false, foreign_key: true
      t.text :value, null: false

      t.timestamps
      t.index %i[user_id user_attribute_id], unique: true
    end
  end
end
