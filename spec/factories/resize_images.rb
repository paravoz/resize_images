# frozen_string_literal: true
FactoryGirl.define do
  factory :resize_image do
    width 5
    height 5
    association :raw_image
  end
end
