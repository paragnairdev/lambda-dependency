# Cloudformation Sandbox
This is a sandbox with cloudformation templates to try out Infrastructure As Code where resources created in one stack and referenced in another stack

## What does this do?

There are 2 cloudformation templates:

* `global-resources.yaml` - Creates a S3 bucket and SNS Topic which can then be used in any CI/CD pipeline using `Fn::ImportValue`
* `pipeline.yaml` - Creates a CI/CD pipeline on AWS CodePipeline which builds a lambda and publishes the lambda to AWS.

## Prerequsites

* You need to have a github account
* You need to have a OAuth Token generated on github with read permissions

## Steps

* Execute the template `global-resources.yaml`. This will create a S3 Bucket and a SNS Topic.
* The idea of creating these resources is to use the S3 bucket for all our application artifact store and a SNS Topic which will get messages when any CI/CD pipeline fails.
* Make note of the stack name you provided since you will need it for any subsequent CI/CD pipelines you create to refer back to these global resources
* This tempalte creates 2 outputs S3 Bucket: `{Your-Stack-Name}-CodeArtifactStore` and SNS Topic: `{Your-Stack-Name}-GlobalNotificationTopic`
* Execute the template `pipeline.yaml` and make sure the parameter `GlobalStackName` is the name of the stack you created earlier.
* That's it, you now have global S3 bucket which stores your artifacts for your new pipeline and if any stage in the pipeline fails, a message is posted to the global SNS topic

## NOTE

Please be aware of resources this creates on your AWS account so you can check what it costs you. At the time of writing this, a `Codepipeline` is charged at $1 a month (after the first 30 days). The costliest part in this might probably be `CodeBuild` which gives you 100 minutes on the smallest instance. This is one of the reasons I have added a Approval step before the build to make sure the code is only build when you want it to.