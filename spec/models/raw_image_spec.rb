require 'rails_helper'

describe RawImage do
  before(:all) { @raw_image = create(:raw_image) }

  subject { @raw_image }

  describe 'Attributes' do
    it { is_expected.to respond_to(:file) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:user_session) }
  end

  describe 'Validations' do
    it { is_expected.to be_valid }

    it { is_expected.to validate_presence_of(:file) }
    it { is_expected.to validate_presence_of(:user_session) }
  end
end
