resource "aws_iam_user" "dave_arnold" {
  name          = "dave.arnold"
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "dave_arnold" {
  user    = aws_iam_user.dave_arnold.name
  pgp_key = "keybase:roknsound"
}

output "password" {
  value = aws_iam_user_login_profile.dave_arnold.encrypted_password
}