function DownloadAndInstallModuleIfNotAvailable([string]$ModuleName,[ScriptBlock]$runIfInstalled=$null,$ArgumentList=$null) {
    Import-Module $ModuleName -ErrorAction SilentlyContinue -ArgumentList $ArgumentList
    if (!$?) {
        # install from PowerShell Gallery
        Install-Module -Name $ModuleName -Verbose -Scope CurrentUser
        if ($?) {
            if ($null -ne $runIfInstalled) {
                & $runIfInstalled
            }
            Import-Module -Name $ModuleName -Verbose -ArgumentList $ArgumentList
        }   
    }
}

if ($host.Name -eq 'ConsoleHost') {
    DownloadAndInstallModuleIfNotAvailable 'posh-git'
    # not yet # DownloadAndInstallModuleIfNotAvailable 'Fasdr'
    DownloadAndInstallModuleIfNotAvailable 'PsFzf' -ArgumentList 'CTRL+T','CTRL+R'
}
    