require 'rails_helper'

RSpec.describe CvsHelper do
  describe '#full_name' do
    let(:user) { build_stubbed(:user, first_name: 'John', last_name: 'Oliver') }

    it 'returns the full namwe as a string' do
      expect(helper.full_name(user)).to eq 'John Oliver'
    end
  end

  describe '#study_period' do
    let(:started_on) { Date.new(2014, 1, 1) }
    let(:ended_on) { Date.new(2018, 1, 1) }

    it 'returns the study period as a single string' do
      expect(helper.study_period(started_on, ended_on)).to eq '2014 - 2018'
    end
  end
end
