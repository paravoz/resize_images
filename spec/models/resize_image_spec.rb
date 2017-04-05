require 'rails_helper'

describe ResizeImage do
  before { @resize_image = create(:resize_image) }

  subject { @resize_image }

  describe 'Attributes' do
    it { is_expected.to respond_to(:width) }
    it { is_expected.to respond_to(:height) }
    it { is_expected.to respond_to(:file) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:raw_image) }
  end

  describe 'Validations' do
    it { is_expected.to be_valid }

    it { is_expected.to validate_presence_of(:width) }
    it { is_expected.to validate_presence_of(:height) }
    it { is_expected.to validate_presence_of(:raw_image) }

    it { is_expected.to validate_numericality_of(:width).greater_than(0) }
    it { is_expected.to validate_numericality_of(:height).greater_than(0) }
  end

  describe 'Callbacks' do
    describe '#resize_image' do
      before(:each) { @resize_image = build(:resize_image) }

      subject { @resize_image }

      it { is_expected.to callback(:resize_image!).after(:create) }

      it 'before save file must be nil' do
        expect(subject.file.path).to be_nil
      end

      it 'after save must be present resized file' do
        subject.save

        resized_file_path =
          Rails.root.join('spec', 'support', 'resize_image.jpg')

        expect(subject.file.path).to eq_file(resized_file_path)
      end
    end
  end
end
