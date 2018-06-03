class Subject < ApplicationRecord
  has_many :comments
  has_and_belongs_to_many :beasts

  validates :name, presence: true, length: {minimum: 2, maximum: 255}, uniqueness: true
  validates_inclusion_of :ects, :in => 1..10
end
