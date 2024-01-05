locals {
  public_ip = trim(data.http.my_ip.body)
}