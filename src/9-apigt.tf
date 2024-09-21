#API Gateway
resource "aws_apigatewayv2_api" "techchallenge" {
  name          = "techchallenge"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "techchallenge_stage" {
  api_id      = aws_apigatewayv2_api.techchallenge.id
  name        = "main"
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "techchallenge_integration" {
  api_id = aws_apigatewayv2_api.techchallenge.id

  integration_uri    = "arn:aws:elasticloadbalancing:us-east-1:<acc-id>:listener/net/a852b4f6ff0be41dfa1505018b083488/e8cf16c1a71e2a37/59bf9fd068f3f993"
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_api_gateway_vpc_link.techchallenge_vpc_link.id
}
