control 'container' do
  impact 0.5
  describe docker_container('mysql-cluster') do
    it { should exist }
    it { should be_running }
    its('repo') { should eq 'mysql/mysql-cluster' }
    its('ports') { should eq '1186/tcp, 2202/tcp, 3306/tcp, 33060/tcp' }
    its('command') { should match '/entrypoint.sh.*' }
  end
end
control 'packages' do
  impact 0.5
  describe package('mysql-cluster-community-server-minimal') do
    it { should be_installed }
    its ('version') { should match '7.5.13.*' }
  end
  describe package('mysql-shell') do
    it { should be_installed }
    its ('version') { should match '8.0.14.*' }
  end
end
