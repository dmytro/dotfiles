log_level                :info
log_location             STDOUT
node_name                'dmytro'
client_key               '/Users/dmytro/.chef/dmytro.pem'
validation_client_name   'chef-validator'
validation_key           '/etc/chef/validation.pem'
chef_server_url          'http://svaroh.local:4000'
cache_type               'BasicFile'
cache_options( :path => '/Users/dmytro/.chef/checksums' )
cookbook_path 		  ["."]
cookbook_copyright        "Dmytro Kovalov"
cookbook_email            "dmytro.kovalov@gmail.com"
cookbook_license          "apachev2"

