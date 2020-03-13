resource "aws_iam_role_policy" "ecs_auto_scaling_policy" {
  name = "${var.APPLICATION_NAME}_auto_scaling_policy"
  role = "${aws_iam_role.ecs_auto_scaling_role.id}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
            "ecs:DescribeServices",
            "ecs:UpdateService",
            "cloudwatch:DeleteAlarms",
            "cloudwatch:DescribeAlarms",
            "cloudwatch:PutMetricAlarm"          
     
       ],
            "Resource": "*"
        }
    ]
}

EOF
}

resource "aws_iam_role" "ecs_auto_scaling_role" {
  name = "${var.APPLICATION_NAME}_auto_scaling_role"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        
        "Service": "ecs.application-autoscaling.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}

EOF
}



