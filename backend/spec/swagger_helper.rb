require "rails_helper"

RSpec.configure do |config|
  config.swagger_docs = {
    "v1/swagger.yaml" => {
      openapi: "3.0.1",
      info: { title: "User Management API", version: "1.0" },
      paths: {},
      servers: [ { url: "http://localhost:3000" } ]
    }
  }
  config.swagger_dry_run = false
end