property :name, String, name_property: true
property :version, String
property :type, Symbol, equal_to: [:plugin, :extention], default: :plugin
property :source, String

default_action :install

action :install do
  cmd = 'sensu-install'
  cmd << (new_resource.type == :plugin ? ' -p ' : ' -e ')
  cmd << new_resource.name
  cmd << ":#{new_resource.version}" if new_resource.version
  cmd << "-s #{new_resource.source}" if new_resource.source
  execute "install sensu-install #{new_resource.name}" do
    command cmd
  end
end
