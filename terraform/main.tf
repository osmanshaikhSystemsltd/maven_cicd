resource "aws_vpc" "this" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    "Owner" = "osman.shaikh@systemsltd.com"
  }
}

resource "aws_subnet" "private-2a" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "172.16.10.0/28"
  availability_zone = "${var.region}a"
  tags = {
    "Owner" = "osman.shaikh@systemsltd.com"
  }
}

resource "aws_route_table" "this-rt" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Owner" = "osman.shaikh@systemsltd.com"
  }
}

resource "aws_route_table_association" "private-2a" {
  subnet_id      = aws_subnet.private-2a.id
  route_table_id = aws_route_table.this-rt.id
}

resource "aws_internet_gateway" "this-igw" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Owner" = "osman.shaikh@systemsltd.com"
  }
}

resource "aws_route" "internet-route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.this-rt.id
  gateway_id             = aws_internet_gateway.this-igw.id
}


# data "aws_eip" "web" {
#   id = "eipalloc-0eabd8ba2992df9ca"
# }

# resource "aws_eip_association" "eip_assoc" {
#   instance_id   = aws_instance.app-server1.id
#   allocation_id = data.aws_eip.web.id
#   depends_on = [
#     aws_instance.app-server1
#   ]
# }