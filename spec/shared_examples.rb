shared_examples 'chrony client' do
  it 'installed chrony' do
    expect(chef_run).to install_package('chrony')
  end

  it 'started and enabled the chrony(d) service' do
    expect(chef_run).to start_service('chrony')
    expect(chef_run).to enable_service('chrony')
  end

  it 'created chrony.conf' do
    expect(chef_run).to create_template('chrony.conf')
  end
end
