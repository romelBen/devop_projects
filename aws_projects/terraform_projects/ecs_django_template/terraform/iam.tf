# Here is the necessary instance role that will be necessary when buidling your image on ECS
resource "aws_iam_role" "ecs-instance-role" {
    name                = "bevy-ec2-instance-role"
    assume_role_policy  = file("policies/ecs-role.json")
}

# Another policy attachment to the role of the above
resource "aws_iam_role_policy_attachment" "ecs-instance-role-attachment" {
    role                = aws_iam_role.ecs-instance-role.name
    policy_arn          = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# The current IAM instance profile attached with the ecs-instance-role
resource "aws_iam_instance_profile" "ecs_service_role" {
    role                = aws_iam_role.ecs-instance-role.name
}

/*
resource "aws_iam_service_linked_role" "ecs" {
    aws_service_name    = "ecs.amazonaws.com"
}
*/