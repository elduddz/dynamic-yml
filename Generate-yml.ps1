$job = @"
- job: __spokename__
  steps:
  - task: AzureCLI@1
    inputs:
      azureSubscription: 'Enterprise'
      scriptLocation: 'scriptPath'
      scriptPath: './tfplan.sh'
      arguments: __KVname__ __spokename__

"@
	  
$spokes = (Get-ChildItem -Path ./spokes/* -Directory)

$spokes

$yml = @"
jobs:

"@

foreach($spoke in $spokes) {
	$spoke
	if($spoke.name -like "_*") { continue }
	$bits = $spoke.name.split('-')
	$environment = $bits[1]
	$environment
	$spokeJob = $job
	$spokeJob = $spokeJob.replace("__spokename__", $spoke.name)
	$spokeJob = $spokeJob.replace("__KVname__", "KeyVault$environment-KV")
	
	$yml += $spokeJob
}

$yml