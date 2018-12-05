provider "aws" {
	region = "ap-south-1"
}

resource "aws_instance" "demo" {
	ami = "ami-84e3b2eb"
	instance_type = "t2.micro"

	tags {
		Name = "demo-instance-1"
	}
}