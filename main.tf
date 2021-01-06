terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.11"
    }
  }
}

locals {
  env_map = {
    dev     = "Dev"
    test    = "Test"
    prod    = "Prod"
    sandbox = "Sandbox"
    unclass = "UnClass"
  }
  environment        = local.env_map[lower(var.environment)]
  vpc_name           = "${local.environment}_vpc"
  availability_zones = list("a", "b")
  web_subnet_names   = [for az in local.availability_zones : "Web_${local.environment}_az${az}_net"]
  app_subnet_names   = [for az in local.availability_zones : "App_${local.environment}_az${az}_net"]
  data_subnet_names  = [for az in local.availability_zones : "Data_${local.environment}_az${az}_net"]
  mgmt_subnet_names  = [for az in local.availability_zones : "Mgmt_${local.environment}_az${az}_net"]
}

data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = [local.vpc_name]
  }
}

data "aws_subnet_ids" "web" {
  vpc_id = data.aws_vpc.main.id
  filter {
    name   = "tag:Name"
    values = local.web_subnet_names
  }
}

data "aws_subnet_ids" "app" {
  vpc_id = data.aws_vpc.main.id
  filter {
    name   = "tag:Name"
    values = local.app_subnet_names
  }
}

data "aws_subnet_ids" "data" {
  vpc_id = data.aws_vpc.main.id
  filter {
    name   = "tag:Name"
    values = local.data_subnet_names
  }
}

data "aws_subnet_ids" "mgmt" {
  vpc_id = data.aws_vpc.main.id
  filter {
    name   = "tag:Name"
    values = local.mgmt_subnet_names
  }
}

data "aws_subnet" "web" {
  for_each = data.aws_subnet_ids.web.ids
  id       = each.value
}

data "aws_subnet" "app" {
  for_each = data.aws_subnet_ids.app.ids
  id       = each.value
}

data "aws_subnet" "data" {
  for_each = data.aws_subnet_ids.data.ids
  id       = each.value
}

data "aws_subnet" "mgmt" {
  for_each = data.aws_subnet_ids.mgmt.ids
  id       = each.value
}
