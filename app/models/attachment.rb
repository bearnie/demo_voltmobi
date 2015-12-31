class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true
  has_attached_file :stuff
  do_not_validate_attachment_file_type :stuff
end
