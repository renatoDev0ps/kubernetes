locals = {
  cluster_name                 = "kops.infordigi.tk"
  master_autoscaling_group_ids = ["${aws_autoscaling_group.master-us-east-2a-masters-kops-infordigi-tk.id}"]
  master_security_group_ids    = ["${aws_security_group.masters-kops-infordigi-tk.id}"]
  masters_role_arn             = "${aws_iam_role.masters-kops-infordigi-tk.arn}"
  masters_role_name            = "${aws_iam_role.masters-kops-infordigi-tk.name}"
  node_autoscaling_group_ids   = ["${aws_autoscaling_group.nodes-kops-infordigi-tk.id}"]
  node_security_group_ids      = ["${aws_security_group.nodes-kops-infordigi-tk.id}"]
  node_subnet_ids              = ["${aws_subnet.us-east-2a-kops-infordigi-tk.id}"]
  nodes_role_arn               = "${aws_iam_role.nodes-kops-infordigi-tk.arn}"
  nodes_role_name              = "${aws_iam_role.nodes-kops-infordigi-tk.name}"
  region                       = "us-east-2"
  route_table_public_id        = "${aws_route_table.kops-infordigi-tk.id}"
  subnet_us-east-2a_id         = "${aws_subnet.us-east-2a-kops-infordigi-tk.id}"
  vpc_cidr_block               = "${aws_vpc.kops-infordigi-tk.cidr_block}"
  vpc_id                       = "${aws_vpc.kops-infordigi-tk.id}"
}

output "cluster_name" {
  value = "kops.infordigi.tk"
}

output "master_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.master-us-east-2a-masters-kops-infordigi-tk.id}"]
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-kops-infordigi-tk.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-kops-infordigi-tk.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-kops-infordigi-tk.name}"
}

output "node_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.nodes-kops-infordigi-tk.id}"]
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-kops-infordigi-tk.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.us-east-2a-kops-infordigi-tk.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-kops-infordigi-tk.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-kops-infordigi-tk.name}"
}

output "region" {
  value = "us-east-2"
}

output "route_table_public_id" {
  value = "${aws_route_table.kops-infordigi-tk.id}"
}

output "subnet_us-east-2a_id" {
  value = "${aws_subnet.us-east-2a-kops-infordigi-tk.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.kops-infordigi-tk.cidr_block}"
}

output "vpc_id" {
  value = "${aws_vpc.kops-infordigi-tk.id}"
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_autoscaling_group" "master-us-east-2a-masters-kops-infordigi-tk" {
  name                 = "master-us-east-2a.masters.kops.infordigi.tk"
  launch_configuration = "${aws_launch_configuration.master-us-east-2a-masters-kops-infordigi-tk.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-east-2a-kops-infordigi-tk.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "kops.infordigi.tk"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-east-2a.masters.kops.infordigi.tk"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-east-2a"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  tag = {
    key                 = "kops.k8s.io/instancegroup"
    value               = "master-us-east-2a"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-kops-infordigi-tk" {
  name                 = "nodes.kops.infordigi.tk"
  launch_configuration = "${aws_launch_configuration.nodes-kops-infordigi-tk.id}"
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = ["${aws_subnet.us-east-2a-kops-infordigi-tk.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "kops.infordigi.tk"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.kops.infordigi.tk"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  tag = {
    key                 = "kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "a-etcd-events-kops-infordigi-tk" {
  availability_zone = "us-east-2a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                         = "kops.infordigi.tk"
    Name                                      = "a.etcd-events.kops.infordigi.tk"
    "k8s.io/etcd/events"                      = "a/a"
    "k8s.io/role/master"                      = "1"
    "kubernetes.io/cluster/kops.infordigi.tk" = "owned"
  }
}

resource "aws_ebs_volume" "a-etcd-main-kops-infordigi-tk" {
  availability_zone = "us-east-2a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                         = "kops.infordigi.tk"
    Name                                      = "a.etcd-main.kops.infordigi.tk"
    "k8s.io/etcd/main"                        = "a/a"
    "k8s.io/role/master"                      = "1"
    "kubernetes.io/cluster/kops.infordigi.tk" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-kops-infordigi-tk" {
  name = "masters.kops.infordigi.tk"
  role = "${aws_iam_role.masters-kops-infordigi-tk.name}"
}

resource "aws_iam_instance_profile" "nodes-kops-infordigi-tk" {
  name = "nodes.kops.infordigi.tk"
  role = "${aws_iam_role.nodes-kops-infordigi-tk.name}"
}

resource "aws_iam_role" "masters-kops-infordigi-tk" {
  name               = "masters.kops.infordigi.tk"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.kops.infordigi.tk_policy")}"
}

resource "aws_iam_role" "nodes-kops-infordigi-tk" {
  name               = "nodes.kops.infordigi.tk"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.kops.infordigi.tk_policy")}"
}

resource "aws_iam_role_policy" "masters-kops-infordigi-tk" {
  name   = "masters.kops.infordigi.tk"
  role   = "${aws_iam_role.masters-kops-infordigi-tk.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.kops.infordigi.tk_policy")}"
}

resource "aws_iam_role_policy" "nodes-kops-infordigi-tk" {
  name   = "nodes.kops.infordigi.tk"
  role   = "${aws_iam_role.nodes-kops-infordigi-tk.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.kops.infordigi.tk_policy")}"
}

resource "aws_internet_gateway" "kops-infordigi-tk" {
  vpc_id = "${aws_vpc.kops-infordigi-tk.id}"

  tags = {
    KubernetesCluster                         = "kops.infordigi.tk"
    Name                                      = "kops.infordigi.tk"
    "kubernetes.io/cluster/kops.infordigi.tk" = "owned"
  }
}

resource "aws_key_pair" "kubernetes-kops-infordigi-tk-6e494f6f0d4bd8876bf4c1565e4a61db" {
  key_name   = "kubernetes.kops.infordigi.tk-6e:49:4f:6f:0d:4b:d8:87:6b:f4:c1:56:5e:4a:61:db"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.kops.infordigi.tk-6e494f6f0d4bd8876bf4c1565e4a61db_public_key")}"
}

resource "aws_launch_configuration" "master-us-east-2a-masters-kops-infordigi-tk" {
  name_prefix                 = "master-us-east-2a.masters.kops.infordigi.tk-"
  image_id                    = "ami-0c30b86d048a27876"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-kops-infordigi-tk-6e494f6f0d4bd8876bf4c1565e4a61db.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-kops-infordigi-tk.id}"
  security_groups             = ["${aws_security_group.masters-kops-infordigi-tk.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-east-2a.masters.kops.infordigi.tk_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-kops-infordigi-tk" {
  name_prefix                 = "nodes.kops.infordigi.tk-"
  image_id                    = "ami-0c30b86d048a27876"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-kops-infordigi-tk-6e494f6f0d4bd8876bf4c1565e4a61db.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-kops-infordigi-tk.id}"
  security_groups             = ["${aws_security_group.nodes-kops-infordigi-tk.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.kops.infordigi.tk_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_route" "0-0-0-0--0" {
  route_table_id         = "${aws_route_table.kops-infordigi-tk.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.kops-infordigi-tk.id}"
}

resource "aws_route_table" "kops-infordigi-tk" {
  vpc_id = "${aws_vpc.kops-infordigi-tk.id}"

  tags = {
    KubernetesCluster                         = "kops.infordigi.tk"
    Name                                      = "kops.infordigi.tk"
    "kubernetes.io/cluster/kops.infordigi.tk" = "owned"
    "kubernetes.io/kops/role"                 = "public"
  }
}

resource "aws_route_table_association" "us-east-2a-kops-infordigi-tk" {
  subnet_id      = "${aws_subnet.us-east-2a-kops-infordigi-tk.id}"
  route_table_id = "${aws_route_table.kops-infordigi-tk.id}"
}

resource "aws_security_group" "masters-kops-infordigi-tk" {
  name        = "masters.kops.infordigi.tk"
  vpc_id      = "${aws_vpc.kops-infordigi-tk.id}"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                         = "kops.infordigi.tk"
    Name                                      = "masters.kops.infordigi.tk"
    "kubernetes.io/cluster/kops.infordigi.tk" = "owned"
  }
}

resource "aws_security_group" "nodes-kops-infordigi-tk" {
  name        = "nodes.kops.infordigi.tk"
  vpc_id      = "${aws_vpc.kops-infordigi-tk.id}"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                         = "kops.infordigi.tk"
    Name                                      = "nodes.kops.infordigi.tk"
    "kubernetes.io/cluster/kops.infordigi.tk" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kops-infordigi-tk.id}"
  source_security_group_id = "${aws_security_group.masters-kops-infordigi-tk.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-kops-infordigi-tk.id}"
  source_security_group_id = "${aws_security_group.masters-kops-infordigi-tk.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-kops-infordigi-tk.id}"
  source_security_group_id = "${aws_security_group.nodes-kops-infordigi-tk.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "https-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-kops-infordigi-tk.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-kops-infordigi-tk.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-kops-infordigi-tk.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kops-infordigi-tk.id}"
  source_security_group_id = "${aws_security_group.nodes-kops-infordigi-tk.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kops-infordigi-tk.id}"
  source_security_group_id = "${aws_security_group.nodes-kops-infordigi-tk.id}"
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kops-infordigi-tk.id}"
  source_security_group_id = "${aws_security_group.nodes-kops-infordigi-tk.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kops-infordigi-tk.id}"
  source_security_group_id = "${aws_security_group.nodes-kops-infordigi-tk.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-kops-infordigi-tk.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.nodes-kops-infordigi-tk.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "us-east-2a-kops-infordigi-tk" {
  vpc_id            = "${aws_vpc.kops-infordigi-tk.id}"
  cidr_block        = "172.20.32.0/19"
  availability_zone = "us-east-2a"

  tags = {
    KubernetesCluster                         = "kops.infordigi.tk"
    Name                                      = "us-east-2a.kops.infordigi.tk"
    SubnetType                                = "Public"
    "kubernetes.io/cluster/kops.infordigi.tk" = "owned"
    "kubernetes.io/role/elb"                  = "1"
  }
}

resource "aws_vpc" "kops-infordigi-tk" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                         = "kops.infordigi.tk"
    Name                                      = "kops.infordigi.tk"
    "kubernetes.io/cluster/kops.infordigi.tk" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "kops-infordigi-tk" {
  domain_name         = "us-east-2.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster                         = "kops.infordigi.tk"
    Name                                      = "kops.infordigi.tk"
    "kubernetes.io/cluster/kops.infordigi.tk" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "kops-infordigi-tk" {
  vpc_id          = "${aws_vpc.kops-infordigi-tk.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.kops-infordigi-tk.id}"
}

terraform = {
  required_version = ">= 0.9.3"
}
