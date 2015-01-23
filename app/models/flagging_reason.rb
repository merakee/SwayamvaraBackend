class FlaggingReason < ActiveRecord::Base
  has_many :flagged_user, dependent: :destroy
  validates :reason, presence: true, inclusion: {:in => %w[Unknown Offensive Fake Spammer]}
end
