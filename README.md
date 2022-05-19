## Terragrunt example

1. Structure

- /code
  - /components
    - /network
    - /ec2
  - /modules
    - /vpc
- /live
  - /dev
    - /network
    - /ec2
  - /prod
    - /network
    - /ec2
- /vars
  - dev.tfvars

2. Command

- to spin up infra for an evirontment like dev or staging
  ```shell
  cd live/ENV
  tg run-all apply -var-file=$PATH_TO_VAR_FILE
  ```
