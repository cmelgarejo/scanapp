class Attachment < ApplicationRecord
  belongs_to :item
  mount_uploader :path, AttachmentUploader
  validates :path, file_size: { less_than: 1.gigabytes }
end
