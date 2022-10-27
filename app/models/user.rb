# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  comments_count  :integer
#  email           :string
#  likes_count     :integer
#  password_digest :string
#  private         :boolean
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many(:comments)
  
  has_many(:received_follow_requests, {:foreign_key => :recipient_id, :class_name => "FollowRequest"})
  has_many(:accepted_received_follow_requests, -> { where status: "accepted"}, {:foreign_key => :recipient_id, :class_name => "FollowRequest"})
  has_many(:followers, {:through => :accepted_received_follow_requests, :source => :sender})

  has_many(:sent_follow_requests, {:foreign_key => :sender_id, :class_name => "FollowRequest"})
  has_many(:accepted_sent_follow_requests, -> { where status: "accepted"}, {:foreign_key => :sender_id, :class_name => "FollowRequest"})
  has_many(:leaders, {:through => :accepted_sent_follow_requests, :source => :recipient })
end
