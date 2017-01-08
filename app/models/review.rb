class Review < ActiveRecord::Base
  belongs_to :user

  # Validations

  validates_presence_of :content

end
