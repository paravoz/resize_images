# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from Mongoid::Errors::DocumentNotFound, with: :respond_not_found

  private

  def respond_not_found
    respond_with_errors(['Document(s) not found'], :not_found)
  end

  def respond_with_object(object, options = {})
    options[:is_collection] = false

    if object.errors.empty?
      render json: JSONAPI::Serializer.serialize(object, options)
    else
      respond_with_errors(object.errors, :unprocessable_entity)
    end
  end

  def respond_with_objects(objects, options = {})
    options[:is_collection] = true

    render json: JSONAPI::Serializer.serialize(objects, options)
  end

  def respond_with_errors(errors, status)
    render json: JSONAPI::Serializer.serialize_errors(errors), status: status
  end
end
