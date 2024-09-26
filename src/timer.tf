resource "time_sleep" "wait_nlb_creation" {
  create_duration = "5m"
  depends_on      = [helm_release.ingress]
}