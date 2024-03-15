data "template_file" "windows_script" {
  template = "${file("${path.module}/templates/windows_script.ps1")}"
  vars {
    var1 = "${var.var1}"
  }
}

resource "aws_instance" "myinstance" {
  connection {
    type     = "winrm"
    user     = "${var.windows_user}"
    password = "${var.windows_password}"
  }
  
  user_data  = "${data.template_file.windows_script.rendered}"
  [...]
}
