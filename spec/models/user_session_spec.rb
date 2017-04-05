require 'rails_helper'

describe UserSession do
  before(:each) do
    @user_session = build(:user_session)
  end

  subject { @user_session }

  describe 'Attributes' do
    it { is_expected.to respond_to(:authorization_token) }
  end

  describe 'Validations' do
    it { is_expected.to be_valid }
  end

  describe 'Callbacks' do
    describe '#generate_authorization_token' do
      before(:each) { @user_session = build(:user_session) }

      subject { @user_session }

      it do
        is_expected.to callback(:generate_authorization_token).after(:create)
      end

      it 'before save authorization_token must be nil' do
        expect(subject.authorization_token).to be_nil
      end

      it 'after save authorization_token must not be nil' do
        subject.save
        expect(subject.authorization_token).to_not be_nil
      end
    end
  end
end
