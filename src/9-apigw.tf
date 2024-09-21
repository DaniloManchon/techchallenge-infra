# # API Gateway
# resource "aws_api_gateway_rest_api" "techchallenge" {
#   name          = "techchallenge"
# }

# # API Gateway Deployment
# resource "aws_api_gateway_deployment" "techchallenge" {
#   rest_api_id = aws_api_gateway_rest_api.techchallenge.id

#   triggers = {}

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# # API Gateway Stage
# resource "aws_api_gateway_stage" "techchallenge" {
#   deployment_id = aws_api_gateway_deployment.techchallenge.id
#   rest_api_id   = aws_api_gateway_rest_api.techchallenge.id
#   stage_name    = "main"
# }

# resource "aws_api_gateway_rest_api" "example" {
#   body = jsonencode({
#     openapi = "3.0.1"
#     info = {
#       title   = "example"
#       version = "1.0"
#     }
#     paths = {
#       "/path1" = {
#         get = {
#           x-amazon-apigateway-integration = {
#             httpMethod           = "ANY"
#             payloadFormatVersion = "1.0"
#             type                 = "HTTP_PROXY"
#             uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
#           }
#         }
#       }
#     }
#   })

#   name              = "example"
#   put_rest_api_mode = "merge"

#   endpoint_configuration {
#     types            = ["PRIVATE"]
#     vpc_endpoint_ids = [aws_vpc_endpoint.example[0].id, aws_vpc_endpoint.example[1].id, aws_vpc_endpoint.example[2].id]
#   }
# }
