provider "aws" {
	region = "ap-south-1"
}

resource "aws_instance" "demo" {
	ami = "ami-84e3b2eb"
	instance_type = "t2.micro"

	user_data = <<-EOF
#!/bin/bash
echo "Hello World!" > index.html
nohup busybox httpd -f -p 8080 &
EOF

	tags {
		Name = "demo-instance-1"
	}
}

resource "aws_security_group" "instance" {
	name = "demo-instance-1"

	ingress {
		from_port = 8080
		to_port = 8080
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
}