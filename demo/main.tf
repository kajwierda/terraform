variable "aws_security_group_id" {default = "sg-08cd4d06198a49a94"}
variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  region = "us-east-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}
resource "aws_instance" "example" {
  ami = "ami-2d39803a"
  instance_type = "t2.micro"
vpc_security_group_ids = ["${var.aws_security_group_id}"]

user_data = <<-EOF
              #!/bin/bash
              echo "Whatever" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

tags = {
    Name = "HelloWorld"
  }

}
