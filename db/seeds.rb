# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Dir[Rails.root.join("spec/factories/*.rb")].each {|f| require f}

# parmanent seeds
# user_type
%w[Anonymous Normal].each do |type|
UserType.create :user_type => type
end

# user match status
%w[Unknown Expressed Accepted Rejected Serious].each do |status|
UserMatchStatus.create :status => status
end

# blacklist reasons
%w[Unknown NotApproved Rejected Blocked Flagged].each do |reason|
BlacklistReason.create :reason => reason
end

# flagging reasons
%w[Unknown Offensive Fake Spammer].each do |reason|
FlaggingReason.create :reason => reason
end

# seeds for only Dev 
if Rails.env == 'development'
  
  # # Users
  10.times do
    FactoryGirl.create :user
  end
end
