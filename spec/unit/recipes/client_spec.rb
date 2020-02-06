#
# Cookbook:: chrony
# Spec:: client
#
# Copyright:: 2019, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'chrony::client' do
  context 'on Ubuntu 18.04' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '18.04') do
        allow_any_instance_of(Chef::Recipe).to receive(:systemd?).and_return(false)
        allow_any_instance_of(Chef::Resource).to receive(:systemd?).and_return(false)
      end.converge(described_recipe)
    end

    it_behaves_like 'chrony client'

    it 'rendered /etc/chrony.conf' do
      expect(chef_run).to render_file('/etc/chrony/chrony.conf').with_content(/pool pool.ntp.org iburst/)
      expect(chef_run).to_not render_file('/etc/chrony/chrony.conf').with_content('allow')
    end
  end

  context 'on CentOS 7.6' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'centos', version: '7.6') do
        allow_any_instance_of(Chef::Recipe).to receive(:systemd?).and_return(true)
        allow_any_instance_of(Chef::Resource).to receive(:systemd?).and_return(true)
      end.converge(described_recipe)
    end

    it_behaves_like 'chrony client'

    it 'rendered /etc/chrony.conf' do
      expect(chef_run).to render_file('/etc/chrony.conf').with_content(/pool pool.ntp.org iburst/)
      expect(chef_run).to_not render_file('/etc/chrony/chrony.conf').with_content('allow')
    end
  end
end
