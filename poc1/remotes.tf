data "terraform_remote_state" "bain-central-virtualwan" {
  backend = "remote"

  config = {
    hostname     = "app.terraform.io"
    organization = "flyingnets-greg"
    workspaces = {
      name = "terraform"
    }
  }
}
