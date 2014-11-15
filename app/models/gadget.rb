class Gadget < ActiveRecord::Base
	has_many :images, :dependent => :destroy
	belongs_to :user

end
