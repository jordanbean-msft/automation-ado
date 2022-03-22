param automationAccountName string
param location string
param managedIdentityName string

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' existing = {
  name: managedIdentityName
}

resource automationAccount 'Microsoft.Automation/automationAccounts@2021-06-22' = {
  name: automationAccountName
  location: location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${managedIdentity.id}': {}      
    }
  }
  properties: {
    sku: {
      name: 'Basic'
    }
  }
  resource userAssignedManagedIdentityClientIdVariable 'variables@2019-06-01' = {
    name: 'AUTOMATION_SC_USER_ASSIGNED_IDENTITY_ID'
    properties: {
      value: '"${managedIdentity.properties.clientId}"'
    }
  }
}
