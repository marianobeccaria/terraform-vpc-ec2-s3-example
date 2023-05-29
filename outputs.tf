output "s3_bucket" {
  value = aws_s3_bucket.mydemobucket.arn
}

output "MyEc2Instance" {
  value = aws_instance.private_instance_01.arn
}

