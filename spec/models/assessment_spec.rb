require 'rails_helper'

RSpec.describe Assessment, type: :model do
  describe 'validations' do
    it { should belong_to(:user) }
  end
end
