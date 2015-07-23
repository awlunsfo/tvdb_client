# tvdb_client

`tvdb_client` is a rubygem to interface with The TVDB's REST API.

## Installation

This gem has not yet been published on rubygems.org. For now, you will have to  
download and build the gem from source. I will publish the gem once it is in  
a releaseable state.

```ruby
require 'tvdb_client'

# Placeholder values
credentials = {
  :username => "some_user",
  :userpass => "some_password",
  :apikey   => "my_unique_api_key",
  :host_url => "https://tvdb.api.com"
}

tvdb = TVDB::Client.new( credentials )

pokemon = tvdb.series( '76703' )

puts pokemon.data
```
