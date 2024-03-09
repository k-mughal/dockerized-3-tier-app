# Create an Application Load Balancer
resource "aws_lb" "alb" {
  name               = "my-alb"
  load_balancer_type = "application"
  subnets            = [
    aws_subnet.public_subnet_az1.id,
    aws_subnet.public_subnet_az2.id,
  ]
  security_groups    = [aws_security_group.loadbalancer_sg.id]

  enable_deletion_protection = false
}

# Create Listeners for the ALB
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mytg1.arn
    
  }
}

# Create a Target Group
resource "aws_lb_target_group" "mytg1" {
  name     = "mytg1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my3tier_vpc.id
  

  health_check {
    enabled             = true
    interval            = 30
    path                = "/myapp/index.php"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 6
    protocol            = "HTTP"
    matcher             = "200-399"
  }
}


resource "aws_autoscaling_attachment" "asg-attachment" {
  autoscaling_group_name = aws_autoscaling_group.aws_ag.id
  lb_target_group_arn    = aws_lb_target_group.mytg1.arn
  
}
