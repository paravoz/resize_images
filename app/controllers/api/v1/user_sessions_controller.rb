# frozen_string_literal: true
class Api::V1::UserSessionsController < Api::V1::BaseController
  skip_before_action :authorize!, only: :create

  def create
    user_session = UserSession.create
    respond_with_object(user_session)
  end
end
