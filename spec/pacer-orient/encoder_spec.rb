require 'spec_helper'

module Pacer::Orient
  describe Encoder do
    let(:original) do
      { :string => ' bob ',
        :symbol => :abba,
        :empty => '',
        :integer => 121,
        :float => 100.001,
        :time => Time.utc(1999, 11, 9, 9, 9, 1),
        :object => { :a => 1, 1 => :a },
        :set => Set[1, 2, 3],
        :nested_array => [1, 'a', [2]],
        :ok_string => 'string value'
      }
    end

    describe '#encode_property' do
      subject do
        pairs = original.map do |name, value|
          [name, Encoder.encode_property(value)]
        end
        Hash[pairs]
      end

      it { should_not equal(original) }

      specify 'string should be stripped' do
        subject[:string].should == 'bob'
      end

      specify 'empty string becomes nil' do
        subject[:empty].should be_nil
      end

      specify 'numbers should be javafied' do
        subject[:integer].should == 121
        subject[:float].should == 100.001
      end

      specify 'time is unmodified' do
        subject[:time].should == Time.utc(1999, 11, 9, 9, 9, 1)
      end

      specify 'everything else should be binary' do
        subject[:set].to_a.should == Marshal.dump(original[:set]).to_java_bytes.to_a
        subject[:object].to_a.should == Marshal.dump(original[:object]).to_java_bytes.to_a
      end
    end

    describe '#decode_property' do
      it 'should round-trip cleanly' do
        # remove values that get cleaned up when encoded
        original.delete :string
        original.delete :empty

        original.values.each do |value|
          encoded = Encoder.encode_property(value)
          decoded = Encoder.decode_property(encoded)
          decoded.should == value
        end
      end

      it 'should strip strings' do
        encoded = Encoder.encode_property(' a b c ')
        decoded = Encoder.decode_property(encoded)
        decoded.should == 'a b c'
      end

      it 'empty strings -> nil' do
        encoded = Encoder.encode_property(' ')
        decoded = Encoder.decode_property(encoded)
        decoded.should be_nil
      end
    end
  end
end
