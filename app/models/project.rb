class Project < ActiveRecord::Base
  belongs_to :user
  has_many :things, dependent: :destroy

  default_scope -> { order('created_at DESC') }

  def as_json(options = nil)
    super(only: [:id, :body, :created_at, :updated_at])
  end
end
