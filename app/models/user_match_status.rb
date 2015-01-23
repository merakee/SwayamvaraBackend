class UserMatchStatus < ActiveRecord::Base
    has_many :user_match, dependent: :destroy
    validates :status, presence: true, inclusion: {:in => %w[Unknown Expressed Accepted Rejected Serious]}
end