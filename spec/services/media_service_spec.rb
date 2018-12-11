require 'rails_helper'

RSpec.describe MediaService do
  let!(:media) { create(:media, instagram_id: '11111111111111') }
  let(:media_array) do
    [{ 'like_count' => 2,
       'media_url' =>
       'https://scontent.xx.fbcdn.net/v/t51.2885-15/46411707_342343413019015_545776328708773602_n.jpg?_nc_cat=111&_nc_ht=scontent.xx&oh=ed98d35f1b2c7e406d1a93f47f8ab925&oe=5CB1F591',
       'media_type' => 'IMAGE',
       'ig_id' => '1931314175135254715',
       'permalink' => 'https://www.instagram.com/p/BrNaAJ-nQi7/',
       'timestamp' => '2018-12-10T14:03:32+0000',
       'username' => 'kidnapkintagged',
       'id' => '11111111111111' }]
  end

  describe '#facebook_media_hash' do
    subject { described_class.new(token: 'token', business_id: 'id').facebook_media_hash }

    before do
      allow_any_instance_of(FacebookService).to receive(:media).and_return(media_array)
    end

    context 'filtered array' do
      it { is_expected.to be_empty }
    end
  end
end
