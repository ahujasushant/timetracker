require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :owner }
    it { is_expected.to validate_presence_of :subdomain }
    it { is_expected.to validate_uniqueness_of(:subdomain).case_insensitive}

    it { is_expected.to allow_value('test').for(:subdomain) }
    it { is_expected.to allow_value('something').for(:subdomain) }

    it { is_expected.to_not allow_value('www').for(:subdomain) }
    it { is_expected.to_not allow_value('WWW').for(:subdomain) }
    it { is_expected.to_not allow_value('.test').for(:subdomain) }
    it { is_expected.to_not allow_value('test/').for(:subdomain) }

    it 'should validate case insensitive uniqueness' do
      create(:account, subdomain: 'Test')
      expect(build(:account, subdomain: 'test')).to_not be_valid
    end
  end

  describe 'associations' do
    context 'should have an owner' do
      it { is_expected.to belong_to :owner }
    end
  end
end
