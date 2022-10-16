resource "aws_instance" "praterraec2" {
  count                  = var.instnce_count
  instance_type          = lookup(var.instance_type, terraform.workspace)
  ami                    = data.aws_ami.ubuntu.id
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  subnet_id              = aws_subnet.praterra-public-subnet.*.id[count.index]
  user_data_base64       = base64encode(file("/home/prasanta/terraform_2022-06-04/scripts/shell.sh"))
  key_name               = aws_key_pair.praterra.key_name
  tags = {
    "Name" = "${var.project_name}-EC2-${count.index + 1}"
    "ENV"  = "${terraform.workspace}"
  }
}