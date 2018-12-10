require 'rails_helper'

RSpec.describe FacebookService do
  let(:token) { 'EAAcT2QaoKW0BADcCp3zQcwi7gNAONa7ZCAFVPg89AbYv2TPZAbciFgBO3myZBEenstfy84ysjLfZBwZBZAUzZBowU0hbJvO1eHodiZCHN7UsaUZACH8cayKZCrpAzCwhWKvcbEN7fjORhfFxwoRaabZCC6RDowYQ8nfVi2Yzh80TZBRGPOZCubqrTO1xr' }
  let(:instagram_id) { '17841409430992073' }

  describe '#business_accounts' do
    subject { described_class.new(token).business_accounts }

    context 'to have business account' do
      it { is_expected.not_to be_empty }
    end
  end

  describe '#media' do
    subject { described_class.new(token).media(instagram_id) }

    context 'has media' do
      it { is_expected.not_to be_empty }
    end
  end

  describe '#mentioned_media' do
    let(:media_id) { '17888859541281610' }

    subject { described_class.new(token).mentioned_media(instagram_id, media_id) }

    context 'has media' do
      it { expect { subject }.to raise_error(Koala::Facebook::ClientError) }
    end
  end
end
