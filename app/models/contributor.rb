class Contributor < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_presence_of :password_digest

end
