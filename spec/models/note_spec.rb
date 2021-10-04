require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'validations' do
    it { should belong_to(:assessment) }
  end
end
