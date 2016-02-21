require 'spec_helper'
describe 'crucible' do

  context 'with defaults for all parameters' do
    it { should contain_class('crucible') }
  end
end
