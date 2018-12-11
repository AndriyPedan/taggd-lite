require 'rails_helper'

RSpec.describe Video, type: :model do
  let(:video_hash) do
    { 'like_count' => 2,
      'media_url' =>
       'https://scontent.xx.fbcdn.net/v/t51.2885-15/46411707_342343413019015_545776328708773602_n.jpg?_nc_cat=111&_nc_ht=scontent.xx&oh=ed98d35f1b2c7e406d1a93f47f8ab925&oe=5CB1F591',
      'media_type' => 'VIDEO',
      'ig_id' => '1931314175135254715',
      'permalink' => 'https://www.instagram.com/p/BrNaAJ-nQi7/',
      'timestamp' => '2018-12-10T14:03:32+0000',
      'username' => 'kidnapkintagged',
      'id' => '11111111111111' }
  end

  subject { described_class.from_hash(video_hash) }

  it 'builds new inctance from hash' do
    expect(subject.media_url).to eq(video_hash['media_url'])
  end
end
