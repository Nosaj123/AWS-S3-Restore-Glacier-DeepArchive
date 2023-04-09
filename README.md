# AWS-S3-Restore-Glacier-DeepArchive
Bash script design to list and restore AWS S3 Objects from Glacier or Deep Archive to S3 Standard Tier temporarily in bulk

This script assumes you have the aws cli configured and the correct IAM role & priviliges.
In line 2, change the bucket name to the bucket name that has the objects you wish to restore.
The output with be bucket_name.txt
