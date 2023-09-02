project = "test"

app "sample" {
  build {
    use "docker-ref" {
      image = "mcr.microsoft.com/dotnet/samples"
      tag   = "aspnetapp-nanoserver-ltsc2022"
    }
  }
  deploy {
    use "nomad-jobspec" {
      jobspec = templatefile("${path.app}/http-sample.hcl")
    }
  }
}
