provider "aws" {
	region = "ap-south-1"
}

resource "aws_instance" "demo" {
	ami = "ami-84e3b2eb"
	instance_type = "t2.micro"
	vpc_security_group_ids = ["${aws_security_group.instance.id}"]
	user_data = <<-EOF
					#!/bin/bash
					echo "Hello World!" > index.html
					nohup busybox httpd -f -p "${var.server_port}" &
					EOF

	tags {
		Name = "demo-instance-1"
	}
}

resource "aws_security_group" "instance" {
	name = "demo-instance-1"

	ingress {
		from_port = "${var.server_port}"
		to_port = "${var.server_port}"
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
}
