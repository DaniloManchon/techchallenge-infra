# API Gateway
resource "aws_apigatewayv2_api" "techchallenge" {
  name          = "techchallenge"
  protocol_type = "HTTP"
}

# API Gateway Stage
resource "aws_apigatewayv2_stage" "techchallenge_stage" {
  api_id      = aws_apigatewayv2_api.techchallenge.id
  name        = "main"
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "techchallenge_integration" {
  api_id = aws_apigatewayv2_api.techchallenge.id

  integration_uri    = aws_lb.techchallenge_lb.arn
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.techchallenge_vpc_link.id
}
