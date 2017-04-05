# frozen_string_literal: true

module Configurable
  extend ActiveSupport::Concern

  def filename
    "#{model.id}.jpeg" if original_filename
  end

  def extension_white_list
    %w(jpeg jpg)
  end
end
