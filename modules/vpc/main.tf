#### VPC ####
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "${var.env}-vpc"
  }
}

#### IGW ####
resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id

    tags = {
      Name = "${var.env}-igw"
    }
}

#### Public Subnets ####
resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = var.azs[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.env}-public-subnet-${count.index + 1}"
    }
}

#### Private Subnets ####
resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = var.azs[count.index]

    tags = {
        Name = "${var.env}-private-subnet-${count.index + 1}"
    }
}

#### Private DB Subnets ####
resource "aws_subnet" "private_db" {
    count = length(var.private_db_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_db_subnet_cidrs[count.index]
    availability_zone = var.azs[count.index]

    tags = {
        Name = "${var.env}-private-db-subnet-${count.index + 1}"
    }
}

#### EIPs for NAT Gateways ####
resource "aws_eip" "nat" {
    depends_on = [aws_internet_gateway.main]

    tags = {
        Name = "${var.env}-nat-eip"
    }
}

#### NAT Gateways ####
resource "aws_nat_gateway" "main" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public[0].id

    tags = {
        Name = "${var.env}-nat-gateway"
    }
}

#### Public Route Table ####
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }

    tags = {
        Name = "${var.env}-public-rt"
    }
}

resource "aws_route_table_association" "public" {
    count = length(aws_subnet.public)
    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

#### Private Route Table ####
resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.main.id
    }

    tags = {
        Name = "${var.env}-private-rt"
    }
}

resource "aws_route_table_association" "private" {
    count = length(aws_subnet.private)
    subnet_id = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private.id
}

#### Private DB Route Table ####
resource "aws_route_table" "private_db" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${var.env}-private-db-rt"
    }
}

resource "aws_route_table_association" "private_db" {
    count = length(aws_subnet.private_db)
    subnet_id = aws_subnet.private_db[count.index].id
    route_table_id = aws_route_table.private_db.id
}
