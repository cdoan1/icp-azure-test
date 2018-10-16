# Patch for installer to support azure cloud provider

Uses the in-tree cloud provider

- Create azure_cloud_config for kubelet on all nodes
Works with
{
"resourceGroup": "<rg_name>",
    "cloud": "AzurePublicCloud",
    "subscriptionId": "<subscription>",
    "tenantId": "<tentant>",
    "useInstanceMetadata": true,
    "useManagedIdentityExtension": true
}
Without resourcegroup in kubelet volume mounts fail with

```
  Warning  FailedMount  12m (x50 over 1h)  kubelet, worker2  MountVolume.WaitForAttach failed for volume "pvc-f7c835cb-b797-11e8-a3ed-000d3a451e3a" : compute.VirtualMachinesClient#Get: Failure responding to request: StatusCode=403 -- Original Error: autorest/azure: Service returned an error. Status=403 Code="AuthorizationFailed" Message="The client 'b8674925-67e8-4b13-bf58-718c3070dcaa' with object id 'b8674925-67e8-4b13-bf58-718c3070dcaa' does not have authorization to perform action 'Microsoft.Resources/subscriptions/resourceGroups/Microsoft.Compute/worker2/read' over scope '/subscriptions/<snip>/resourceGroups/providers/Microsoft.Compute/virtualMachines'
```
Seems like /resourceGroups/<resourcegroup>/providers/ was shortened to /resourceGroups/providers
Resource group is available from InstanceMetadata, but seems to be a bug...

- Create azure_cloud_config-controller
Works with
{
    "aadClientId": "<snip>",
    "aadClientSecret": "<snip>",
    "cloud": "AzurePublicCloud",
    "cloudProviderBackoff": false,
    "location": "westeurope",
    "resourceGroup": "icp_rg",
    "routeTableName": "icp_route",
    "securityGroupName": "",
    "subnetName": "icp-container-network",
    "subscriptionId": "<snip>",
    "tenantId": "<snip>",
    "useInstanceMetadata": true,
    "vnetName": "vnet",
    "vnetResourceGroup": "icp_rg"
}
