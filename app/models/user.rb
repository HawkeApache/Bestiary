class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments
  has_and_belongs_to_many :subjects

  after_create :set_sub

  validates :displayname, presence: true, length: {minimum: 2, maximum: 255}
  validates :firstname, presence: true, length: {minimum: 2, maximum: 255}
  validates :lastname, presence: true, length: {minimum: 2, maximum: 255}

  def set_sub
    self.role = :client
  end

  def client?
    self.role == "client"
  end

  def admin?
    self.role == "admin"
  end

end
