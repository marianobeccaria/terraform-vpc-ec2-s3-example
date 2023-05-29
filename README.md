# Create terraform deployment for VPC, EC2 instance and S3 bucket
## Description
This repo creates a terraform stack to provision:
* a VPC with two subnets: 10.4.1.0/24 (Public) and 10.4.2.0/24 (Private)
* an ec2 instance in the PRIVATE subnet, with two EBS volumes, user_data, and role with policy Read access to s3 bucket
* a S3 bucket used to upload files that later are accessible to the ec2 instance
* a python file that runs at boot time and writes to a file in /tmp/ after boot time

## How to deploy these resources?
1. Modify values in `varibles.tf` file according to your needs. You'll defenitely need to change the bucket name, for example
2. Run: 
   ```
   terraform plan
   terraform apply
    ```
    
3.Verify in AWS console that resources were created
