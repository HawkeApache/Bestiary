class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :beast, optional: true
  belongs_to :subject, optional: true

  validates :rate, presence: true, inclusion: {in: 1..10}
end
