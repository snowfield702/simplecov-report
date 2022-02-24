require_relative '../lib/sample'

RSpec.describe Sample do
  describe '#run' do
    subject { described_class.new.run }
    it { is_expected.to eq(:sample) }
  end
end
