# frozen_string_literal: true
class Api::V1::ResizeImagesController < Api::V1::BaseController
  def index
    resize_images = current_user_session.resize_images.page(params[:page])

    respond_with_objects(
      resize_images,
      links: pagination_links(resize_images, 'index')
    )
  end

  def show
    resize_image = current_user_session.resize_images.find(params[:id])
    respond_with_object(resize_image)
  end

  def create
    resize_image = ResizeImage.create(raw_image_params)
    respond_with_object(resize_image)
  end

  private

  def raw_image_params
    attributes = params.dig(:data, :attributes)
    return {} unless attributes
    attributes.permit(:raw_image_id, :width, :height)
  end
end
