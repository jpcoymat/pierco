class CreateChangeLogs < ActiveRecord::Migration
  def change
    create_table :change_logs do |t|
      t.references :reference_object, polymorphic: true
      t.string :reference_attribute
      t.string :old_value
      t.string :new_value

      t.timestamps
    end
  end
end
