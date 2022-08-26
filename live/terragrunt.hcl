remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "skip"
  }
  config = {
    bucket = "dong-tfgrunt-state"

    key    = "${path_relative_to_include()}/terraform.tfstate"
    region = "ap-southeast-1"
  }
}
