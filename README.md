# AWS VPC Terraform module

Terraform module which creates VPC resources on AWS.

## Usage
```hcl
module "vpc" {
  source          = "<path_to_module>"
  project         = "project"
  environment     = "dev"
  cidr_block      = "10.22.0.0/16"
  public_subnets  = { "us-east-1a" : "10.22.0.0/18", "us-east-1b" : "10.22.64.0/18" }
  private_subnets = { "us-east-1a" : "10.22.128.0/18", "us-east-1b" : "10.22.192.0/18" }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.56 |

## Resources

| Name | Type |
|------|------|
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project | Name of the project | `string` | - | yes |
| env | Environment name | `string` | - | yes |
| cidr_block | The CIDR block for the VPC | `string` | - | yes |
| public_subnets | 	A map of public subnets inside the VPC with respective availability zone | `map(string)` | {} | no |
| private_subnets | A map of private subnets inside the VPC with respective availability zone | `map(string)` | {} | no |
| enable_private_subnet| Enable creating private subnet with NAT gateway | `bool` | true | no |
| enable_dns_hostnames | Should be true to enable DNS hostnames in the VPC | `bool` | true | no |
| enable_dns_support | Should be true to enable DNS support in the VPC	bool | `bool` | false | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | The ID of the VPC |
| name | The name of the VPC generated from the module |
| vpc_arn | The ARN of the VPC |
| private_subnets | List of IDs of private subnets |
| private_subnet_arns | List of ARNs of private subnets |
| public_subnets | List of IDs of public subnets |
| public_subnet_arns | List of ARNs of public subnets |
