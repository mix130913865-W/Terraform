# 預設 Region
variable "region" {
  default = "us-east-1"
}

# 預設 Availability Zone
variable "zone1" {
  default = "us-east-1a"
}

# EC2 預設登入帳號（Ubuntu 使用 ubuntu）
variable "webuser" {
  default = "ubuntu"
}

# AMI ID Map（依照 region 選不同 AMI）
variable "amiID" {
  type = map(any)

  default = {
    us-east-2 = "ami-036841078a4b68e14"
    us-east-1 = "ami-0e2c8caa4b6378d8c"
  }
}
