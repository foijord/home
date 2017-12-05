## In your home folder, initialize a git repo:
`git init .`

## Add this repository as a remote:
`git remote add origin https://github.com/foijord/home.git`

## Fetch dotfiles and scripts:
`git pull origin master`

## create deployment in hostvm folder:
`gcloud deployment-manager deployments create hostvm-deployment --config hostvm.yaml`
`gcloud deployment-manager deployments update hostvm-deployment --config hostvm.yaml`
