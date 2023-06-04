resource "aws_ecr_repository" "main" {
  count                = length(var.repository_name)
  name                 = var.repository_name[count.index]
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}



resource "aws_ecr_lifecycle_policy" "ecr-lifecycle" {
  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire images older than 30 days"
        selection = {
          tagStatus   = "any"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 30
        }
        action = {
          type = "expire"
        }
      }
    ]
  })

  repository = aws_ecr_repository.main[count.index]

}