# frozen_string_literal: true

apt_update

chrony_config 'default' do
  extra_config ['log measurements statistics tracking']
end
