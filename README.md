# Secure an S3 bucket

In this exercise, we will learn how to use AWS security policies and configurations to secure sensitive data in S3 
and provide access to only the intended people and applications - a 
[Least Privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege) access control policy.

Challenge: Secure sensitive data in an S3 bucket that should only be accessible by a single application.

This exercise uses several AWS security tools to understand and improve the access to an AWS S3 bucket.

Resources and tools used in this exercise:
 
* An AWS Account
* (optional) The AWS command-line interface (cli)

Solution: If you would like to follow along with a solution to this challenge, watch the
['Secure an S3 bucket' Phoenix DevOps meetup](https://youtu.be/WIZPSuSoQq4).  

The solution steps used in that meetup are provided in this repository.
There are many other approaches to completing this exercise using other tools.  Our approach using the AWS cli was
intended to very 'simple' and direct using a widely adopted tool. If you complete this exercise using
CloudFormation, Terraform, or another tool, we'd love to see your solution and review a pull request.
  
## Milestone 1 - Investigate defaults
 
Objective: Investigate effects of default configurations

Estimated completion time: 1-2 hours

* Create two S3 buckets (sensitive-data and logs) and upload two files (objects) to both buckets
* Create two IAM roles (application, firewall) and one IAM user (delivery)
* Demonstrate full, internal access by all IAM principals in the IAM access simulator
* Demonstrate that external principals do not have access to objects in the bucket

Solution Steps: [Milestone 1](steps-milestone-1.md)

Takeaways:

* The account's IAM principals in an account have access 
* External principals do not have access to the bucket or its contents

## Milestone 2: Lock down external access

Objective 2: Lock down external access

Estimated completion time: 1-2 hours

* Introduce Bucket Access Control Lists
* Configure a private default Bucket ACL policy for both buckets
* Configure the 'block public access' feature for both buckets
* Demonstrate that updating the previously-uploaded object ACLs to public fails, so do new uploads with public ACLs

Takeaways:
* Bucket ACLs provide a way to control access to individual objects in a bucket
* Buckets can be configured to prevent public access to any object in the bucket

## Milestone 3: Limit internal access using IAM policy 

Objective: Limit internal access to the sensitive-data bucket using IAM policy

Estimated completion time: 1-3 hours

* Show which IAM security policy statements grant access to the IAM user and role 
* Explain why the lack of resource conditions in AWS managed policies is a problem
* Create a custom IAM policy for the firewall role that only allows that role to access to the logs bucket
* Demonstrate the firewall role no longer has access to sensitive-data, but still has access to the logs bucket using the IAM access simulator

Solution Steps: [Milestone 3](steps-milestone-3.md)

Takeaways:
* Access to particular resources can be limited using IAM policies
* Using AWS managed IAM policies will grant access to all resources for a service such as S3

## Milestone 4: Limit internal access using S3 bucket policy

Objective: Limit internal access to the sensitive-data bucket using S3 bucket policy

Estimated completion time: 2-4 hours

* Explain what a resource policy is, that they don't exist by default, and that the default be-havior is to allow internal access
* Create a bucket policy that allows only the application role and delivery user to read and write data to the sensitive-data bucket
* Demonstrate the application role still has access to the sensitive-data bucket using the IAM access simulator
* Demonstrate the delivery user still has access to the sensitive-data bucket using the IAM access simulator – this is (probably) unexpected!
* Reinforce the access control decision workflow and point out that unless there is an explicit deny by the bucket policy, then the IAM policy attached to delivery grants access.
* Update the bucket policy to deny every principal that is not application
* Demonstrate the delivery user no longer has access to the sensitive-data bucket using the IAM access simulator 

Solution Steps: [Milestone 4](steps-milestone-4.md)

Takeaways:
* Access to particular resources can be limited using S3 bucket policies
* Resource policies must deny all unintended access to close the access provided by overly permissive IAM policies such as the standard AWS managed IAM policies
