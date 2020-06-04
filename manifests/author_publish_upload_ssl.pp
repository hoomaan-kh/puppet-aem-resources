define aem_resources::author_publish_upload_ssl(
$aem_id              = 'aem',
$aem_username        = undef,
$aem_password        = undef,
$https_hostname      = undef,
$aem_ssl_port        = undef,
$keystore_password   = undef,
$truststore_password = undef,
$privatekey_file     = undef,
$certificate_file    = undef,
$https_port          = undef,

) {
  aem_ssl { "[${aem_id}] Enable SSL by default for AEM":
    ensure              => present,
    aem_username        => $aem_username,
    aem_password        => $aem_password,
    aem_id              => $aem_id,
    https_hostname      => $https_hostname,
    https_port          => $https_port,
    keystore_password   => $keystore_password,
    truststore_password => $truststore_password,
    privatekey_file     => $privatekey_file,
    certificate_file    => $certificate_file,
  }
}
