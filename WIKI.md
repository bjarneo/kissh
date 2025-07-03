# KiSSH Wiki

This document provides a reference for all the aliases and functions available in the KiSSH framework.

## Aliases

### Directory Navigation

- `..`: Move up one directory.
- `...`: Move up two directories.
- `....`: Move up three directories.

### Docker

- `d`: Alias for `docker`.
- `dc`: Alias for `docker-compose`.
- `di`: Alias for `docker images`.
- `dps`: Alias for `docker ps`.
- `dpsa`: Alias for `docker ps -a`.
- `dlogs`: Alias for `docker logs`.
- `dlogsf`: Alias for `docker logs -f`.

### eza

_These aliases are only available if `eza` is installed._

- `ls`: List files with `eza -lh --group-directories-first --icons=auto`.
- `lsa`: List all files, including hidden ones.
- `lt`: Display a tree view of files and directories.
- `lta`: Display a tree view of all files and directories, including hidden ones.

### Git

- `ga`: `git add`
- `gaa`: `git add --all`
- `gc`: `git commit`
- `gcm`: `git commit -m`
- `gca`: `git commit --amend`
- `gst`: `git status`
- `gs`: `git status -s`
- `gp`: `git pull`
- `gpush`: `git push`
- `gco`: `git checkout`
- `gcb`: `git checkout -b`
- `gb`: `git branch`
- `gm`: `git merge`
- `gr`: `git rebase`
- `gl`: `git log --oneline --graph --decorate`
- `gf`: `git fetch`
- `gd`: `git diff`
- `gds`: `git diff --staged`

### Kubectl

- `k`: `kubectl`
- `kgp`: `kubectl get pods`
- `kgd`: `kubectl get deployment`
- `kgs`: `kubectl get service`
- `kgn`: `kubectl get nodes`
- `kdp`: `kubectl describe pod`
- `kdd`: `kubectl describe deployment`
- `kds`: `kubectl describe service`
- `kdn`: `kubectl describe node`
- `kl`: `kubectl logs`
- `kpf`: `kubectl port-forward`
- `kex`: `kubectl exec -it`

### Xclip

- `xclip`: `xclip -selection clipboard`
- `pbcopy`: `xclip -selection clipboard`
- `pbpaste`: `xclip -selection clipboard -o`

## Functions

### Docker

- `dclean-containers`: Stop and remove all Docker containers.
- `dclean-images`: Remove all Docker images.
- `dprune`: Prune the Docker system (removes stopped containers, dangling images, and unused networks).
- `dexec <container_name_or_id> [shell_command]`: Execute a shell (or a given command) in a running container.
- `dip <container_name_or_id>`: Get the IP address of a container.

### Git

- `git_branch`: Show the current Git branch.
- `git_dirty`: Show a `*` if the working directory is dirty.

### Kubectl

- `kube_context`: Show the current kubectl context.
- `kube_namespace`: Show the current kubectl namespace.
