class CreateUserAttributes < ActiveRecord::Migration[6.0]
  def change
    create_table :user_attributes do |t|
      t.string :name, null: false
      t.string :data_type, null: false
      t.boolean :required_on_signup, default: false, null: false
      t.boolean :required_on_profile, default: false, null: false

      t.timestamps
      t.index 'lower(name)', unique: true
    end
  end
end
