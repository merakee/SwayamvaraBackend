class UserType < ActiveRecord::Base
    has_many :user, dependent: :destroy
    validates :user_type, presence: true, inclusion: {:in => %w[Anonymous Normal]}
end
