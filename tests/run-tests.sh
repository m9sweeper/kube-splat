# To Do Testing. Install Minikube

# To install the latest minikube stable release on x86-64 macOS using binary download:

echo "\n\n\n\n----------------------------- DEPLOYING TESTS WITH NO CONFIGS -----------------------------------\n\n\n\n"

#curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
#sudo install minikube-darwin-amd64 /usr/local/bin/minikube
brew install minikube

#If which minikube fails after installation via brew, you may have to remove the old minikube links and link the newly installed binary:

brew unlink minikube
brew link minikube

# Start your cluster

echo "\n\n\n\n----------------------------- Starting Minikube Cluster -----------------------------------\n\n\n\n"
minikube start

# Interact with your cluster

kubectl get po -A

# Now run ansible playbook

ansible-playbook deploy.yml -i inventories/dev.yml
