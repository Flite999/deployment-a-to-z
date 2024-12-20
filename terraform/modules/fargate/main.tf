
module "iam" {
  source = "./modules/iam"
}


resource "aws_ecs_cluster" "default" {
  name = "a-to-z-cluster"
}

resource "aws_ecs_task_definition" "frontend" {
  family                   = "frontend"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = module.iam.ecs_task_execution_role_arn

  container_definitions = jsonencode([
    {
      name  = "frontend"
      image = "ghcr.io/flite999/frontend:latest"
      repositoryCredentials = {
        credentialsParameter = "arn:aws:secretsmanager:us-east-1:183631321835:secret:ecr-pullthroughcache/fliteghcr-uMHtjJ"
      }
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

resource "aws_ecs_task_definition" "backend" {
  family                   = "backend"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = module.iam.ecs_task_execution_role_arn

  container_definitions = jsonencode([
    {
      name  = "backend"
      image = "ghcr.io/flite999/backend:latest"
      repositoryCredentials = {
        credentialsParameter = "arn:aws:secretsmanager:us-east-1:183631321835:secret:ecr-pullthroughcache/fliteghcr-uMHtjJ"
      }
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

resource "aws_lb" "frontend" {
  name               = "frontend-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets
}

resource "aws_lb" "backend" {
  name               = "backend-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets
}

resource "aws_lb_listener" "frontend" {
  load_balancer_arn = aws_lb.frontend.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
}

resource "aws_lb_listener" "backend" {
  load_balancer_arn = aws_lb.backend.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }
}

resource "aws_lb_target_group" "frontend" {
  name        = "frontend-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}

resource "aws_lb_target_group" "backend" {
  name        = "backend-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}

resource "aws_ecs_service" "frontend" {
  name            = "frontend-service"
  cluster         = aws_ecs_cluster.default.id
  task_definition = aws_ecs_task_definition.frontend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_groups
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.frontend.arn
    container_name   = "frontend"
    container_port   = 80
  }
}

resource "aws_ecs_service" "backend" {
  name            = "backend-service"
  cluster         = aws_ecs_cluster.default.id
  task_definition = aws_ecs_task_definition.backend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_groups
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.backend.arn
    container_name   = "backend"
    container_port   = 80
  }
}

variable "subnets" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}

output "frontend_dns_name" {
  value = aws_lb.frontend.dns_name
}

output "backend_dns_name" {
  value = aws_lb.backend.dns_name
}

variable "vpc_id" {
  description = "vpc ID for load balancers"
  type        = string
}
