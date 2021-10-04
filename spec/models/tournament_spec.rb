require 'rails_helper'

RSpec.describe Tournament, type: :model do
  describe 'validations' do
    it { should have_many(:teams) }
    it { should have_many(:assessments) }
  end
end
