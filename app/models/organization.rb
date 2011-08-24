class Organization < ActiveRecord::Base
  #belongs_to :Profile
  has_many :Profile
end
