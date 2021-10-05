require 'rails_helper'

RSpec.describe Tournament, type: :model do
  describe 'relationships' do
    it { should have_many(:teams) }
    it { should have_many(:assessments) }
  end
  
  describe '#state' do
    it { should validate_presence_of(:state) }
    it { should validate_length_of(:state).is_equal_to(2) }
  end
  
  describe '#name' do
    it { should validate_presence_of(:name) }
  end
  
  describe '#city' do
    it { should validate_presence_of(:city) }
  end
  
  describe '#start_date' do
    it { should validate_presence_of(:start_date) }
  end
end
