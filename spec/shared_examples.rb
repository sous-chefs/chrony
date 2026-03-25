# frozen_string_literal: true

shared_examples 'chrony_config :create' do
  it 'installs the chrony package' do
    expect(chef_run).to install_package('chrony')
  end

  it 'creates the chrony configuration file' do
    expect(chef_run).to create_template(conf_file)
  end

  it 'enables the chrony service' do
    expect(chef_run).to enable_service(service_name)
  end

  it 'starts the chrony service' do
    expect(chef_run).to start_service(service_name)
  end
end
