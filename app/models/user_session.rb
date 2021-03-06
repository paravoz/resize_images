# frozen_string_literal: true

class UserSession
  include Mongoid::Document

  field :authorization_token, type: String

  has_many :raw_images, dependent: :destroy

  before_create :generate_authorization_token

  def resize_images
    ResizeImage.in(raw_image_id: raw_images.pluck(:id))
  end

  private

  def generate_authorization_token
    loop do
      token = SecureRandom.uuid.tr('-', '')

      unless UserSession.where(authorization_token: token).exists?
        self.authorization_token = token
        break
      end
    end
  end
end
