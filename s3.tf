resource "aws_s3_bucket" "bucket" {
    bucket = "jenkins-bucket-with-terraform"
    force_destroy = true
  
}
resource "aws_s3_bucket_notification" "bucket_notification" {
    bucket = aws_s3_bucket.bucket.id
    eventbridge = true

}

