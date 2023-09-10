# Noisy Neighbors
Setting up a lil network with UDP enabled, to test out some WCF over UDP stuff.

First, set up a resource group NoisyNeighborsRG.

Then bicep that thing:

    git clone https://github.com/sebug/noisy-neighbors/
    cd noisy-neighbors
    az deployment group create -f ./main.bicep -g NoisyNeighborsRG

After it's in place, go to the app storage account and upload your exe that you want to test. The blob container may be anonymous (the storage account has a random name and you'll be downloading an exe without any private information, right?), the point is just we'll have to install it on the three machines. Copy the URL of the exe in the public blob container.

Finally, go to the resource group and one of the VMs and put Bastion into place to connect. Know that you can use the little >> chevron to paste the URL of the exe you just uploaded so that you can

    Invoke-WebRequest -Uri TheURIYouPasted -OutFile installit.msi
