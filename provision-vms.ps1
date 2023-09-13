# Download the developer image on it
cd F:\
Invoke-WebRequest -Uri 'https://aka.ms/windev_VM_hyperv' -OutFile out.zip
'inner1', 'inner2', 'inner3' | ForEach-Object {
    $vmName = $_
    Expand-Archive .\out.zip $vmName
}
'inner1', 'inner2', 'inner3' | ForEach-Object {
    $vmName = $_
    New-VM -Name $vmName -MemoryStartupBytes 8096MB -Path ('F:\' + $vmName + '.local') -Generation 2 -SwitchName 'NestedSwitch' -VHDPath ('F:\' + $vmName + '\WinDev2308Eval.vhdx') -BootDevice VHD
    Enable-VMIntegrationService -VMName $vmName -Name 'Guest Service Interface'
    Start-VM -VMName $vmName
}

