require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'relationships' do
    it { should have_many(:players) }
    it { should belong_to(:tournament) }
  end
  
  describe '#name' do
    it { should validate_presence_of(:name) }
  end
end
