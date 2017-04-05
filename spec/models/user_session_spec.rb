require 'rails_helper'

describe UserSession do
  before(:each) do
    @user_session = build(:user_session)
  end

  subject { @user_session }

  describe 'Validations' do
    it { is_expected.to be_valid }
  end
end
