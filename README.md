# Noisy Neighbors
Setting up a lil network with UDP enabled, to test out some WCF over UDP stuff.

First, set up a resource group NoisyNeighborsRG.

Then bicep that thing:

    git clone https://github.com/sebug/noisy-neighbors/
    cd noisy-neighbors
    az deployment group create -f ./main.bicep -g NoisyNeighborsRG

After it's in place, go to the app storage account and upload your exe that you want to test.

Finally, go to the resource group and one of the VMs and put Bastion into place to connect.