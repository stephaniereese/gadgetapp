class Image < ActiveRecord::Base
	belongs_to :gadget

	has_attached_file :photo, :styles => {:small => '30x30#', :large => '100x100#'}, :default_url => '/images/:id/photo_:style.png'

  do_not_validate_attachment_file_type :photo

end
