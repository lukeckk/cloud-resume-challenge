resource "aws_lambda_function" "myfunc" {
  filename = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256
  function_name = "myfunc"
  role = aws_iam_role.iam_for_lambda.arn
  handler = "func.handler"
  runtime = "python3.8"  
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
EOF
}

resource "aws_iam_policy" "iam_policy_for_resume_project" {
  name = "aws_iam_policy_for_terraform_resume_project_policy"
  path = "/"
  description = "AWS IAM Policy for managing the resume project role"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          "Resource" : "arn:aws:logs:*:*:*",
          "Effect" : "Allow"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "dynamodb:UpdateItem",
            "dynamodb:GetItem"
          ],
          "Resource" : "arn:aws:dynamodb:*:*:table/cloudportfolio-test" 

        }
      ]
    }
  )
}

// Attach iam_for_lambda to iam_policy_for_resume_challange
resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.iam_policy_for_resume_project.arn
}

// Terraform data source 
data "archive_file" "zip" {
  type = "zip"
  source_dir = "${path.module}/lambda/"
  output_path = "${path.module}/packedlambda.zip"
}

// Creates lambda dunction url
resource "aws_lambda_function_url" "url1" {
  function_name = aws_lambda_function.myfunc.function_name
  authorization_type = "NONE"
}