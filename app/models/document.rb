class Document < ApplicationRecord
  belongs_to :documentable, polymorphic: true
  has_one_attached :file

  validate :file_type_validation
  validate :file_size_validation

  private

  def file_type_validation
    return unless file.attached?

    acceptable_types = ["application/pdf", "image/png", "image/jpeg"]
    unless acceptable_types.include?(file.blob.content_type)
      errors.add(:file, "must be a PDF, PNG, or JPG")
    end
  end

  def file_size_validation
    return unless file.attached?

    if file.blob.byte_size > 10.megabytes
      errors.add(:file, "size must be less than 10 MB")
    end
  end
end
