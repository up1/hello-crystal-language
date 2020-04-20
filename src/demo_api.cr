require "http/server"
require "json"

module DemoApi
  VERSION = "0.1.0"

  class Person
    include JSON::Serializable
    property firstname : String
    property lastname : String
    def initialize(firstname, lastname)
      @firstname = firstname
      @lastname = lastname
    end
  end

  server = HTTP::Server.new do |context|
    persons = Array(Person).new
    persons << Person.new("First name 01", "Last name 01")
    persons << Person.new("First name 02", "Last name 02")

    context.response.content_type = "application/json"
    context.response.print persons.to_json()
  end

end

address = server.bind_tcp 8080
puts "Listening on http://#{address}"
server.listen
