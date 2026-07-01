# frozen_string_literal: true

shared_examples 'chrony_config :create' do
  it 'installs the chrony package' do
    expect(chef_run).to install_package('chrony')
  end

  it 'creates the chrony configuration file' do
    expect(chef_run).to create_template(conf_file)
      .with(
        owner: 'root',
        group: 'root',
        mode: '0600'
      )
  end

  it 'creates the chrony log directory' do
    log_dir = chef_run.find_resource(:directory, '/var/log/chrony')

    expect(log_dir.owner).to eq(chrony_user)
    expect(log_dir.group).to eq(chrony_user)
    expect(log_dir.mode).to eq('0755')
    expect(log_dir.recursive).to be true
  end

  it 'enables the chrony service' do
    expect(chef_run).to enable_service(service_name)
  end

  it 'starts the chrony service' do
    expect(chef_run).to start_service(service_name)
  end
end
