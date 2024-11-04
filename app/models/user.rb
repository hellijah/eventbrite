class User < ApplicationRecord
  has_many :events, foreign_key: 'user_id'
  has_many :attendances
  has_many :attended_events, through: :attendances, source: :event

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
  
end
