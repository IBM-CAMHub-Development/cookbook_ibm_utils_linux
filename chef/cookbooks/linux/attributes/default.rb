# Cookbook Name:: linux
# Recipe:: attributes/default
#
# Copyright IBM Corp. 2016, 2017
#

############################################################################################################
# STANDARD Environemnt Settings
############################################################################################################

# <> The URL to the root directory of the HTTP server hosting the software installation packages i.e. http://<hostname>:<port>
default['ibm']['sw_repo_root'] = ''

default['ibm']['repo_user'] = ''

default['ibm']['repo_password'] = ''

# <> If a secure Software repo is used but it uses a self signed SSL certificate this should be set to "true"
default['ibm']['sw_repo_self_signed_cert'] = "true"

# <> If a secure Software repo is used and basic authentication is required you should set this to "true"
default['ibm']['sw_repo_auth'] = "true"

#-------------------------------------------------------------------------------
# Landscaper compatibility attributes
#-------------------------------------------------------------------------------

# <>  The stack id
default['ibm_internal']['stack_id'] = ''
# #<> Stack ID to search on
# force_default['linux']['stack_id'] = node['stack_id']

# <>  The stack name
default['ibm_internal']['stack_name'] = ''

# <>  List of roles on the node
default['ibm_internal']['roles'] = ''

# <>  The vault name for this stack
default['ibm_internal']['vault']['name'] = ''

# <>  The vault item which will contain the secrets
default['ibm_internal']['vault']['item'] = ''


default['linux']['vault']['name'] = node['ibm_internal']['vault']['name']

# <> ID in the vault that is encrypted. Preferably the root ID, to encrypt everything
default['linux']['vault']['encrypted_id'] = node['ibm_internal']['vault']['item']

#-------------------------------------------------------------------------------
# <> YUM repository Configuration
# <md>attribute 'linux/configure/yum_repositories',
# <md>          :displayname =>  'Configure YUM Repositories',
# <md>          :description => 'Boolen Flag to configure YUM Repositories',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'

default['linux']['configure']['yum_repositories'] = 'false'

# <md>attribute 'linux/yum_repositories/repo01/description',
# <md>          :displayname =>  'Description',
# <md>          :description => 'Description of the YUM respository',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'Yum Repository 1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/yum_repositories/repo01/repositoryid',
# <md>          :displayname =>  'Respository ID',
# <md>          :description => 'Repository ID Name',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'CAM Repository',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/yum_repositories/repo01/baseurl',
# <md>          :displayname =>  'Base YUM URL',
# <md>          :description => 'URL For accessing YUM Repository',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'https://xx',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/yum_repositories/repo01/enabled',
# <md>          :displayname =>  'Enable YUM Repo',
# <md>          :description => 'Enable True/False Flag',
# <md>          :type => 'boolean',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/yum_repositories/repo01/gpgkey',
# <md>          :displayname =>  'GPG Key for Repository',
# <md>          :description => 'Location of GPG Key',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/yum_repositories/repo01/gpgcheck',
# <md>          :displayname =>  'Enable GPGCheck Repo',
# <md>          :description => 'GPGCheck True/False Flag',
# <md>          :type => 'boolean',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/yum_repositories/repo01/sslverify',
# <md>          :displayname =>  'Enable sslverify Repo',
# <md>          :description => 'sslverify True/False Flag',
# <md>          :type => 'boolean',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/yum_repositories/repo01/sslcacert',
# <md>          :displayname =>  'Location of  sslcacert ',
# <md>          :description => 'Location of  sslcacert '',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'


default['linux']['yum_repositories'] = {
  'repo01' => { 'description' => '',
                'repositoryid' => '',
                'baseurl' => '',
                'enabled' => true,
                'gpgkey' => '',
                'gpgcheck' => true,
                'sslverify' => true,
                'sslcacert' => ''


              }
}
