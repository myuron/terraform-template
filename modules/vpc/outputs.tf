output "vpc_id" {
  description = "VPCのIDです"
  value = aws_vpc.vpc.id
}

output "vpc_name" {
  description = "作成したVPCの名前です"
  value = aws_vpc.vpc.tags["Name"]
}

output "public_subnets" {
  description = "パブリックサブネットの情報です"
  value = { for subnet in aws_subnet.public_subnets:
  subnet.availability_zone => subnet.id }
}

output "private_subnets" {
  description = "プライベートサブネットの情報です"
  value = { for subnet in aws_subnet.private_subnets:
  subnet.availability_zone => subnet.id }
}
