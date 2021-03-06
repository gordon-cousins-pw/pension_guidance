RSpec.describe Geocoder, '.lookup' do
  let(:postcode) { 'invalid' }

  subject(:geocode) { described_class.lookup(postcode) }

  context 'with an invalid syntax postcode' do
    specify { expect { geocode }.to raise_error(Geocoder::InvalidPostcode) }
  end

  context 'with a valid syntax postcode' do
    let(:postcode) { 'BT7 3AP' }
    let(:postcodes_io) { double }
    let(:lat) { 1 }
    let(:lng) { 0 }
    let(:lat_lng) { [lat, lng] }
    let(:lookup) { nil }

    before do
      allow(Postcodes::IO).to receive(:new).and_return(postcodes_io)
      allow(postcodes_io).to receive(:lookup).with(postcode).and_return(lookup)
    end

    context 'but the lookup is invalid' do
      specify { expect { geocode }.to raise_error(Geocoder::InvalidPostcode) }
    end

    context 'but the lookup fails' do
      before do
        allow(postcodes_io).to receive(:lookup).with(postcode).and_raise('lookup timeout')
      end

      specify { expect { geocode }.to raise_error(Geocoder::FailedLookup) }
    end

    context 'and the lookup is successful' do
      let(:lookup) { double(latitude: lat, longitude: lng) }

      it { is_expected.to eq(lat_lng) }
    end
  end
end
