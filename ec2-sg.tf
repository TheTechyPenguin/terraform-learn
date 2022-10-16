resource "aws_security_group" "ec2-sg" {
  name        = "aws-ec2-sg-praterra"
  description = var.ec2_sg_decsription
  vpc_id      = aws_vpc.praterravpc.id
  ingress {
    from_port   = var.sg_from_port_ssh
    to_port     = var.sg_to_port_ssh
    cidr_blocks = [var.sg_cidr_block]
    protocol    = var.sg_protocol
  }
  ingress {
    from_port   = var.sg_from_port_http
    to_port     = var.sg_to_port_http
    cidr_blocks = [var.sg_cidr_block]
    protocol    = var.sg_protocol
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]

  }

}