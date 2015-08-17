class Song < ActiveRecord::Base

  has_and_belongs_to_many :users

  validates_uniqueness_of :soundcloud_id

end
