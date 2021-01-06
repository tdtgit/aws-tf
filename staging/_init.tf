# Configure the AWS Provider
provider "aws" {
  region                  = var.aws_region
  shared_credentials_file = "../.secret/staging_keys"
}

resource "aws_key_pair" "SSH" {
  key_name   = "SSH.new"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC7MOIM9et/hjzzi9sX6xayyD3UH4ImzaTKka4x1WDdjtJXI0jOXPqjVF8pPIhhSL3Dos+a0fKauK9QShY4+aa7I3Wl0VyFbIr5GaXO1AAGmSIcbNXJx+I2aLG1PvXcSjHhMpykBz/wEFonh1xTFxH47xBYUg2LfRdLFnVU8c1jJrF6D8NjGygLrJXRFbacDWrn+CV7z/TWcbTb45T400/x4r6ocGxTc3tkgpWrDuuJtuUy8Hd6k4R66B8jTUpuQYlFkRfGPkm/oPlAE/7WNllRmBkI4V2dgQfO2Og01EfZiDeSrpvNVFA02UF/+JMYnpYdxUmHZTc0CkdnUlls3CyQE/RHpYb8c9S4Pv+rJz5N0viQ/40+dByd9NkhmF+BTDqPM8CijfGYQxXjUyiY0/kcDcoVYwz/6KY0T2AcUWIESSG6c+MUq49A7Hn77XBzpjJ4NM1DAvdHjmWLAi6rTiCRW0UZAQ1GJ9RgGsVbk4lEwXWmMcbNdccydFdAEZgq2p4yehWhV7oPJ1DbhWKTFZJACqwa8TUSzq5Iw4p31cecvOLbPNAjhHAadtjNWEJo8Tjs3VUnI5Wg1TUuio3MzOyj1PRhiYaTy8aAQTdmV1OIYCB4jCcO/tVcsGe7dWh8aSMJBAFrvxTjxaKTV91kgHEcbl+Wf+SbpupIrY4mjOQU+w== atuan@TDT-Macbook.local"
}