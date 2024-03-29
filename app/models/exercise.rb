class Exercise < ApplicationRecord
  belongs_to :user

  # Attribute aliases
  alias_attribute :workout_details, :workout
  alias_attribute :activity_date, :workout_date

  validates :duration_in_min, :workout_details, :activity_date, presence: true
  validates :duration_in_min, numericality: { greater_than: 0.0 }

  scope :last_7_days, -> { where('workout_date > ?', 7.days.ago).order(workout_date: :desc) }
end
