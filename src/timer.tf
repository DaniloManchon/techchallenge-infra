resource "time_sleep" "wait_nlb_creation" {
  create_duration = "10m"
  depends_on      = [helm_release.ingress]
}