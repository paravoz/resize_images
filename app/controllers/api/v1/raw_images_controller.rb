# frozen_string_literal: true
class Api::V1::RawImagesController < Api::V1::BaseController
  def index
    raw_images = current_user_session.raw_images.page(params[:page])

    respond_with_objects(
      raw_images,
      links: pagination_links(raw_images, 'index')
    )
  end

  def show
    raw_image = current_user_session.raw_images.find(params[:id])
    respond_with_object(raw_image)
  end

  def create
    user_session = current_user_session.raw_images.create(raw_image_params)
    respond_with_object(user_session)
  end

  private

  def raw_image_params
    params.permit(:file)
  end
end
