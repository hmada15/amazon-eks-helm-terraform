resource "aws_eip" "nat" {
  domain = "vpc"

  tags = merge(var.terraform_tags, {
    Name = "nat"
  })
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_zone1.id

  tags = merge(var.terraform_tags, {
    Name = "nat"
  })

  depends_on = [aws_internet_gateway.igw]
}
