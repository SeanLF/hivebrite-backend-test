class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.text :username, null: false
      t.text :password, null: false
      t.boolean :admin, default: false, null: false

      t.timestamps
      t.index 'lower(username)', unique: true
    end
  end
end
