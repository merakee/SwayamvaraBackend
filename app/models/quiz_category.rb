class QuizCategory < ActiveRecord::Base
  has_many :quiz , dependent: :destroy
  
  validates :category, presence: true, uniqueness: true, inclusion: {:in => %w[Fun Personality Relationship LikeAndDislike WhatWouldYouDo Movies Music Activities CurrentEvents IQTest]}
end
