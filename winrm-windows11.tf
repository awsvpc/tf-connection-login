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
  
  [...]
  
  provisioner "file" {
    content     = "${data.template_file.windows_script.rendered}"
    destination = "C:/windows_script.ps1"
  }

  provisioner "remote-exec" {
    inline = [ 
      "powershell.exe C:/windows_script.ps1"
    ]
  }
}
