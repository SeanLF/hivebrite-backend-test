class CreateEventRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :event_registrations do |t|
      t.references :event, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.index %i[user_id event_id], unique: true

      t.timestamps
    end
  end
end
