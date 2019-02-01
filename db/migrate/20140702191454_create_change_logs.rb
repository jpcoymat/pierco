class CreateChangeLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :change_logs do |t|
      t.references :reference_object, polymorphic: true, index: {name: :change_log_references}
      t.string :reference_attribute
      t.string :old_value
      t.string :new_value
    
      t.timestamps
    end
  end
end
