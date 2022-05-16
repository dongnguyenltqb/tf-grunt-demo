## Terragrunt example

1. Structure

- /code
  - /components
  - /modules
- /live
  - /dev
  - /prod
- /vars
  - dev.tfvars

2. Command

- to spin up infra for an evirontment like dev or staging
  ```shell
  cd live/ENV
  tg run-all apply -var-file=../../../vars/ENV.tfvars
  ```
