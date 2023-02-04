# A Script to create a amazon EC2 instance using an ami


# Line 7 selects AWS as the provider 
# Line 8  Selects the region the ec2 instance will be created in for example in this script it will be created in us-west-2
# Line 8 and 9  allows programtic access via using your access key and secret key
provider "aws" {
  region     = "us-west-2"
  access_key = "PUT-YOUR-ACCESS-KEY-HERE"
  secret_key = "PUT-YOUR-SECRET-KEY-HERE"
}


#  Line 17 specifies that we will create a Aws with the alias of myec2 ( the alias can be customised to whatever you want)
# line 18  specifies what ami you are using for this script we are using amazon linux
# line 19  is the size of the instance we want to provision ( it can be changed depending on your needs)
resource "aws_instance" "myec2"{
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"
  }
