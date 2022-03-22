param appName string
param region string
param env string

output managedIdentityName string = 'mi-${appName}-${region}-${env}'
output automationAccountName string = 'aa-${appName}-${region}-${env}'
