$job = @"
- job: __jobname__
  steps:
  - task: AzureCLI@1
    inputs:
      azureSubscription: 'Enterprise'
      scriptLocation: 'scriptPath'
      scriptPath: './terraform.sh'
      arguments: __KVname__ __spokename__

"@
	  
$spokes = (Get-ChildItem -Path ./spokes/* -Directory)

$spokes

$yml = @"
trigger: 
  - master

pr: none

jobs:

"@

foreach($spoke in $spokes) {
	if($spoke.name -like "_*") { continue }
  $bits = $spoke.name.split('-')
  $jobName = $bits[0]
	$environment = $bits[1]
	$spokeJob = $job

	$spokeJob = $spokeJob.replace("__jobname__", $jobName)
	$spokeJob = $spokeJob.replace("__spokename__", $spoke.name)
	$spokeJob = $spokeJob.replace("__KVname__", "Enterprise$environment-KV")
	
	$yml += $spokeJob
}

$yml | Set-Content -Path .\azure-pipelines.yml