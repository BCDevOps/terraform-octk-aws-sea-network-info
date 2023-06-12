output "aws_vpc" {
  value = data.aws_vpc.main
}

output "aws_subnet_ids" {
  value = {
    "web"  = data.aws_subnets.web.ids
    "app"  = data.aws_subnets.app.ids
    "data" = data.aws_subnets.data.ids
  }
}

output "aws_subnet" {
  value = {
    "web"  = data.aws_subnet.web
    "app"  = data.aws_subnet.app
    "data" = data.aws_subnet.data
  }
}

output "aws_security_groups" {
  value = {
    "web"  = data.aws_security_group.web
    "app"  = data.aws_security_group.app
    "data" = data.aws_security_group.data
  }
}
