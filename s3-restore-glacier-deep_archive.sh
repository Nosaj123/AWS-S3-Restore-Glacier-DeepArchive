#!/bin/bash
bucket_name="bucket-name"
#Days to restore to S3 Standarid Tier
days_to_restore=9

# List all the objects in the Glacier storage class in the bucket modified before 8 days ago
aws s3api list-objects --bucket $bucket_name --query 'Contents[?StorageClass==`GLACIER` || StorageClass==`DEEP_ARCHIVE`].[Key]'  --output text > $bucket_name.txt 

# Split the list of objects into multiple text files, each containing up to 4,000 objects
split -l 4000 $bucket_name.txt "$bucket_name-"

# Restore each object in the Glacier storage class
for file in $bucket_name-*; do
    while read -r line; do
        key=$(echo "$line" | tr -d '\r\n')
        aws s3api restore-object --bucket "$bucket_name" --key "$key" --restore-request Days=$days_to_restore 2>&1 | grep -v 'RestoreAlreadyInProgress'
    done < $file
    echo "Restore is now in progress for objects in $bucket_name"
done

echo "All objects have been restored!"
echo "--- aws s3api head-object --bucket $bucket_name --key $key ---"

done
