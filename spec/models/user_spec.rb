require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:assessments) }
    it { should have_many(:notes).through(:assessments) }
  end
  
  describe '#email' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end
  
  describe '#password' do
    it { should validate_presence_of(:password) }
  end
end
