class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :stripe_customer_id, presence: true


  after_create :send_attendance_email

  def send_attendance_email
    UserMailer.attendance_email(self.event).deliver_now
  end

end
