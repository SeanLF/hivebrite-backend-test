class CreateEventRegistrationAttributeValues < ActiveRecord::Migration[6.0]
  def change
    create_table :event_registration_attribute_values do |t|
      t.references :event_registration,
                   null: false,
                   foreign_key: true, index: {
                     name: 'index_event_registration_attribute_values_on_event_regist_id'
                   }
      t.references :event_registration_attribute,
                   null: false,
                   foreign_key: true, index: {
                     name: 'index_event_registration_attribute_values_on_event_reg_attr_id'
                   }
      t.string :value, null: false

      t.timestamps
      t.index %i[event_registration_id event_registration_attribute_id],
              unique: true,
              name: 'index_event_registration_attribute_values_on_uniq_att_per_ureg'
    end
  end
end
