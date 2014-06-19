class Subject < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  paginates_per 10
  CAT=['', '叱ってください','褒めてください','']
end
