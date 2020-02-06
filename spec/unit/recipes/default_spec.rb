#
# Cookbook:: chrony
# Spec:: default
#
# Copyright:: 2018-2019, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'chrony::default' do
  context 'When all attributes are default' do
    context 'on Ubuntu 18.04' do
      let(:chef_run) do
        ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '18.04') do
          allow_any_instance_of(Chef::Recipe).to receive(:systemd?).and_return(false)
          allow_any_instance_of(Chef::Resource).to receive(:systemd?).and_return(false)
        end.converge(described_recipe)
      end

      it 'included the client recipe' do
        expect(chef_run).to include_recipe('chrony::client')
      end
    end

    context 'on CentOS 7.6' do
      let(:chef_run) do
        ChefSpec::ServerRunner.new(platform: 'centos', version: '7.6') do
          allow_any_instance_of(Chef::Recipe).to receive(:systemd?).and_return(true)
          allow_any_instance_of(Chef::Resource).to receive(:systemd?).and_return(true)
        end.converge(described_recipe)
      end

      it 'included the client recipe' do
        expect(chef_run).to include_recipe('chrony::client')
      end
    end
  end
end
