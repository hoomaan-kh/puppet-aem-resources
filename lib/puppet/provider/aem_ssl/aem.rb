# frozen_string_literal: true

# Copyright 2016-2019 Shine Solutions
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require_relative '../../../puppet_x/shinesolutions/puppet_aem_resources.rb'
require 'tempfile'
require 'retries'
# require 'openssl'

Puppet::Type.type(:aem_ssl).provide(:aem, parent: PuppetX::ShineSolutions::PuppetAemResources) do

  # Upload certificate to the AEM Truststore.
  def create

    ssl = client(resource).ssl
    opts = {
        # keystore_password: 'password',
        keystore_password: resource[:keystore_password],
        # truststore_password: 'password',
        truststore_password: resource[:truststore_password],
        https_hostname: resource[:https_hostname],
        https_port: resource[:https_port],
        certificate_file_path: resource[:certificate_file_path],
        privatekey_file_path: resource[:privatekey_file_path],
      }
    build_opts = {
      _retries: {
        max_tries: resource[:retries_max_tries],
        base_sleep_seconds: resource[:retries_base_sleep_seconds],
        max_sleep_seconds: resource[:retries_max_sleep_seconds]
      }
    }
    # {
    #   keystore_password: resource[:keystore_password],
    #   truststore_password: resource[:truststore_password],
    #   https_hostname: resource[:https_hostname],
    #   https_port: resource[:https_port],
    #   # certificate_file_path: [:certificate_file_path],
    #   file_path_certificate: '/tmp/localhost.crt',
    #   # privatekey_file_path: resource[:privatekey_file_path]
    #   file_path_private_key: '/tmp/localhostprivate.der'
    # }

    # result = ssl.enable(**opts)
    # expect(result.message).to eq('HTTPS has been configured on port 5432')
    # expect(result.response.status_code).to eq(200)
    # ssl = client('admin', 'admin', 'localhost', '4502', '/tmp/localhost.csr' , '/tmp/localhostprivate.der').ssl
    # ssl = client(resource).ssl()
    # result = certificate.import_wait_until_ready(resource[:file], **opts)
    # result = ssl.enable(resource[:keystore_password], resource[:truststore_password], resource[:https_hostname], resource[:https_port], resource[:certificate_file], resource[:privatekey_file])
    # rescue RubyAem::Error => e
    # if e.result.response.status_code == 0
    #   with_retries(max_tries: opts[:_retries][:max_tries], base_sleep_seconds: opts[:_retries][:base_sleep_seconds], max_sleep_seconds: opts[:_retries][:max_sleep_seconds]) { |retries_count|
    #     check_result = is_enabled
    #     puts format('SSL Enable check #%<retries_count>d: %<check_result_data>s - %<check_result_message>s', retries_count: retries_count, check_result_data: check_result.data, check_result_message: check_result.message)
    #     raise StandardError.new(check_result.message) if check_result.data == false
    #     return check_result if check_result.data == true
    #   }
    # else
    #   raise RubyAem::Error.new(message, result)
    # end
    result = call_with_readiness_check(ssl, 'enable_wait_until_ready', [**opts, **build_opts], resource)
    handle(result)

  end
    # def enable(keystore_password ,truststore_password ,https_hostname ,https_port ,privatekey_file ,certificate_file)

  #   handle(result)
  # end

  # # Delete the certificate from the AEM Truststore.
  def destroy

    ssl = client(resource).ssl
    result = ssl.disable
    handle(result)

  end

  def exists?
    ssl = client(resource).ssl
    result = ssl.get
    ssl_properties = result.response.body.properties
    p ssl_properties
    puts ssl_properties
  end
end

