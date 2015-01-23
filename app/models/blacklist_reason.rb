class BlacklistReason < ActiveRecord::Base
    has_many :user_blacklist, dependent: :destroy
    validates :reason, presence: true, inclusion: {:in => %w[Unknown NotApproved Rejected Blocked Flagged]}
end
