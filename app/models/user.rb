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
  has_many(:photos, {:foreign_key => :owner_id, :class_name => "Photo"})
  has_many(:likes, {:foreign_key => :fan_id, :class_name => "Like"})
  has_many(:liked_photos, {:through => :likes, :source => :photo} )
  
  has_many(:received_follow_requests, {:foreign_key => :recipient_id, :class_name => "FollowRequest"})
  has_many(:accepted_received_follow_requests, -> { where status: "accepted"}, {:foreign_key => :recipient_id, :class_name => "FollowRequest"})
  has_many(:followers, {:through => :accepted_received_follow_requests, :source => :sender})

  has_many(:sent_follow_requests, {:foreign_key => :sender_id, :class_name => "FollowRequest"})
  has_many(:accepted_sent_follow_requests, -> { where status: "accepted"}, {:foreign_key => :sender_id, :class_name => "FollowRequest"})
  has_many(:leaders, {:through => :accepted_sent_follow_requests, :source => :recipient })

  has_many(:feed, {:through => :leaders, :source => :photos})
  has_many(:discovery, {:through => :leaders, :source => :liked_photos})

end
