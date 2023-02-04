 # Terraform Scripts
 <br>
 In this repository, you will find terraform scripts for both AWS and Azure as these are the main providers I have used in the industry over time the aim is to add more complex scripts and eventually scripts for GCP in future releases.
 <br>
 This document will include the initial setup,  Extension recommendations and future scripts I plan to make as I learn more about Terraform and IAC.
 <br>
 <hr>
 <br>
 
 # Installations and Extension Recommendations
 <br>

 ### Windows
 <br>
 [To manually download Terraform for windows please select the appropriate executable](https://developer.hashicorp.com/terraform/downloads)
 
<br>
Next, you need to open your advanced system settings and edit the path within the environment variables tab.
<br>

Once you have opened environmental variables you need to point the path to the terraform binary you just downloaded.
<br>
To verify that terraform is installed open up PowerShell and run the following command terraform -help
<br>

### Linux - CentOS/RHEL
<br>
Install yum-config-manager to manage your repositories.
<br>

 > sudo yum install -y yum-utils

 <br>

Use yum-config-manager to add the official HashiCorp Linux repository.
<br>

  > sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
<br>
Install Terraform from the new repository.
<br>

 >sudo yum -y install terraform
 <br>


<hr>
<br>





 # Use full Terraform Commands

<br>

Terraform FMT = This Formats your terraform Code (fixes inconsistencies with your terraform code to make it easier to read)
<br>
Terraform Plan = Generates an execution plan, allowing you to see a preview of the infrastructure modifications that Terraform intends to make.
<br>

Terraform Apply = Apply’ s the configuration changes to your environment
<br>

Terraform Apply -Destroy = The destroy flag terminates the previously provisioned infrastructure it is worth noting you have to use the full command of Terraform Apply -destroy ( This replaces the deprecated destroy  only command)
<br>
<hr>
<br>




