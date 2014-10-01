require 'spec_helper'
describe 'znc' do

  context 'with defaults for all parameters' do
    it { should contain_class('znc') }
  end
end
