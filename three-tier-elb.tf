resource "aws_alb" "external-alb" {
  name               = "External-alb"
  internal           = false
  load_balancer_type = "applicaiton"
  security_groups    = [aws_security_group.web-sg.id]
  subnets            = [aws_subnet.web-subnet-1.id, aws_subnet-2.id]
}

resource "aws_alb_target_group" "external-alb" {
  name     = "alb-tg"
  port     = 80
  protocol = "http"
  vpc_id   = aws_vpc.myvpc.id

}

resource "aws_alb_target_group_attachment" "external-alb1" {
  target_group_arn = aws_alb_target_group.external-alb.arn
  target_id        = aws_instance.werbserver1.id
  port             = 80

  depends_on = [
    aws_instance.werbserver1,
  ]
}

resource "aws_alb_target_group_attachment" "external-alb2" {
  target_group_arn = aws_alb_target_group.external-alb.arn
  target_id        = aws_instance.werbserver2.id
  port             = 80

  depends_on = [
    aws_instance.werbserver2,
  ]
}

resource "aws_alb_listener" "external-alb" {
  load_balancer_arn = aws_alb.external-alb.arn
  port              = "80"
  protocol          = "http"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.external-alb.arn
  }
}
