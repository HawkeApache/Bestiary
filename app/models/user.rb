class User < ApplicationRecord
  has_many :comments
  has_and_belongs_to_many :subjects

  validates :firstname, presence: true, length: { minimum: 2 , maximum: 255}
  validates :lastname, presence: true, length: { minimum: 2 , maximum: 255}

end
