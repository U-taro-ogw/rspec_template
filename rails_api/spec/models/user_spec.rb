require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'after(:build)' do
    let!(:user) do
      create(:user, :with_profile, name: 'this is user name')
    end

    it 'example' do
      expect(user).to have_attributes(name: 'this is user name')
    end
  end
end
