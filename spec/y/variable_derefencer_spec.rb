# variable_derefencer_spec.rb - specs for variable_derefencer

require_relative 'spec_helper'

describe VariableDerefencer do
  describe 'when empty stack frame' do
    let(:frames) { [{}] }
    let(:vref) { VariableDerefencer.new frames }
    subject { vref[:id] }
    it 'should be empty string' do
      subject.must_equal ''
    end
  end
  describe 'when given a single frame and matching symbol' do
    let(:frames) { [{devil: 'details'}] }
    let(:vref) { VariableDerefencer.new frames }

    subject { vref[:devil] }
    it 'should be details' do
      subject.must_equal 'details'
    end
  end
  
  describe 'when shadowing earlier variable' do
    let(:frames) { [{cat: 'pet'}, {}, {cat: 'evil'}] }
    let(:vref) { VariableDerefencer.new frames }
    subject { vref[:cat]  }
    it 'should be evil' do
      subject.must_equal 'evil'
    end

  end
end
