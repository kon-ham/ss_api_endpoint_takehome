require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should have_many(:players) }
    it { should belong_to(:tournament) }
  end
end
