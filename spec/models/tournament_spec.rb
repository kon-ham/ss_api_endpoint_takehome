require 'rails_helper'

RSpec.describe Tournament, type: :model do
  describe 'validations' do
    it { should have_many(:teams) }
    it { should have_many(:assessments) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
  end
end
