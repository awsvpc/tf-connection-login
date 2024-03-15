data "template_file" "lnx_script" {
  template = "${file("${path.module}/templates/lnx_script.sh")}"
  vars {
    var1 = "${var.var1}"
  }
}

resource "aws_instance" "myinstance" {
  connection {
    type        = "ssh"
    user        = "${var.lnx_user}"
    private_key = "${file("${var.jenkins_slave_key_pair_file}")}"

    bastion_user        = "${var.bastion_user}"
    bastion_host        = "${var.bastion_host}"
    bastion_private_key = "${file("${var.bastion_key_pair_file}")}"
  }
  
  [...]
  
  provisioner "file" {
    content     = "${data.template_file.lnx_script.rendered}"
    destination = "/tmp/lnx_script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/lnx_script.sh",
      "/tmp/lnx_script.sh args",
    ]
  }
}
