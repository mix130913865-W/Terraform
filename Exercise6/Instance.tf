# 建立 EC2 instance 主要資源
resource "aws_instance" "web" {
  ami                    = var.amiID[var.region]          # 依照 region 取得對應 AMI ID
  instance_type          = "t3.micro"                     # 免費額度常用機型
  key_name               = "dove-key"                     # EC2 使用的 Key Pair 名稱
  vpc_security_group_ids = [aws_security_group.dove-sg.id]# 套用指定的 Security Group
  availability_zone      = var.zone1                      # 指定部署至 AZ（例如 us-east-1a）

  # EC2 標籤
  tags = {
    Name    = "Dove-web"
    Project = "Dove"
  }

  # --- Provisioner Section ---

  # 將本地端 web.sh 複製到 EC2 /tmp/
  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  # provisioner 所需的 SSH 連線資訊
  connection {
    type        = "ssh"
    user        = var.webuser     # Ubuntu 預設使用 ubuntu
    private_key = file("dovekey") # 私鑰檔案
    host        = self.public_ip  # 使用 EC2 的 public IP 連線
  }

  # 在 EC2 上執行指令
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",  # 給執行權限
      "sudo /tmp/web.sh"       # 執行安裝腳本
    ]
  }

  # 在本機執行指令（例如輸出私有 IP）
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
}

# 確保 Instance State 為 running（可用於控制依賴）
resource "aws_ec2_instance_state" "web-state" {
  instance_id = aws_instance.web.id
  state       = "running"
}

# 在本地終端輸出 Public IP
output "WebPublicIP" {
  description = "Public IP of web instance"
  value       = aws_instance.web.public_ip
}

# 在本地終端輸出 Private IP
output "WebPrivateIP" {
  description = "Private IP of web instance"
  value       = aws_instance.web.private_ip
}
