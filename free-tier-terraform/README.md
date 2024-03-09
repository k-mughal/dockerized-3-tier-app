### This Project focuses on automating a wordpress based application on AWS using set of practices to achieve fault tolerance and high availability. Although there are several micro level components that will be a part of the provisioned architecture, but the major ones to be mentioned are as 
    
<p align="center">
  <img src="https://github.com/k-mughal/Ansible/assets/18217530/6edf2bde-0592-4244-874a-c060420c0eea">
</p>  

- **Virtual Private Cloud (VPC)** - Provisioned to isolate the resources
  - **Public Subnets** - Allocated for resources requiring public access
  - **Private Subnets** - Reserved for resources needing restricted access
  - **Route Tables** - Defined to direct network traffic within the VPC
    **Route Table Associations** - Linked with subnets to define routing
  - **Security Groups** - Implemented to control inbound and outbound traffic
- **Internet Gateway** - Facilitates communication between instances and the internet
- **Network Address Translation (NAT) Gateway** - Allows private instances to access the internet
- **Relational Database Service (RDS MySQL)** - Deployed in a Multi-AZ configuration for fault tolerance.
- **Autoscaling Group (for EC2 instances)** - Configured for high scalability
  - **Launch Configurations** - Defined with necessary attributes for EC2 instances
- **Application Load Balancer (ALB)** - Created to distribute traffic among instances.
  - **ALB Listener** - Listens for incoming traffic on specified ports
    **ALB Target Group** - Directs traffic to instances registered with the load balancer
- **Route 53**
- **AWS Certificate Manager** - Utilized for securing connections with SSL/TLS certificates.

#### Additional Steps:
- **Connecting WordPress to RDS:** Implemented a Bash script to pass RDS credentials dynamically to the WordPress configuration file (wp-config.php).
- **Creating Launch Configuration and Autoscaling Group:** Defined launch configurations and attached them to the autoscaling group to ensure instances possess desired attributes.
- **Integration of Autoscaling Group with Application Load Balancer:** Ensured autoscaled instances are behind the load balancer to handle traffic distribution.
- **Integration of Route 53 and ACM with Load Balancer:** Facilitated user access through user-friendly URLs and secure connections.
- **Autoscaling Policies:** Configured policies based on CPU and Memory Utilization Metrics to dynamically scale instances up or down as per resource demand.