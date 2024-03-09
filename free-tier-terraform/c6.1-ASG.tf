# Launch Configuration
resource "aws_launch_configuration" "my_aws_lc" {
  
  depends_on = [ aws_nat_gateway.my_nat_gateway ]
  
  name               = "my-launch-config"
  image_id           = data.aws_ami.ubuntu.id  
  instance_type      = var.instance_type  

  security_groups    = [aws_security_group.vpc-ssh.id, aws_security_group.loadbalancer_sg.id] 
  key_name           = var.instance_keypair 
  user_data          = <<-EOF
  #!/bin/bash
  sudo apt update -y
  sudo apt install php php-mysqlnd php-json wget -y 
  sudo wget https://wordpress.org/latest.tar.gz
  tar -xzvf latest.tar.gz
  mkdir /var/www/html/myapp
  sudo mv wordpress/* /var/www/html/myapp
  sudo chown -R www-data:www-data /var/www/html/myapp
  sudo cp /var/www/html/myapp/wp-config-sample.php /var/www/html/myapp/wp-config.php
  sudo sed -i "s/database_name_here/mydb/" /var/www/html/myapp/wp-config.php
  sudo sed -i "s/username_here/${aws_db_instance.maindb.username}/" /var/www/html/myapp/wp-config.php
  sudo sed -i "s/password_here/${aws_db_instance.maindb.password}/" /var/www/html/myapp/wp-config.php
  sudo sed -i "s/localhost/${aws_db_instance.maindb.endpoint}/" /var/www/html/myapp/wp-config.php
  sudo systemctl start apache2
  
  EOF

  lifecycle {
    create_before_destroy = true
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "aws_ag" {
  name                 = "my-asg"
  launch_configuration = aws_launch_configuration.my_aws_lc.name
  min_size             = 1   # Minimum number of instances in the ASG
  max_size             = 2   # Maximum number of instances in the ASG
  desired_capacity     = 1   # Desired number of instances in the ASG

  vpc_zone_identifier = [aws_subnet.private_subnet_az1.id, aws_subnet.private_subnet_az2.id]
  #vpc_zone_identifier = [aws_subnet.public_subnet_az1.id, aws_subnet.public_subnet_az2.id]

  tag {
    key                 = "Name"
    value               = "wordpress-Private-Server"
    propagate_at_launch = true
  }


  
}

#CloudWatch alarms for CPU utilization
resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "CPU_Utilization_High"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 40
  # scale the group out and in based on utilization
  alarm_actions       = [aws_autoscaling_policy.scale_out_policy.arn, aws_autoscaling_policy.scale_in_policy.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.aws_ag.name
  }
}

#CloudWatch alarms for memory utilization
resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
  alarm_name          = "Memory_Utilization_High"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "System/Linux"
  period              = 300
  statistic           = "Average"
  threshold           = 60
  # scale the group out and in based on utilization
  alarm_actions       = [aws_autoscaling_policy.scale_out_policy.arn, aws_autoscaling_policy.scale_in_policy.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.aws_ag.name
  }
}

resource "aws_autoscaling_policy" "scale_out_policy" {
  name                   = "scale-out-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.aws_ag.name
}

resource "aws_autoscaling_policy" "scale_in_policy" {
  name                   = "scale-in-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.aws_ag.name
}


/*

# Scaling policies for CPU  (spin up ec2 instance if CPU Utilization > 40%)
resource "aws_autoscaling_policy" "dynmaic_scaling" {
  name                   = "scale-up-cpu-policy"
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.aws_ag.name

  metric_aggregation_type = "Average"
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 40
  }
}


# Scaling policies for Memory (spin up ec2 instance if Memory Utilization > 60%)
resource "aws_autoscaling_policy" "scale_up_memory" {
  
  
  name                   = "scale-up-memory-policy"
  adjustment_type        = "ChangeInCapacity"

  autoscaling_group_name = aws_autoscaling_group.aws_ag.name

  metric_aggregation_type = "Average"
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageNetworkIn"
    }
    target_value = 60
  }
}
*/