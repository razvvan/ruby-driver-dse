# encoding: utf-8

#--
# Copyright 2013-2016 DataStax, Inc.
#++

require 'spec_helper'

module Dse
  module Auth
    module Providers
      describe GssApi do
        context :constructor do
          let(:custom_resolver) do
            x = Object.new
            def x.resolve(host)
              'fake'
            end
            x
          end

          return if RUBY_ENGINE == 'jruby'

          it 'should default to a NameInfoResolver' do
            provider = GssApi.new('foo')
            expect(provider.instance_variable_get(:@host_resolver)).to be_instance_of(GssApi::NameInfoResolver)
          end

          it 'should treat false to be NoOpResolver' do
            provider = GssApi.new('foo', false)
            expect(provider.instance_variable_get(:@host_resolver)).to be_instance_of(GssApi::NoOpResolver)
          end

          it 'should treat true to be NameInfoResolver' do
            provider = GssApi.new('foo', true)
            expect(provider.instance_variable_get(:@host_resolver)).to be_instance_of(GssApi::NameInfoResolver)
          end

          it 'should accept custom host resolver' do
            provider = GssApi.new('foo', custom_resolver)
            expect(provider.instance_variable_get(:@host_resolver)).to be(custom_resolver)
          end

          it 'should reject custom host resolver that does not implement resolve' do
            expect { GssApi.new('foo', Object.new) }.to raise_error(ArgumentError)
            expect { GssApi.new('foo', :foo) }.to raise_error(ArgumentError)
          end
        end
      end
    end
  end
end
