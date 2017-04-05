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
end
