# Steps to complete Milestone 4

Test the `delivery` user's ability to read and write to the sensitive data bucket.  Simulate
use of the `s3:GetObject` and `s3:PutObject` API actions with a resource-specific action and resource policy included.

Sigh.

Let's control access at the resource so that we can protect sensitive data without
rewriting every IAM policy.  Since that's not even possible in the general case.

Replace the `REPLACEME_SENSITIVE_BUCKET` tokens in the policy files with the suffix for your own bucket.
`sed -i .orig 's/REPLACEME_SENSITIVE_BUCKET/sensitive-data-f8/g' aws-customer.S3Bucket.*.json`

Replace the `REPLACEME_ACCT_ID` tokens in the policy files file with your AWS account id.  You can use a command like:
`sed -i .orig 's/REPLACEME_ACCT_ID/720226181253/g' aws-customer.S3Bucket.*.json`
 
Replace the `REPLACEME_ADMIN` token in the `aws-customer.S3Bucket.restricted-FullAccess.complete.json` file with the ARN of your own IAM principal.  

You can use a command like:
`sed -i .orig 's/REPLACEME_ADMIN/arn:aws:iam::720226181253:role\/k9-test-small-admin/g' aws-customer.S3Bucket.*.json`
 
Now, configure the sensitive data bucket with the policy:
`aws s3api put-bucket-policy --bucket sensitive-data-f8 --policy file://aws-customer.S3Bucket.restricted-FullAccess.incomplete.json`

Navigate to the AWS console and take a look at the contents of your bucket:
e.g. `https://s3.console.aws.amazon.com/s3/buckets/sensitive-data-f8/?region=us-east-1`

or `aws s3api list-objects --bucket sensitive-data-f8`

That shouldn't be allowed!  We need to DENY access to the bucket for everyone but the `application` role.

`aws s3api put-bucket-policy --bucket sensitive-data-f8 --policy file://aws-customer.S3Bucket.restricted-FullAccess.complete.json`

Now when you run `list-objects`, you should get 'Access Denied': 

> An error occurred (AccessDenied) when calling the ListObjects operation: Access Denied

Reload the console, the listing should fail.

Now simulate access again for the `delivery` user again.  The get and put object actions should be denied.


Bucket ARNs:
 
* `arn:aws:s3:::sensitive-data-ABC`, e.g. `arn:aws:s3:::sensitive-data-f8`
* `arn:aws:s3:::logs-DEF`
