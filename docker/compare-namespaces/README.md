This script compares the namespaces between 2 containers.

Initially, this was to probe that a Pod Sandbox was also a container and that it shares its network namespace with the containers inside that pod :D

# Important, must be run as root and has to pass as argument the pattern to search with grep (default to nginx) :p
