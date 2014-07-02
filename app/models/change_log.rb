class ChangeLog < ActiveRecord::Base
  belongs_to :reference_object, polymorphic: true
  belongs_to :user

  def self.record_changes_on(object, user)
    object.changes.each do |attribute, changes|
      @change_log = ChangeLog.new(user: user, reference_object: object, reference_attribute: attribute, old_value: changes[0], new_value: changes[1])
      @change_log.save
    end
  end

end
