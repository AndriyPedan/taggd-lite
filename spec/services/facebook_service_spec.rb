require 'rails_helper'

RSpec.describe FacebookService do
  let(:business_accounts) do
    [{ 'name' => 'Tagged test',
       'access_token' => 'test',
       'instagram_business_account' =>
       { 'username' => 'tagged', 'name' => 'Tagged test', 'id' => '1111111111111' },
       'id' => '00000000000000' }]
  end
  let(:media) do
    [{ 'like_count' => 2,
       'media_url' =>
       'https://scontent.xx.fbcdn.net/v/t51.2885-15/46411707_342343413019015_545776328708773602_n.jpg?_nc_cat=111&_nc_ht=scontent.xx&oh=ed98d35f1b2c7e406d1a93f47f8ab925&oe=5CB1F591',
       'media_type' => 'CAROUSEL_ALBUM',
       'ig_id' => '1931314175135254715',
       'permalink' => 'https://www.instagram.com/p/BrNaAJ-nQi7/',
       'timestamp' => '2018-12-10T14:03:32+0000',
       'username' => 'kidnapkintagged',
       'id' => '17986287112084523' }]
  end

  describe '#business_accounts' do
    before do
      allow_any_instance_of(Koala::Facebook::API).to receive(:get_object).and_return(business_accounts)
    end

    subject { described_class.new('token').business_accounts }

    context 'to have business account' do
      it { is_expected.not_to be_empty }
    end
  end

  describe '#media' do
    subject { described_class.new('token').media('instagram_id') }

    before do
      allow_any_instance_of(Koala::Facebook::API).to receive(:get_object).and_return(media)
    end

    context 'has media' do
      it { is_expected.not_to be_empty }
    end
  end

  describe '#mentioned_media' do
    let(:media_id) { '17888859541281610' }

    subject { described_class.new('token').mentioned_media('instagram_id', 'media_id') }

    before do
      allow_any_instance_of(Koala::Facebook::API).to receive(:get_object).and_raise(Koala::Facebook::ClientError.new(100, 'Not mentioned'))
    end

    context 'has media' do
      it { expect { subject }.to raise_error(Koala::Facebook::ClientError) }
    end
  end
end
