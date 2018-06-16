class Beast < ApplicationRecord
  has_many :comments
  has_and_belongs_to_many :subjects
  has_one_attached :image


  validates :firstname, presence: true, length: {minimum: 2, maximum: 255}
  validates :lastname, presence: true, length: {minimum: 2, maximum: 255}
  validates :degree, presence: true
  validates :image, file_content_type: { allow: ['image/jpeg', 'image/png'] }

  def to_label
    "#{firstname} #{lastname}"
  end

end
