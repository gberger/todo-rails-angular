class Todo < ActiveRecord::Base
  validates :priority, inclusion: { in: (1..5) }
  validates :text, length: { minimum: 1, maximum: 4096 }

  belongs_to :user

  scope :owned_by, lambda{|user| where(user_id: user.id) }
  
end
