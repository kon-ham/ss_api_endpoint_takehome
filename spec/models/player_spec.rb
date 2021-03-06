require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'relationships' do
    it { should belong_to(:team) }
    it { should have_many(:assessments) }
  end
end
