//-------------------------------------------------------------------
// Vault settings
//-------------------------------------------------------------------

variable "vault_download_url" {
    default = "https://s3-us-west-2.amazonaws.com/hc-enterprise-binaries/vault/ent/0.10.4/vault-enterprise_0.10.4%2Bent_linux_amd64.zip"
    description = "URL to download Vault"

}

variable "consul_download_url" {
    default = "https://s3-us-west-2.amazonaws.com/hc-enterprise-binaries/consul/ent/1.2.2/consul-enterprise_1.2.2%2Bent_linux_amd64.zip"
    description = "URL to download Consul"

}

variable "vault_config" {
  description = "Configuration (text) for Vault"
  default = <<EOF
listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}
  backend "consul" {
  address = "127.0.0.1:8500"
  path    = "vault/"
}
ui=true
EOF
}

variable "consul_config" {
    description = "Configuration (text) for Consul"
    default = <<EOF
{
  "log_level": "INFO",
  "server": true,
  "ui": true,
  "data_dir": "/opt/consul/data",
  "bind_addr": "0.0.0.0",
  "client_addr": "0.0.0.0",
  "advertise_addr": "IP_ADDRESS",
  "bootstrap_expect": 3,
  "retry_join": ["provider=aws tag_key=ConsulAutoJoin tag_value=TAG_VALUE region=us-east-1"],
  "service": {
    "name": "consul"
  }
}
EOF
}

variable "vault_extra_install" {
    default = ""
    description = "Extra commands to run in the vault install script"
}

variable "consul_extra_install" {
    default = ""
    description = "Extra commands to run in the consul install script"
}

//-------------------------------------------------------------------
// AWS settings
//-------------------------------------------------------------------

variable "ami" {
    #Ubuntu 14.04
    #default = "ami-7eb2a716"
    #Ubuntu 16.04
    default = "ami-759bc50a"
    description = "AMI for Vault instances"
}

variable "instance_name" {
    default = "vault"
    description = "name of Vault EC2 instance"
}

variable "public_ip" {
    default = false
    description = "should ec2 instance have public ip?"
}

variable "name_prefix" {
    default = "vault"
    description = "prefix used in resource names"
}

variable "availability_zones" {
    default = "us-east-1a,us-east-1b,us-east-1c"
    description = "Availability zones for launching the Vault instances"
}

variable "elb_health_check" {
    default = "HTTP:8200/v1/sys/health?standbyok=true"
    description = "Health check for Vault servers"
}

variable "elb_internal" {
    default = true
    description = "make ELB internal or external"
}

variable "instance_type" {
    default = "t2.medium"
    description = "Instance type for Vault instances"
}

variable "key_name" {
    default = "default"
    description = "SSH key name for Vault instances"
}

variable "nodes" {
    default = "3"
    description = "number of Vault instances"
}

variable "subnets" {
    description = "list of subnets to launch Vault within"
}

variable "vpc_id" {
    description = "VPC ID"
}

variable "owner" {
    description = "value of owner tag on EC2 instances"
}

variable "ttl" {
    description = "value of ttl tag on EC2 instances"
}

variable "auto_join_tag" {
    description = "value of ConsulAutoJoin tag used by Consul cluster"
}
