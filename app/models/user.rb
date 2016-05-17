class User < ActiveRecord::Base
  validates :provider, presence: true
  validates :uid, presence: true

end
