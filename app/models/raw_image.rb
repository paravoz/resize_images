# frozen_string_literal: true
class RawImage
  include Mongoid::Document

  mount_uploader :file, RawImageUploader

  validates :file, presence: true
  validates :user_session, presence: true

  has_many :resize_images, dependent: :destroy
  belongs_to :user_session
end
