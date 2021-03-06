locals {
  target_groups = ["primary", "secondary"]
  hosts_name    = ["${var.hosts_name}"] #example : fill your information
}

resource "aws_alb" "jenkins" {
  name               = "${var.ecs_cluster_name}-service-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.aws_security_group_jenkins_alb_id]
  subnets            = split( ",", var.alb_subnet_ids)

  tags = {
    Name = var.ecs_cluster_name
  }
}

resource "aws_alb_target_group" "jenkins" {
  count = length(local.target_groups)
  name  = "${var.ecs_cluster_name}-tg-${element(local.target_groups, count.index)}"

  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc
  target_type = "instance"

  health_check {
    path                = "/login"
    port                = var.container_port
    protocol            = "HTTP"
    timeout             = "10"
    interval            = "15"
    healthy_threshold   = "3"
    unhealthy_threshold = "3"
    matcher             = "200-299"
  }

  tags = {
    Name = var.ecs_cluster_name
  }
}

resource "aws_alb_listener" "jenkins_https" {
  load_balancer_arn = aws_alb.jenkins.id
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = module.dns.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.jenkins.0.arn
  }
  depends_on = [
    aws_alb.jenkins
  ]
}

resource "aws_alb_listener" "jenkins_http" {
  load_balancer_arn = aws_alb.jenkins.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  depends_on = [
    aws_alb.jenkins
  ]
}
