resource "aws_key_pair" "praterra" {
  key_name   = "praterra"
  public_key = file(var.key_pair_path)
}