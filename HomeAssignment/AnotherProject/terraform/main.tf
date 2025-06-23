provider "aws" {
    region = "ap-south-1"
    profile = "priyesh"
}

resource "aws_key_pair" "deployer" {
    key_name   = "deployer-key" 
    public_key = file("~/.ssh/id_rsa.pub")
    # public_key = file("${pathexpand("~/.ssh/deployer-key.pub")}")
}
# resource "aws_key_pair" "deployer" {
#   key_name   = "deployer-key"
# } 


resource "aws_security_group" "web_sg" {
    name        = "web-sg"
    description = "Allow SSH & 5000"
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 5000
        to_port     = 5000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "web" {
    ami             = "ami-0cda377a1b884a1bc" # Amazon Linux 2 in Mumbai
    instance_type   = "t2.micro"
    key_name        = aws_key_pair.deployer.key_name
    security_groups = [aws_security_group.web_sg.name]
    
    provisioner "remote-exec" {
        inline = [
            "sudo yum update -y",
            "sudo amazon-linux-extras install docker -y",
            "sudo systemctl enable docker",
            "sudo systemctl start docker",
            "sudo usermod -aG docker ec2-user"
        ]
        connection {
            type        = "ssh"
            user        = "ec2-user"
            private_key = file("~/.ssh/id_rsa")
            host        = self.public_ip
        }
    }
}
