class Wine < ActiveRecord::Base
  validates :name, presence: true
end
