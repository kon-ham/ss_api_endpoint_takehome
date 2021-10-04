require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'validations' do
    it { should have_many(:players) }
    it { should belong_to(:tournament) }
  end
end
