job "http-sample2" {
  type = "service"

  group "sample" {
    count = 1

    network {
      port "http" { to = 80 }
    }

    service {
      name = "sample"
      port = "http"

      tags = [
        "traefik.enable=true",
        "traefik.http.middlewares.sample-stripprefix.stripprefix.prefixes=/sample",
        "traefik.http.routers.http.rule=PathPrefix(`/sample`)",
        "traefik.http.routers.http.middlewares=sample-stripprefix",
      ]

      check {
        type     = "http"
        path     = "/"
        port     = "http"
        interval = "2s"
        timeout  = "2s"
      }
    }

    task "sample-task" {
      driver = "docker"
      
      config {
        isolation = "process"
        image     = "mcr.microsoft.com/dotnet/samples:aspnetapp-nanoserver-ltsc2022"
        ports     = ["http"]
      }
    }
  }
}
