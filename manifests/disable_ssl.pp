define aem_resources::disable_ssl(
$aem_id              = 'aem',
$aem_username        = undef,
$aem_password        = undef,
) {
  aem_ssl { "[${aem_id}] Disable SSL by default for AEM":
    ensure              => disable,
    aem_username        => $aem_username,
    aem_password        => $aem_password,
    aem_id              => $aem_id,
  }
}
