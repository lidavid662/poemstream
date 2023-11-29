# == Schema Information
#
# Table name: poems
#
#  id         :integer          not null, primary key
#  poem       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Poem < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
end
