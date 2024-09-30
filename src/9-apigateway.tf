# Permissão para a função Lambda ser invocada pelo API Gateway
resource "aws_lambda_permission" "allow_api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "postech-serverless"
  principal     = "apigateway.amazonaws.com"

  # O ARN do API Gateway (especifique o ID da API e o stage)
  source_arn = "${aws_api_gateway_rest_api.token_api.execution_arn}/*/*"
}

# Criação da API Gateway REST API
resource "aws_api_gateway_rest_api" "token_api" {
  name        = "Pos Tech - API Gateway"
  description = "API gateway para geração de token JWT a partir do CPF"
}

# Recurso principal /token-generator
resource "aws_api_gateway_resource" "token_resource" {
  rest_api_id = aws_api_gateway_rest_api.token_api.id
  parent_id   = aws_api_gateway_rest_api.token_api.root_resource_id
  path_part   = "token-generator"
}

# Recurso opcional /token-generator/{cpf}
resource "aws_api_gateway_resource" "token_resource_with_cpf" {
  rest_api_id  = aws_api_gateway_rest_api.token_api.id
  parent_id    = aws_api_gateway_resource.token_resource.id
  path_part    = "{cpf}"
}

# Método GET para /token-generator
resource "aws_api_gateway_method" "token_method" {
  rest_api_id   = aws_api_gateway_rest_api.token_api.id
  resource_id   = aws_api_gateway_resource.token_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

# Método GET para /token-generator/{cpf}, condicionalmente
resource "aws_api_gateway_method" "token_method_with_cpf" {
  rest_api_id   = aws_api_gateway_rest_api.token_api.id
  resource_id   = aws_api_gateway_resource.token_resource_with_cpf.id
  http_method   = "GET"
  authorization = "NONE"
}

# Integração com Lambda para /token-generator
resource "aws_api_gateway_integration" "token_integration" {
  rest_api_id             = aws_api_gateway_rest_api.token_api.id
  resource_id             = aws_api_gateway_resource.token_resource.id
  http_method             = aws_api_gateway_method.token_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:975748149223:function:postech-serverless/invocations"

  # Se necessário, adicione outros parâmetros como passthrough_behavior, content_type, etc.
}

# Integração com Lambda para /token-generator/{cpf}, condicionalmente
resource "aws_api_gateway_integration" "token_integration_with_cpf" {
  rest_api_id             = aws_api_gateway_rest_api.token_api.id
  resource_id             = aws_api_gateway_resource.token_resource_with_cpf.id
  http_method             = aws_api_gateway_method.token_method_with_cpf.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:975748149223:function:postech-serverless/invocations"
}

# Criação do Deployment da API
resource "aws_api_gateway_deployment" "token_deployment" {
  depends_on = [
    aws_api_gateway_integration.token_integration,
    aws_api_gateway_integration.token_integration_with_cpf
  ]

  rest_api_id = aws_api_gateway_rest_api.token_api.id
  stage_name  = "dev"

  lifecycle {
    create_before_destroy = true
  }
}
