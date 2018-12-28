
# Kubectx, kubens & kubectl

For having a clean slate to use [kubectx|kubens](https://github.com/ahmetb/kubectx), you might want to clean your kubectl configuration.
Following, there are two simple commands to keep the clusters and contexts clean.

Be careful as **this will delete all previously fetched credentials** from your clusters. To determine which clusters and contexts were available before atempting this, use:

    $ kubectl config view
   Alternatively, if you installed kubectx, just run it and it will show the current contexts.

## Cleaning kubectl

    $ kubectl config get-clusters | awk 'FNR > 1' | xargs -L 1 kubectl config delete-cluster

    $ kubectl config get-contexts | awk 'FNR > 1 {print $1}' | xargs -L 1 kubectl config delete-context

## Installing kubectx and kubens

    sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
    sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
    sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
For further instructions check the [kubectx repo](https://github.com/ahmetb/kubectx).
