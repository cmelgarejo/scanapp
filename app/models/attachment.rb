class Attachment < ApplicationRecord
  belongs_to :item
  mount_uploader :path, AttachmentUploader

end
