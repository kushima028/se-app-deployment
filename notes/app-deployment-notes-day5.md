# Day 5 – Auto Scaling Groups

## What is Scaling?

**Scaling** in cloud computing refers to adjusting the amount of computing resources available to an application based on demand. Instead of running a fixed number of servers, cloud platforms allow infrastructure to automatically increase or decrease capacity when required.

This helps maintain **performance during high demand** and **reduce costs during low demand**.

---

## Types of Scaling

There are two main types of scaling used in cloud environments.

### Vertical Scaling (Scaling Up/Down)

Vertical scaling involves increasing or decreasing the **resources of a single server**, such as CPU, RAM, or storage.

Example:
- Upgrading an instance from a **t2.micro** to a **t2.large**.

**Advantages**
- Simple to implement
- No changes required to application architecture

**Disadvantages**
- Limited by the maximum hardware available
- May require downtime to resize the instance
- Does not improve redundancy

---

### Horizontal Scaling (Scaling Out/In)

Horizontal scaling involves **adding or removing servers** to handle changes in workload.

Instead of upgrading one server, multiple instances run the same application.

Example:
- Increasing from **1 EC2 instance to 3 EC2 instances** during high traffic.

**Advantages**
- Highly scalable
- Provides redundancy and improved reliability
- No single point of failure

**Disadvantages**
- More complex architecture
- Requires load balancing
- Applications must support distributed environments

---

## Launch Templates

A **Launch Template (LT)** defines how new EC2 instances should be created.

It contains configuration information such as:

- AMI (Amazon Machine Image)
- Instance type
- Security groups
- Key pair
- Storage configuration
- User data scripts
- Networking settings

Launch templates are used to ensure **consistent instance configuration** when new instances are automatically launched.

---

### Launch Template Creation

The basic process for creating a launch template is:

1. Navigate to the **EC2 Dashboard**
2. Select **Launch Templates**
3. Click **Create Launch Template**
4. Configure:
   - AMI
   - Instance type
   - Key pair
   - Security group
   - Storage
   - Resource tags
   - User data (optional)
5. Save the template

**User data** is a script or set of commands that runs automatically when an EC2 instance launches. It is commonly used to **automate the initial configuration of a server**, such as installing software, updating packages, or deploying an application.

User data scripts are typically written in **bash** for Linux instances and are executed during the **instance’s first boot**.

For example, a user data script might:

- Update system packages
- Install required software (e.g., Node.js, Nginx)
- Clone a GitHub repository
- Start an application server

This allows instances launched from a **Launch Template** or **Auto Scaling Group** to configure themselves automatically without manual setup.
---

![](pictures/lt-1.png)

![](pictures/lt-2.png)

![](pictures/lt-3.png)

---

## Auto Scaling Groups (ASG)

An **Auto Scaling Group (ASG)** automatically manages a group of EC2 instances.

It ensures that:

- A **minimum number of instances** are always running
- New instances are launched when demand increases
- Instances are terminated when demand decreases

ASGs typically work together with **Launch Templates**, which define how the instances should be created.

---

### Key ASG Configuration Settings

| Setting | Description |
|-------|-------|
| Minimum capacity | Minimum number of instances that must always run |
| Desired capacity | Target number of instances |
| Maximum capacity | Maximum number of instances allowed |
| Scaling policies | Rules that determine when to scale |

---

### Example Scaling Scenario

Example configuration:

- Minimum: **1 instance**
- Desired: **2 instances**
- Maximum: **4 instances**

If demand increases and CPU usage exceeds a defined threshold, the Auto Scaling Group will **launch additional instances** using the launch template.

If demand drops, it will **terminate extra instances** to reduce costs.

---

### Auto Scaling Group Creation Process

1. Navigate to **EC2 → Auto Scaling Groups**
2. Click **Create Auto Scaling Group**
3. Select the **Launch Template**
4. Choose the **VPC and subnets**
5. Attach a **Load Balancer**
6. Configure group size settings
7. Configure scaling policies
8. Review and create the ASG
9. Add tags (optional but useful)
---

### Step 1

Fill out name and select launch template

![](pictures/asg-1.png)

### Step 2

Stick with default vpc for now, select availability zones, and balanced best effort

![](pictures/asg-2.png)

### Step 3

Attach to a new application load balancer

![](pictures/asg-3.png)
![](pictures/asg-4.png)
![](pictures/asg-5.png)

### Step 4

Set up scaling limits and choose scaling policy
![](pictures/asg-6.png)
![](pictures/asg-7.png)

### Step 5

Add tag/tags for ease of use

![](pictures/asg-9.png)

### Step 6

Review

![](pictures/asg-10.png)
![](pictures/asg-11.png)
![](pictures/asg-12.png)
![](pictures/asg-14.png)

---

### Deleting ASG
1. Delete Load Balancer
2. Delete Target Group
3. Delete ASG
Should terminate all related instances, but double check 













































