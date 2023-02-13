output "aws_vpc" {
  value = data.aws_vpc.main
}

output "aws_subnet_ids" {
  value = {
    "web"  = data.aws_subnet_ids.web
    "app"  = data.aws_subnet_ids.app
    "data" = data.aws_subnet_ids.data
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
