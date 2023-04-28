# Azure – Terraform Project
Deploy resources in Azure using Terraform

*1. Create a Resource Group*
We use sandbox, so I commoned this code block out, there is no need to create one

![image](https://user-images.githubusercontent.com/90932638/235210349-3ae264af-763e-4de5-a857-f7c64b7a675f.png)

*2. Create a Virtual Network*


![image](https://user-images.githubusercontent.com/90932638/235210680-91c742c5-7987-4692-80a1-73c346306ea5.png)

*3. Create 3 Subnets ( frontend , backend and middle subnet )*


![image](https://user-images.githubusercontent.com/90932638/235210776-222e53a1-e648-448e-8cea-faf3f2d5effe.png)


*Create a public IP address*


![image](https://user-images.githubusercontent.com/90932638/235210932-b7443646-4e86-4b8c-bf03-4061f50e337e.png)


*4. Create a Load Balancer. Create and connect new Public IP to the Load Balancer*
*5. Create a Storage Account & a container to store backend.tf*
*6. Create a VM in main.tf*
*7. Create two network interface card in virtual-machines.tf*
*8. Create an availability set*
*8. Create a container to store the Virtual Machine Datas and Managed Disks*
*9. Create a managed disk and manage attaching a Disk to a Virtual Machine*
