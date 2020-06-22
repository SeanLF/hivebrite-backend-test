class CreateEventRegistrationAttributes < ActiveRecord::Migration[6.0]
  def change
    create_table :event_registration_attributes do |t|
      t.references :event, null: false, foreign_key: true
      t.string :name, null: false
      t.string :data_type, null: false
      t.boolean :required, default: false, null: false

      t.timestamps
      t.index [:event_id, 'lower(name)'],
              unique: true,
              name: 'index_event_registration_attributes_on_event_id_&_lower(name)'
    end
  end
end
