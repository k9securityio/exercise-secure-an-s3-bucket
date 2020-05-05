# Steps to complete Milestone 1

Setup the resources

`terraform plan`

`terraform apply -auto-approve`

Export bucket names
`export SENSITIVE_BUCKET=sensitive-data-ABC`
`export LOGS_BUCKET=logs-DEF`

Upload files to both buckets:
`./upload-files.sh`

Check Effective External Access
Open https://sensitive-data-26d66ba1.s3.amazonaws.com/file-1.txt

Check Effective Internal Access

Open the AWS [policy simulator](https://policysim.aws.amazon.com/home/index.jsp?#)

Test the firewall role's ability to read and write to the sensitive data bucket.  Simulate
use of the `s3:GetObject` and `s3:PutObject` API actions with a resource-specific action and resource policy included.  

Bucket ARNs:
 
* `arn:aws:s3:::sensitive-data-ABC`, e.g. `arn:aws:s3:::sensitive-data-26d66ba1`
* `arn:aws:s3:::logs-DEF`

