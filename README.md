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
- /vars
  - dev.tfvars

2. Forder struct description
   2.1 code

3. Command

- to spin up infra for an evirontment like dev or staging
  ```shell
  cd live/ENV
  tg run-all apply -var-file=../../../vars/ENV.tfvars
  ```
