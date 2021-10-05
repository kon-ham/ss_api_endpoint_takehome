require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'relationships' do
    it { should belong_to(:assessment) }
  end
end
