# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "mwrock/Windows2012R2"
  config.vm.guest = :windows
  config.vm.communicator = "winrm"

  hostname = "dsc-dc"
  config.vm.hostname = hostname

  config.vm.provision "dsc" do |dsc|
    dsc.module_path = ["modules"]
    dsc.configuration_file  = "dscDCConfiguration.ps1"
    dsc.configuration_data_file  = "manifests/dscDCConfigurationData.psd1"
    dsc.configuration_name = "Main"
    dsc.manifests_path = "manifests"
    dsc.configuration_params = {"-NodeName" => hostname, "-domainName" => "dscdc.local"}
  end
end
