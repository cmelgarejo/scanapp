class Attachment < ApplicationRecord
  belongs_to :item
  mount_uploader :path, AttachmentUploader
  #validates :path, file_size: { less_than: 1.gigabytes }
  validate :attachment_size_validation

  def attachment_size_validation
    if path.size > Rails.application.secrets.upload_limit_size.megabytes
      errors.add(:base, "#{I18n.t('upload_limit_size_message')} #{Rails.application.secrets.upload_limit_size}MB")
    end
  end
end
