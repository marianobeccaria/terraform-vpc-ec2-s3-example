
#Get Ubuntu 22.04 image ID using SSM Parameter endpoint in us-east-1
data "aws_ssm_parameter" "ubuntu2204" {
  provider = aws.region-master
  name     = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

#Create key-pair for logging into EC2 in us-east-1
# Keys should be crated running ssh-keygen -t rsa and placed under a directory called "./keys"
resource "aws_key_pair" "master-key" {
  provider   = aws.region-master
  key_name   = "my-useastkey-00002"
  public_key = file("./keys/id_rsa.pub")
}

resource "aws_instance" "private_instance_01" {
  ami                         = data.aws_ssm_parameter.ubuntu2204.value
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.master-key.key_name
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.sg-public-to-private.id]
  subnet_id                   = aws_subnet.subnet_2.id
  iam_instance_profile        = aws_iam_instance_profile.IamEc2InstaceProfile.name
  root_block_device {
    volume_size = var.ebs_vol_size      # in GB <<----- I can increase this!
    # volume_type = "gp3"
    # encrypted   = true
    # kms_key_id  = data.aws_kms_key.customer_master_key.arn
  }


  user_data = <<EOF
  sudo apt update -y
  sudo apt install python3-pip -y
  sudo apt install awscli -y
  aws s3 cp s3://tf-example-mariano-11645232twerer/write_to_100.py /tmp/write_to_100.py
  /tmp/write_to_100.py

  EOF

  tags = {
    Name = "tf-ubuntu2204"
  }

  depends_on = [aws_s3_bucket.mydemobucket]
}

resource "aws_ebs_volume" "data-vol01" {
 availability_zone = element(data.aws_availability_zones.azs.names, 1)
 size = var.ebs_vol_size
 tags = {
        Name = "data-volume-01"
 }
}

resource "aws_volume_attachment" "attached-to-instance01" {
 device_name = "/dev/sdh"
 volume_id = "${aws_ebs_volume.data-vol01.id}"
 instance_id = "${aws_instance.private_instance_01.id}"
}