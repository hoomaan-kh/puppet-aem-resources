aem_ssl { "[${aem_id}] Enable SSL by default for AEM":
  aem_username        => 'admin',
  aem_password        => 'password',
  aem_id              => 'test-aem-author1',
  https_hostname      => 'localhost',
  https_port          => '5433',
  keystore_password   => 'password',
  truststore_password => 'password',
  privatekey_file     => '/tmp/shinesolutions/puppet-aem-resources/private_key.der',
  certificate_file    => '/tmp/shinesolutions/puppet-aem-resources/cert_chain.crt',
}

