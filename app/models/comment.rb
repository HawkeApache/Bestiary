class Comment < ApplicationRecord
  # todo remove optional from user
  belongs_to :user, optional: true
  belongs_to :beast, optional: true
  belongs_to :subject, optional: true
end
