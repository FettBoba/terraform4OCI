variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}

variable "compartment_ocid" {}
variable "ssh_public_key" {}
variable "ssh_private_key" {}
variable "region" {}

#variable "dhcp_options_ocid" {}

#variable "SubnetOCID" {}
#
#variable "AD" {
#    default = "2"
#}

#Network
variable "VPC-CIDR" {
default = "10.100.0.0/16"
}

variable "LBSubNet1AD1CIDR" {
default = "10.100.1.0/24"
}

variable "LBSubNet2AD2CIDR" {
default = "10.100.2.0/24"
}

variable "LBSubNet3AD3CIDR" {
default = "10.100.3.0/24"
}

variable "WEBSubNet1AD1CIDR" {
default = "10.100.4.0/24"
}

variable "WEBSubNet2AD2CIDR" {
default = "10.100.5.0/24"
}

variable "WEBSubNet3AD3CIDR" {
default = "10.100.6.0/24"
}

variable "STORSubNet1AD1CIDR" {
default = "10.100.7.0/24"
}

variable "STORSubNet2AD2CIDR" {
default = "10.100.8.0/24"
}

variable "STORSubNet3AD3CIDR" {
default = "10.100.9.0/24"
}


#Compute
variable "WEBShape" {
    default = "VM.Standard1.4"
#    default = "VM.DenseIO1.4"
}

variable "STORShapeL" {
#    default = "BM.HighIO1.36"
#    default = "VM.DenseIO1.4"
    default = "VM.Standard1.4"
}

variable "STORShapeM" {
    default = "VM.Standard1.2"
}

variable "STORShapeS" {
    default = "VM.Standard1.1"
}

variable "InstanceOS" {
    default = "CentOS"
}

variable "InstanceOSVersion" {
    default = "7"
}

#variable "InstanceOS" {
#    default = "Oracle Linux"
#}
#
#variable "InstanceOSVersion" {
#    default = "7.3"
#}

variable "256GB" {
    default = "50"
}

variable "2TB" {
    default = "2048"
}

variable "storsrv1BootStrapFile" {
    default = "./userdata/bootstrapGlusterNode"
}

variable "storsrv2BootStrapFile" {
    default = "./userdata/bootstrapGlusterNode"
}

variable "storsrv3BootStrapFile" {
    default = "./userdata/bootstrapGlusterNode"
}

variable "client2BootStrapFile" {
    default = "./userdata/bootstrapClient02"
}
