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
    base_url = url_for(controller: controller, action: action, only_path: true)

    {}.tap do |h|
      h[:self] = "#{base_url}?page=#{collection.current_page}"
      h[:prev] = "#{base_url}?page=#{collection.prev_page}" if collection.prev_page
      h[:next] = "#{base_url}?page=#{collection.next_page}" if collection.next_page
      h[:first] = "#{base_url}?page=1"
      h[:last] = "#{base_url}?page=#{collection.total_pages}"
    end
  end
end
