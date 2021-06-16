output "target_group_arn" {
    value = aws_lb_target_group.lb_target_group.arn
        
}

output  "dns_name" {
    value = aws_lb.ctm-lb.dns_name
}
