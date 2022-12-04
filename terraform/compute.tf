resource "aws_security_group" "http-sg" {
  name        = "allow_http_access"
  description = "allow inbound http traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "Allow traffic from all to port 8080"
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH access to the Instance"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    to_port     = "0"
  }
  tags = {
    "Owner" = "osman.shaikh@systemsltd.com"
  }
}
data "aws_ami" "amazon_ami" {
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20220606.1-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  most_recent = true
  owners      = ["amazon"]
}

resource "aws_instance" "app-server1" {
  instance_type               = var.instance_type
  ami                         = data.aws_ami.amazon_ami.id
  vpc_security_group_ids      = [aws_security_group.http-sg.id]
  subnet_id                   = aws_subnet.private-2a.id
  private_ip                  = "172.16.10.5"
  key_name                    = "shaikh-tf-keypair"
  associate_public_ip_address = var.instance-associate-public-ip
  tags = {
    "Owner" = "osman.shaikh@systemsltd.com"
  }
  user_data = file("user_data.tpl")
}

resource "null_resource" "file_transfer" {
  connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${file("../shaikh-tf-keypair-west.pem")}"
      host        = "${aws_instance.app-server1.public_dns}"
    }
  provisioner "file" {
    source      = "../jboss-setup/"
    destination = "/home/ec2-user/jboss"
  }
  provisioner "remote-exec" {
    inline = [
      "ls /home/ec2-user"
    ]    
  }
}