# Shared tflint configuration for every module under infra/.
# Run from a module directory:  tflint --config ../.tflint.hcl --recursive
# The deploy-lab workflow runs the same file, so what fails locally fails in CI.

config {
  call_module_type = "local"
  force            = false
}

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}
