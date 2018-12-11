require 'rails_helper'

describe Dashboard::MediaHelper do
  describe '#current_class?' do
    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:fullpath).and_return('lol')
    end

    it 'returns active css class' do
      expect(helper.current_class?('lol')).to eq('active')
    end
  end
end
