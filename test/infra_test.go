package test

import (
  "testing"
  "github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTerraformInfra(t *testing.T) {
  opts := &terraform.Options{
    TerraformDir: "../",
  }

  terraform.InitAndApply(t, opts)
}
