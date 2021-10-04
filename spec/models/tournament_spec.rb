require 'rails_helper'

RSpec.describe Tournament, type: :model do
  describe 'validations' do
    it { should have_many(:teams) }
    it { should have_many(:assessments) }

    it { should validate_presence_of(:name) }
  end
end
