class Image < ActiveRecord::Base
	belongs_to :gadget

  has_attached_file :photo,
    :path => ":rails_root/public/images/:id/:filename",
    :url  => "/images/:id/:filename"

   do_not_validate_attachment_file_type :photo

end
