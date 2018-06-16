class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :beast, optional: true
  belongs_to :subject, optional: true

  validates :rate, presence: true, inclusion: {in: 1..10}
  validate :obscenity_validator

  def obscenity_validator
    errors.add(:message, "should not contain swearwords") if Obscenity.profane?(message)
  end

end
