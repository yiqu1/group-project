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


![image](https://user-images.githubusercontent.com/90932638/235211015-44a5c9a0-8709-48bc-8ea0-521a402c59e2.png)


Create a Load Balancer backend pool


![image](https://user-images.githubusercontent.com/90932638/235211146-99514bb1-c5a1-492e-a421-9126481ea19a.png)


creates a health probe for the load balancer
![image](https://user-images.githubusercontent.com/90932638/235211189-de2b7239-a2d6-4121-9c89-72ae7168cf27.png)


#Create a Load Balancer rule


![image](https://user-images.githubusercontent.com/90932638/235211293-06cbea5f-61a0-4690-a7f9-54edee4f9580.png)


*5. Create a Storage Account & a container to store backend.tf*


![image](https://user-images.githubusercontent.com/90932638/235211360-f6fd4dcf-2f55-415e-9a23-003265149121.png)

*6. Create a VM in main.tf*


*7. Create two network interface card in virtual-machines.tf*
*8. Create an availability set*
*8. Create a container to store the Virtual Machine Datas and Managed Disks*
*9. Create a managed disk and manage attaching a Disk to a Virtual Machine*
