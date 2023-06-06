<!--
Hey, thanks for using the awesome-readme-template template.
If you have any enhancements, then fork this project and create a pull request
or just open an issue with the label "enhancement".

Don't forget to give this project a star for additional support ;)
Maybe you can mention me or this repo in the acknowledgements too
-->
<div align="center">

  <h1>kube-splat</h1>


  <p>

</p>

<!-- Badges -->
<p>
  <a href="https://github.com/m9sweeper/kube-splat/graphs/contributors">
    <img src="https://img.shields.io/github/contributors/m9sweeper/kube-splat" alt="contributors" />
  </a>
  <a href="">
    <img src="https://img.shields.io/github/last-commit/m9sweeper/kube-splat" alt="last update" />
  </a>
  <a href="https://github.com/m9sweeper/kube-splat/network/members">
    <img src="https://img.shields.io/github/forks/m9sweeper/kube-splat" alt="forks" />
  </a>
  <a href="https://github.com/m9sweeper/kube-splat/stargazers">
    <img src="https://img.shields.io/github/stars/m9sweeper/kube-splat" alt="stars" />
  </a>
  <a href="https://github.com/m9sweeper/kube-splat/issues/">
    <img src="https://img.shields.io/github/issues/m9sweeper/kube-splat" alt="open issues" />
  </a>

  <a href="https://github.com/m9sweeper/kube-splat/blob/main/LICENSE">
    <img src="assets/license.svg" alt="license" />
  </a>
</p>

<h4>
    <a href="https://github.com/m9sweeper/kube-splat/issues/">Report Bug</a>
  <span> · </span>
    <a href="https://github.com/m9sweeper/kube-splat/issues/">Request Feature</a>
  </h4>
</div>

<br />

<!-- Table of Contents -->

# :notebook_with_decorative_cover: Table of Contents

- [About the Project](#star2-about-the-project)

  - [Features List](#dart-features)
  - [Tool Box](#toolbox-toolbox)
  - [Prerequisites](#bangbang-prerequisites)
  - [Quick Install](#gear-quick-installation)

- [Contributors](#wave-contributing)
- [License](#warning-license)
- [Contact](#handshake-contact)

<!-- About the Project -->

## :star2: About the Project

kube-splat is responsible for installing infrastructure tools using ansible. It comes with an ansible role with a number
of configurable tasks - just add your kubernetes cluster details and run a one-line command to install a suite of
useful tools.

<!-- Features -->

### :dart: Features

kube-splat makes life very easy for organisations with:

- Monitoring Solution
- Logging Solution
- Kubernetes Security Platform
- Management and Issuance of TLS certificates
- Metrics Server
- Ingress-Nginx Controller
- Descheduler

<!-- Getting Started -->

## :toolbox: Toolbox

kube-splat makes it easy to orchestrate the implementation of a number of free security tools:

[m9sweeper](https://github.com/m9sweeper/m9sweeper/tree/main): Kubernetes Security Platform

[kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts): Monitoring Solution

[loki-stack](https://github.com/grafana/helm-charts/tree/main/charts/loki-stack): Logging Solution

[Cert Manager](https://artifacthub.io/packages/helm/cert-manager/cert-manager): Management and Issuance of TLS certificates

[Metric Server](https://github.com/open-policy-agent/gatekeeper): Metrics Server

[Nginx Ingress](https://falco.org/): Ingress-Nginx Controller

[Descheduler](https://github.com/kubernetes-sigs/descheduler): Descheduler

<!-- Prerequisites -->

### :bangbang: Prerequisites

This project requires a Kubernetes Cluster and uses ansible-playbook as package manager

If you don't have a Kubernetes Cluster running, you can install one locally with Minikube using the following directions

#### Installing Kubernetes Locally with Minikube

##### Mac Installation

Install on Mac from the terminal using curl

```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
sudo install minikube-darwin-amd64 /usr/local/bin/minikube
```

##### Windows Installation

Install on Windows using chocolatey

```bash
choco install minikube
choco install git
```

Once Minikube is installed, run the following command to start up a local cluster

```bash
minikube start --cni calico --kubernetes-version=v1.23.16
```

You can check that the cluster was successfully created and is running using `kubectl get pods --all-namespaces` to see
if default pods were created. For more information, check out the official [minikube docs](https://minikube.sigs.k8s.io/docs/start/).

<!-- Installation -->

### :gear: Quick Installation

To install, first edit the following files to match the details of your Kubernetes cluster. If running a local Minikube
cluster, the default values should suffice

#### **Add/Modify common variables in all.yml**
####
```bash
File path: group_vars/all.yml
```
#### **Add/Modify cluster base variable in host_vars.**

####
```bash
cat host_vars/minikube.yml
---
kube_context: minikube
k8s_cluster_name: minikube
```
#### **Manage your cluster related details in inventories.**
####
```bash
cat inventories/dev.yml
all:
  vars:
    kube_context: minikube
  hosts:
    localhost
```

### **Deploy on minikube**
####

Once the details for your cluster have been filled in, just run the following command to set up everything

```bash
ansible-playbook deploy.yml -i inventories/dev.yml
```

# **Notes**
## **Local Installation**
When running against a local minikube cluster, some steps (m9sweeper, metrics-server, and nginx) may fail on a first
time installation. This is expected, and they should run without issue after rerunning the playbook

## **Upgrading**
### kube-prometheus-stack
Many times upgrades will require updating the CRD's first.  In the future it we plan to break CRD's into their own helm
chart to alleviate this issue, but for now you will typically have to run commands such as these below (with the updated version number)

```
kubectl apply --server-side --force-conflicts -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.61.1/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagerconfigs.yaml
kubectl apply --server-side --force-conflicts -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.61.1/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagers.yaml
kubectl apply --server-side --force-conflicts -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.61.1/example/prometheus-operator-crd/monitoring.coreos.com_podmonitors.yaml
kubectl apply --server-side --force-conflicts -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.61.1/example/prometheus-operator-crd/monitoring.coreos.com_probes.yaml
kubectl apply --server-side --force-conflicts -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.61.1/example/prometheus-operator-crd/monitoring.coreos.com_prometheuses.yaml
kubectl apply --server-side --force-conflicts -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.61.1/example/prometheus-operator-crd/monitoring.coreos.com_prometheusrules.yaml
kubectl apply --server-side --force-conflicts -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.61.1/example/prometheus-operator-crd/monitoring.coreos.com_servicemonitors.yaml
kubectl apply --server-side --force-conflicts -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.61.1/example/prometheus-operator-crd/monitoring.coreos.com_thanosrulers.yaml
```


<!-- Contributing -->

## :wave: Contributing


The initial project was created by team members at Intelletive Consulting, but we hope others will contribute as well.
Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/jacobbeasley"><img src="https://avatars.githubusercontent.com/u/433581?v=4?s=100" width="100px;" alt="Jacob Beasley"/><br /><sub><b>Jacob Beasley</b></sub></a><br /><a href="https://github.com/m9sweeper/kube-splat/commits?author=jacobbeasley" title="Code">💻</a> <a href="https://github.com/m9sweeper/kube-splat/commits?author=jacobbeasley" title="Documentation">📖</a> <a href="#research-jacobbeasley" title="Research">🔬</a> <a href="#projectManagement-jacobbeasley" title="Project Management">📆</a> <a href="#infra-jacobbeasley" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://www.linkedin.com/in/jason-woodman-8604476/"><img src="assets/jason.jpeg" width="100px;" alt="jasonWoodman"/><br /><sub><b>jasonWoodman</b></sub></a><br /><a href="https://github.com/m9sweeper/kube-splat/commits?author=jasonWoodman" title="Code">💻</a> <a href="https://github.com/m9sweeper/kube-splat/commits?author=jasonWoodman" title="Documentation">📖</a> <a href="#research-jasonWoodman" title="Research">🔬</a> <a href="#projectManagement-jasonWoodman" title="Project Management">📆</a> <a href="#infra-jasonWoodman" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/charisprose"><img src="assets/generic-female-icon.jpg" width="100px;" alt="charisprose"/><br /><sub><b>charisprose</b></sub></a><br /><a href="https://github.com/m9sweeper/kube-splat/commits?author=charisprose" title="Code">💻</a> <a href="https://github.com/m9sweeper/kube-splat/commits?author=charisprose" title="Tests">⚠️</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/GrantWK"><img src="https://avatars.githubusercontent.com/u/17361213?v=4?s=100" width="100px;" alt="Grant Keiner"/><br /><sub><b>Grant Keiner</b></sub></a><br /><a href="https://github.com/m9sweeper/kube-splat/commits?author=GrantWK" title="Code">💻</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://www.linkedin.com/in/sahil-narang-bab6a2135/"><img src="assets/sahil-narang.jpeg" width="100px;" alt="Sahil Narang"/><br /><sub><b>Sahil Narang</b></sub><br /><a href="https://github.com/m9sweeper/kube-splat/commits?author=" title="Code">💻</a> <a href="#infra" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

<!-- License -->

## :warning: License

Distributed under the Apache License v2. See LICENSE.txt for more information.

<!-- Contact -->

## :handshake: Contact

Project Link: [https://github.com/m9sweeper/kube-splat](https://github.com/m9sweeper/kube-splat)

