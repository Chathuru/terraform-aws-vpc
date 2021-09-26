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
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| <a  name="input_project"></a>  [project](#input\_project) | Name of the project | `string` | N/A | yes |
| <a  name="input_environment"></a>  [environment](#input\_environment) | Environment Name | `string` | N/A | yes |
| <a  name="input_cidr_block"></a>  [cidr\_block](#input\_cidr\_block) | The CIDR block for the VPC | `string` | N/A | yes |
| <a  name="input_public_subnets"></a>  [public\_subnets](#input\_public\_subnets) | 	A map of public subnets inside the VPC with respective availability zone | `map(string)` | {} | no |
| <a  name="input_private_subnets"></a>  [private\_subnets](#input\_private\_subnets) | A map of private subnets inside the VPC with respective availability zone | `map(string)` | {} | no |
| <a  name="input_enable_private_subnet"></a>  [enable\_private\_subnet](#input\_enable\_private\_subnet)| Enable creating private subnet with NAT gateway | `bool` | true | no |
| <a  name="input_enable_dns_hostnames"></a>  [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | Should be true to enable DNS hostnames in the VPC | `bool` | true | no |
| <a  name="input_enable_dns_support"></a>  [enable\_dns\_support](#input\_enable\_dns\_support) | Should be true to enable DNS support in the VPC | `bool` | false | no |

## Outputs

| Name | Description |
|------|-------------|
| <a  name="output_vpc_id"></a>  [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a  name="output_name"></a>  [name](#output\_name) | The name of the VPC generated from the module |
| <a  name="output_vpc_arn"></a>  [vpc\_arn](#output\_vpc\_arn) | The ARN of the VPC |
| <a  name="output_private_subnets"></a>  [private\_subnets](#output\_private\_subnets) | List of IDs of private subnets |
| <a  name="output_private_subnet_arns"></a>  [private\_subnet\_arns](#output\_private\_subnet\_arns) | List of ARNs of private subnets |
| <a  name="output_public_subnets"></a>  [public\_subnets](#output\_public\_subnets) | List of IDs of public subnets |
| <a  name="output_public_subnet_arns"></a>  [public\_subnet\_arns](#output\_public\_subnet\_arns) | List of ARNs of public subnets |
