resource "aws_security_group" "allow-traffic-ecs" {
 
  vpc_id         = "${var.VPC_ID}"
  name        = "${var.APPLICATION_NAME}-allow-traffic-ecs"
  description = "security group that allows ssh and all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.APPLICATION_NAME}-allow-traffic-ecs"
  }
}
