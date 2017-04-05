# frozen_string_literal: true

class Api::V1::BaseController < ApplicationController
  before_action :authorize!

  private

  def authorize!
    return true if current_user_session.present?
    respond_with_errors([{ status: 401, title: 'Unauthorized' }], :unauthorized)
  end

  def current_user_session
    @current_user_session ||=
      UserSession.where(authorization_token: request.headers['Authorization'])
                 .first
  end

  def respond_with_object(object, options = {})
    options[:namespace] = Api::V1
    super(object, options)
  end

  def respond_with_objects(object, options = {})
    options[:namespace] = Api::V1
    super(object, options)
  end

  def pagination_links(collection, action)
    return if collection.blank?

    controller = collection.first.model_name.plural
    url = url_for(controller: controller, action: action, only_path: true)

    {}.tap do |h|
      h[:self] = "#{url}?page=#{collection.current_page}"
      h[:prev] = "#{url}?page=#{collection.prev_page}" if collection.prev_page
      h[:next] = "#{url}?page=#{collection.next_page}" if collection.next_page
      h[:first] = "#{url}?page=1"
      h[:last] = "#{url}?page=#{collection.total_pages}"
    end
  end
end
