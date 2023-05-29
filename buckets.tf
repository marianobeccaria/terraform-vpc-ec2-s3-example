resource "aws_s3_bucket" "mydemobucket" {

  bucket = var.my_bucket_name

  tags = {
    Name = "terraform deployment"
  }
}

# Upload Files to S3
resource "aws_s3_object" "file1" {
  bucket      = aws_s3_bucket.mydemobucket.id
  key         = "write_to_100.py"
  source      = "./userdata/write_to_100.py"
  force_destroy = true
}
