resource "aws_instance" "myinstance" {
  connection {
    user        = "${var.user}"
    private_key = "${file("${var.key_pair_file}")}"

    bastion_host        = "${var.bastion_host}"
    bastion_user        = "${var.bastion_user}"
    bastion_private_key = "${file("${var.bastion_key_pair_file}")}"
  }
