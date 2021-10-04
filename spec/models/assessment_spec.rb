require 'rails_helper'

RSpec.describe Assessment, type: :model do
  describe 'validations' do
    it { should belong_to(:user) }
    it { should have_many(:notes) }
  end
end
