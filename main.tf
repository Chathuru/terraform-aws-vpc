locals {
  vpc_id   = aws_vpc.this.id
  tag_name = join("-", [var.environment, var.project])
}

resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = join("-", [local.tag_name, "vpc"])
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  vpc_id                  = local.vpc_id
  cidr_block              = values(var.public_subnets)[count.index]
  availability_zone       = keys(var.public_subnets)[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = join("-", [local.tag_name, "public", "subnet"])
  }

  depends_on = [aws_vpc.this]
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  vpc_id            = local.vpc_id
  cidr_block        = values(var.private_subnets)[count.index]
  availability_zone = keys(var.private_subnets)[count.index]

  tags = {
    Name = join("-", [local.tag_name, "private", "subnet"])
  }

  depends_on = [aws_vpc.this]
}

resource "aws_internet_gateway" "this" {
  vpc_id = local.vpc_id

  tags = {
    Name = join("-", [local.tag_name, "ig"])
  }

  depends_on = [aws_vpc.this]
}

resource "aws_eip" "this" {
  count = var.enable_private_subnet && length(var.private_subnets) > 0 && length(var.public_subnets) > 0 ? 1 : 0

  vpc = true

  tags = {
    Name = join("-", [local.tag_name, "eip"])
  }
  depends_on = [aws_vpc.this]
}

resource "aws_nat_gateway" "private" {
  count = var.enable_private_subnet && length(var.private_subnets) > 0 && length(var.public_subnets) > 0 ? 1 : 0

  allocation_id = aws_eip.this[0].id
  subnet_id     = element(aws_subnet.public.*.id, count.index)

  tags = {
    Name = join("-", [local.tag_name, "natgw"])
  }

  depends_on = [aws_eip.this, aws_subnet.public]
}

resource "aws_route_table" "public" {
  vpc_id = local.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = join("-", [local.tag_name, "rt"])
  }

  depends_on = [aws_vpc.this, aws_internet_gateway.this]
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id

  depends_on = [aws_vpc.this, aws_route_table.public]
}

resource "aws_route_table" "private" {
  count = var.enable_private_subnet && length(var.private_subnets) > 0 && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = local.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.private[0].id
  }

  tags = {
    Name = join("-", [local.tag_name, "rt"])
  }

  depends_on = [aws_vpc.this, aws_subnet.private, aws_nat_gateway.private]
}

resource "aws_route_table_association" "private" {
  count = var.enable_private_subnet && length(var.private_subnets) > 0 && length(var.public_subnets) > 0 ? length(var.private_subnets) : 0

  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private[0].id

  depends_on = [aws_vpc.this, aws_route_table.private]
}
