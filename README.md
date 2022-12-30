
# Ecowatt Data Infra (WIP)

Contains terraform scripts to setup necessary resources for Ecowatt data Google Cloud project. It initializes
an Artifact Registry and a service account which is impersonated by Github actions to push images on the registry
(See [REFERENCES.md](REFERENCES.md) for more details on this mechanism).
The terraform scripts outputs variables which can be used in the Github actions workflows of Ecowatt Data Jobs


- Install terraform

```
brew install terraform
```

- Create google project
- On your workstation, log to the project with Gcloud Cli

```
gcloud auth application-default login
```

- Verify data_jobs_github_actions/variables.tf in registry folder and apply scripts

```
cd data_jobs_github_actions
terraform init
terraform apply
```

- Build and push your first images to this repo then deploy Cloud Run jobs (WIP)
<!> Google Cloud run job is not yet available in Terraform, should be available in a few weeks

https://github.com/hashicorp/terraform-provider-google/issues/13194

```
cd data_jobs_cloud_run
terraform init
terraform apply
```