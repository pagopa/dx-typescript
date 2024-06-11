module "apim_product_example_api" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v8.21.0"

  product_id            = format("%s-api-example-api", local.prefix)
  api_management_name   = module.apim_dx.name
  resource_group_name   = module.apim_dx.resource_group_name
  display_name          = "DX EXAMPLE API"
  description           = "Public API for all the example DX product"
  subscription_required = false # Public API
  approval_required     = false
  published             = true

  policy_xml = file("./api-product/dx-example-api/_base_policy.xml")
}

module "api_func_api" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v8.21.0"

  name                = format("%s-api-func-api", local.prefix)
  api_management_name = module.apim_dx.name
  resource_group_name = module.apim_dx.resource_group_name
  revision            = "1"
  display_name        = "DX FUNCTION EXAMPLE API"
  description         = "Public API for an example function app"

  path        = ""
  protocols   = ["http", "https"]
  product_ids = [module.apim_product_example_api.product_id]

  service_url = null

  subscription_required = false # Public API

  content_format = "openapi"
  content_value = templatefile("../../../../apps/azure-functions-api/api/external.yaml",
    {
      host = "dx-d-apim-api.azure-api.net"
    }
  )

  xml_content = file("../../../../apps/azure-functions-api/api/policy/default.xml")
}