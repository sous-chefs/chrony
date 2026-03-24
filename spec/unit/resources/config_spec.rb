# frozen_string_literal: true

require 'spec_helper'

describe 'chrony_config' do
  context ':create action' do
    context 'on AlmaLinux 9 (RHEL family)' do
      cached(:chef_run) do
        ChefSpec::SoloRunner.new(
          platform: 'almalinux', version: '9',
          step_into: ['chrony_config']
        ) do |_node|
        end.converge('test::default')
      end

      let(:conf_file) { '/etc/chrony.conf' }
      let(:service_name) { 'chronyd' }

      include_examples 'chrony_config :create'

      it 'renders the config with default servers' do
        expect(chef_run).to render_file('/etc/chrony.conf')
          .with_content(/server pool\.ntp\.org iburst/)
      end

      it 'uses RHEL driftfile path' do
        expect(chef_run).to render_file('/etc/chrony.conf')
          .with_content(%r{driftfile /var/lib/chrony/drift$})
      end

      it 'does not include allow directives for client config' do
        expect(chef_run).not_to render_file('/etc/chrony.conf')
          .with_content(/^allow/)
      end

      it 'includes extra_config lines' do
        expect(chef_run).to render_file('/etc/chrony.conf')
          .with_content(/^log measurements statistics tracking$/)
      end
    end

    context 'on Ubuntu 24.04 (Debian family)' do
      cached(:chef_run) do
        ChefSpec::SoloRunner.new(
          platform: 'ubuntu', version: '24.04',
          step_into: ['chrony_config']
        ).converge('test::default')
      end

      let(:conf_file) { '/etc/chrony/chrony.conf' }
      let(:service_name) { 'chrony' }

      include_examples 'chrony_config :create'

      it 'uses Debian driftfile path' do
        expect(chef_run).to render_file('/etc/chrony/chrony.conf')
          .with_content(%r{driftfile /var/lib/chrony/chrony\.drift})
      end
    end

    context 'with server configuration (allow directives)' do
      cached(:chef_run) do
        ChefSpec::SoloRunner.new(
          platform: 'almalinux', version: '9',
          step_into: ['chrony_config']
        ).converge('test::server')
      end

      it 'renders allow directives' do
        expect(chef_run).to render_file('/etc/chrony.conf')
          .with_content(%r{^allow 10\.0\.0\.0/8})
      end
    end
  end

  context ':delete action' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'almalinux', version: '9',
        step_into: ['chrony_config']
      ).converge('test::delete')
    end

    it 'stops the chrony service' do
      expect(chef_run).to stop_service('chronyd')
    end

    it 'disables the chrony service' do
      expect(chef_run).to disable_service('chronyd')
    end

    it 'removes the chrony package' do
      expect(chef_run).to remove_package('chrony')
    end

    it 'deletes the config file' do
      expect(chef_run).to delete_file('/etc/chrony.conf')
    end
  end
end
