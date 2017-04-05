# frozen_string_literal: true
class ResizeImage
  include Mongoid::Document

  field :width, type: Integer
  field :height, type: Integer

  mount_uploader :file, ResizeImageUploader

  belongs_to :raw_image

  validates :raw_image, presence: true

  validates :width, presence: true,
                    numericality: { only_integer: true, greater_than: 0 }

  validates :height, presence: true,
                     numericality: { only_integer: true, greater_than: 0 }

  after_create :resize_image!

  private

  def resize_image!
    image = MiniMagick::Image.open(raw_image.file.path)
    image.resize("#{width}x#{height}")
    image.format('jpg')
    image.write(tmp_file_path)

    update_attribute(:file, File.open(tmp_file_path))
  end

  def tmp_file_path
    Rails.root.join('tmp', 'resize_image', Time.current.to_i.to_s).tap(&:mkpath)
         .join('output.jpg')
  end
end
