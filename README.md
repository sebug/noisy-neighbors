# Noisy Neighbors
Setting up a lil network with UDP enabled, to test out some WCF over UDP stuff. Since the Azure network doesn't allow UDP multicast,
have to actually create VMs inside the VMs.

First, set up a resource group NoisyNeighborsRG.

Then bicep that thing:

    git clone https://github.com/sebug/noisy-neighbors/
    cd noisy-neighbors
    az deployment group create -f ./main.bicep -g NoisyNeighborsRG

After it's in place, go to the app storage account and upload your exe that you want to test. The blob container may be anonymous (the storage account has a random name and you'll be downloading an exe without any private information, right?), the point is just we'll have to install it on the machine. Copy the URL of the exe in the public blob container.

Finally, go to the VM and put Bastion into place to connect. Know that you can use the little >> chevron to paste the URL of the exe you just uploaded so that you can

    Invoke-WebRequest -Uri TheURIYouPasted -OutFile installit.msi

Activate Hyper-V and download the developer VHDX: https://developer.microsoft.com/en-us/windows/downloads/virtual-machines/

Create three machines out of that.