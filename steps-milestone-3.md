# Steps to complete Milestone 3

Detach the `S3FullAccess` policy from the firewall role:
`/usr/local/bin/aws iam detach-role-policy --role-name firewall --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess`

Update the log bucket arn in the `aws-customer.IAM.log-writer.json` file with the name of the logs bucket

Create an IAM policy named `log-writer` with `aws-customer.IAM.log-writer.json` and attach it to the `firewall` role.

`aws iam create-policy --policy-name log-writer --policy-document file://aws-customer.IAM.log-writer.json`  

Attach `log-writer` policy to the `firewall` role:

`aws iam attach-role-policy --role-name firewall --policy-arn arn:aws:iam::720226181253:policy/log-writer`

Test the firewall role's ability to read and write to the sensitive data bucket.  Simulate
use of the `s3:GetObject` and `s3:PutObject` API actions with a resource-specific action and resource policy included.

Bucket ARNs:
 
* `arn:aws:s3:::sensitive-data-ABC`, e.g. `arn:aws:s3:::sensitive-data-26d66ba1`
* `arn:aws:s3:::logs-DEF`
