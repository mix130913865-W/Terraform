# Terraform EC2 Deployment Project

示範如何使用 Terraform 自動化建立 AWS EC2、AMI 查詢、Provisioners，以及輸出公私 IP。

---

## 專案架構

本專案會自動完成以下事項：

* 查詢最新的 Ubuntu 22.04 AMI
* 建立 EC2 Instance（t3.micro）
* 套用 Security Group
* 上傳並執行啟動腳本（web.sh）
* 自動輸出 Public / Private IP
* 將 Private IP 寫入本地 `private_ips.txt`

---

## 專案檔案說明

```
.
├── InstID.tf        # 查詢最新 Ubuntu AMI
├── Instance.tf      # 建立 EC2 instance + provisioners
├── Keypair.tf       # 建立 EC2 Key Pair
├── SecGrp.tf        # 建立 Security Group（dove-sg）
├── backend.tf       # Terraform backend 設定（S3）
├── dovekey.pub      # 公鑰檔案（Keypair.tf 會用到）
├── provider.tf      # AWS Provider 設定
├── var.tf           # 變數設定
├── web.sh           # EC2 架設網站初始化腳本
└── .gitignore       # 忽略敏感或暫存檔案
```

---

## 自訂變數

你可以在 `var.tf` 修改：

* AWS Region
* AZ
* 預設登入使用者
* 各 Region 對應的 AMI Map

---

## 技術說明

### Data Source 查詢 AMI

專案使用 `aws_ami` 自動取得最新 Ubuntu server AMI。

### Provisioners

使用三種 provisioners：

* **file**：上傳 web.sh
* **remote-exec**：在 EC2 執行腳本
* **local-exec**：寫入本地 private_ips.txt

### Output

`output` 只會顯示在 Terraform apply 完成後的 terminal，方便複製使用。
