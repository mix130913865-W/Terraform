# 透過 AWS AMI Data Source 動態查詢 Ubuntu 22.04 最新版本的 AMI ID
data "aws_ami" "amiID" {
  most_recent = true  # 取得最新版本的 AMI

  # 篩選名稱符合 ubuntu jammy 22.04 server 版本
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  # 使用 HVM 虛擬化方式
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # Ubuntu 官方 AMI 擁有者 ID（Canonical）
  owners = ["099720109477"]
}

# 輸出查詢到的 AMI ID
output "instance_id" {
  description = "AMI ID of Ubuntu instance"
  value       = data.aws_ami.amiID.id
}
