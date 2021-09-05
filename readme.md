# Terraforme-Aws_Ec2-DCA
![terraform](https://img.shields.io/badge/Terraform-v1.0.5-green)
![aws](https://img.shields.io/badge/aws--cli-v1.20.31-green)


## Getting Started

These instructions will cover using, setup, and testing the project.

### Prerequisites

In order to run this project it is necessary to install terraform and AWS-Cli:

Terraform:

- [Windows](https://www.terraform.io/downloads.html)
- [OS X](https://www.terraform.io/downloads.html)
- [Linux](https://www.terraform.io/downloads.html)

AWS:

- [Windows](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html)
- [OS X](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-mac.html)
- [Linux](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)

## Terraform setup

---

**1\. Clone this repository (linux or macOs)**

```sh
$ git clone https://github.com/Bramba7/Terraforme-Aws_Ec2-DCA.git
$ cd Terraforme-Aws_Ec2-DCA
```

**2\. Credentials for AWS**

```bash
$ export AWS_SECRET_ACCESS_KEY='your secret key'
$ export AWS_ACCESS_KEY_ID='your key id'
$ export region='your region'
$ export output= 'json or yaml'
```

... or the `~/.aws/credentials` and `~/.aws/config` file.

```
$ cat ~/.aws/credentials
[default]
aws_access_key_id = your key id
aws_secret_access_key = your secret key

```

```
$ cat ~/.aws/config
[default]
region= your region
output= json or yaml

```

**3\. Create a bucket on AWS**

Replace the word "mybucket" for the name of your bucket, and the us-west-1 region with your region.
<br><font color="red"><b> Attention the name of your bucket must be unique !!!!</b> </font>

```sh
$ aws s3 mb s3://mybucket --region YOUR REGION
```

**4\. Edit the code with your information**

After completing the previous steps open the file `backend.tf`, and fill this section with your data from the AWS S3 bucket as in the code below:<dd>


```
Terraform {
  backend "s3" {
    shared_credentials_file = "~/.aws/credentials"
    bucket                  = "bucket's name"
    key                     = "Folder's name /terraform.tfstate"
    region                  = "us-east-1"
    acl                     = "private"
    encrypt                 = true
  }
}
```

## Terraform Usage

---

**1\. Initialize terraform**

Execute the below command to initialize.

```sh
$ terraform init
```

**2\. Review terraform plan**

Execute the command below, and ensure you agree with the plan.

```bash
$ terraform plan 
```

**3\. Execute terraform project**

For more agility you can use the command `--auto-approve` to skip the execution confirmation.

```sh
$ terraform apply 
```

**4\. Delete terraform project**

Once you are finished your testing, don't forget to destroy the resources to avoid unnecessary AWS charges.

```sh
$ terraform destroy 
```