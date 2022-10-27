# == Schema Information
#
# Table name: follow_requests
#
#  id           :integer          not null, primary key
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#
class FollowRequest < ApplicationRecord
  belongs_to(:recipient, {:foreign_key => :recipient_id, :class_name => "User"})
  belongs_to(:sender, {:foreign_key => :sender_id, :class_name => "User"})
end
