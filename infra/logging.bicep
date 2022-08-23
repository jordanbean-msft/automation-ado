param logAnalyticsWorkspaceName string
param location string

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2020-08-01' = {
  name: logAnalyticsWorkspaceName
  location: location
  properties: {
    sku: {
      name: 'Standard'
    }
  }
}

output logAnalyticsWorkspaceName string = logAnalyticsWorkspaceName
