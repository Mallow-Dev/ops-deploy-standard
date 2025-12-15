ui = true

listener "tcp" {
  address     = "127.0.0.1:8200"
  tls_disable = 1 # IMPORTANT: set to 0 and provide cert_file/key_file in production
}

storage "file" {
  path = "/var/lib/vault/data"
}

api_addr = "http://127.0.0.1:8200"
cluster_addr = "https://127.0.0.1:8201"
