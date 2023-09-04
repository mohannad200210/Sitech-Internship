## Yesterday i focused on the AWS and what i learned are :
- S3 Overview(Create buckets and objects)
- S3 Security
- S3 Bucket Policy
- S3 Static website hosting
- S3 Versioning
- S3 Replication

## and this is my POC :
- Create S3 bucket
![image](https://github.com/mohannad200210/Sitech-Internship/assets/95110750/cb80f4d3-5082-4a14-b6d5-879c323d1699)
- Add object to the S3 bucket 
![image](https://github.com/mohannad200210/Sitech-Internship/assets/95110750/7cbbdc07-c8d7-4aa4-adb5-3dba1d48ed7a)

- disable (Block all public access) to make the bucket public accessable :
![image](https://github.com/mohannad200210/Sitech-Internship/assets/95110750/67fa5ffb-5cfc-4ef4-92bc-f91bc59d5169)

- Create S3 bucket policy using Policy generator to make it public accessable :
![image](https://github.com/mohannad200210/Sitech-Internship/assets/95110750/d22ce134-e029-45bd-946a-449f359b3a44)

and the policy will be 
```
{
  "Id": "Policy1693786662079",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1693786659143",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::demo-bucket-sitech/*",
      "Principal": "*"
    }
  ]
}
```

- now the bucket is public accessable and you can access it from the public url :
https://demo-bucket-sitech.s3.eu-north-1.amazonaws.com/image.png
- Enable Static website hosting in S3 bucket and after that you have to add index.html as object on the bucket :
![image](https://github.com/mohannad200210/Sitech-Internship/assets/95110750/f04e6494-4c9d-4e01-ae70-e147bffa47a6)
- After upload index.html as object now you can access the Static website from here :
http://demo-bucket-sitech.s3-website.eu-north-1.amazonaws.com/

- Enable Vesioning so we Protect against unintended deletes (ability to restore a version) and Easy roll back to previous version  
![image](https://github.com/mohannad200210/Sitech-Internship/assets/95110750/01a67004-cc99-4ecb-b118-7d9d9707376f)

- Create Replication Rule between 2 buckets in the same AWS account :
![image](https://github.com/mohannad200210/Sitech-Internship/assets/95110750/c4590513-a948-474f-86ea-532df793d46f)







