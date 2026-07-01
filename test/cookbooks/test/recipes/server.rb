# frozen_string_literal: true

apt_update

chrony_config 'server' do
  allow ['10.0.0.0/8']
end
