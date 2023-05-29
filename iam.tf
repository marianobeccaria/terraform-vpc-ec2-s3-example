# Role that will be attached to the EC2 instance

resource "aws_iam_role" "Ec2S3AccessRole" {
  name = "Ec2S3AccessRoleTF000003"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name = "Assume role for ec2 s3 example"
  }
}



# Policy S3 Read Access that's attached to Role

resource "aws_iam_role_policy" "S3ReadPolicy" {
  name = "S3ReadPolicyTF000003"
  role = aws_iam_role.Ec2S3AccessRole.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "s3:GetBucket*",
          "s3:GetObject*",
          "s3:List*" 
        ],
        "Effect": "Allow",
        "Resource": [
          "${aws_s3_bucket.mydemobucket.arn}",
          "${aws_s3_bucket.mydemobucket.arn}/*",
        ]
      }
    ]
  })
}

# EC2 instance profile taht will be attached to our ec2 instance

resource "aws_iam_instance_profile" "IamEc2InstaceProfile" {
  name = "IamEc2InstaceProfile"
  role = aws_iam_role.Ec2S3AccessRole.name
}
