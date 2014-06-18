class Subject < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  CAT=['叱ってください','褒めてください','']
end
