aem_resources::author_publish_upload_ssl { "${aem_id}: Enable SSL by default for ${aem_ssl_port}":
      https_hostname      => "localhost",
      https_port          => "5433",
      keystore_password   => "password",
      truststore_password => "password",
      privatekey_file     => "/tmp/shinesolutions/puppet-aem-resources/private_key.der",
      certificate_file    => "/tmp/shinesolutions/puppet-aem-resources/cert_chain.crt",
      aem_id              => "author",
    }