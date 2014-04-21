class Project < ActiveRecord::Base
  belongs_to :user
  has_many :things, dependent: :destroy

  default_scope -> { order('created_at DESC') }
end
