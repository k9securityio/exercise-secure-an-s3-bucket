# Steps to complete Milestone 4

Test the `delivery` user's ability to read and write to the sensitive data bucket.  Simulate
use of the `s3:GetObject` and `s3:PutObject` API actions with a resource-specific action and resource policy included.

Sigh.

Let's control access at the resource so that we can protect sensitive data without
rewriting every IAM policy.  Since that's not even possible in the general case.

Replace the `REPLACEME_SENSITIVE_BUCKET` tokens in the policy file with the suffix for your own bucket.
`sed -i -e 's/REPLACEME_SENSITIVE_BUCKET/sensitive-data-26d66ba1/g' aws-customer.S3Bucket.*.json`

Replace the `REPLACEME_ACCT_ID` tokens in the `` file with your AWS account id.  You can use a command like:
`sed -i -e 's/REPLACEME_ACCT_ID/720226181253/g' aws-customer.S3Bucket.*.json`
 

Now, configure the sensitive data bucket with the policy:
`aws s3api put-bucket-policy --bucket sensitive-data-26d66ba1 --policy file://aws-customer.S3Bucket.restricted-FullAccess.incomplete.json`


Bucket ARNs:
 
* `arn:aws:s3:::sensitive-data-ABC`, e.g. `arn:aws:s3:::sensitive-data-26d66ba1`
* `arn:aws:s3:::logs-DEF`
