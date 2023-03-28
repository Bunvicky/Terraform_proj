provider "aws"{
    region = "us-east-1"
  
}
resource "random_pet" "pet_name" {
    prefix = "bootcamp"
    length = 3

  
}
resource "aws_s3_bucket" "backend" {
    bucket = random_pet.pet_name.id
  
}
resource "aws_kms_key" "mykey" {
    deletion_window_in_days = 15
} 
resource "aws_s3_bucket_server_side_encryption_configuration" "backend"{
bucket = aws_s3_bucket.backend.id 
rule {
    apply_server_side_encryption_by_default {
        sse_algorithm ="aws:kms"
        kms_master_key_id = aws_kms_key.mykey.arn
    }
  
}
}