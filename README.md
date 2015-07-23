# tvdb_client

`tvdb_client` is a rubygem to interface with The TVDB's REST API.

## Installation

This gem has not yet been published on rubygems.org. For now, you will have to  
download and build the gem from source. I will publish the gem once it is in  
a releaseable state.

```sh
$ git clone git@github.com:awlunsfo/tvdb_client.git
$ cd tvdb_client
$ gem build tvdb_client.gemspec
```

## Usage

### Gemfile
```ruby
source "https://rubygems.org"

gem 'tvdb_client', :path => "/path/to/your/cloned/repository/tvdb_client"
```

### Example
```ruby
require 'tvdb_client'

# Placeholder values
credentials = {
  :username => "some_user",     # username is optional
  :userpass => "some_password", # userpass is optional
  :apikey   => "my_unique_api_key",
  :host_url => "https://tvdb.api.com"
}

tvdb = TVDB::Client.new( credentials )

pokemon = tvdb.series( '76703' )

puts pokemon.data

# =>
# {"data"=>
#   {"id"=>76703,
#    "seriesName"=>"Pokémon",
#    "aliases"=>
#     ["Pokemon",
#      "Diamond and Pearl",
#      "Pocket Monsters",
#      "Pokémon: Black & White"],
#    "banner"=>"graphical/76703-g6.jpg",
#    "seriesId"=>"467",
#    "status"=>"Continuing",
#    "firstAired"=>"1997-04-01",
#    "network"=>"TV Tokyo",
#    "networkId"=>"",
#    "runtime"=>"30",
#    "genre"=>["Animation", "Children"],
#    "actors"=>[],
#    "overview"=>
#     " A young boy named Ash Ketchum embarks on a journey to become a \"Pokemon   
#     Master\" with his first Pokemon, Pikachu. Joining him on his travels are   
#     Brock, a girl-obsessed Rock Pokemon Trainer, and Misty, a tomboyish Water   
#     Pokemon Trainer who may have a crush on him. Ash and Co. end up traveling   
#     through various regions, including Kanto, the Orange Islands, and Johto,   
#     and then enter the Pokemon League competitions there. Along the way, they   
#     run into many confrontations with Jessie, James, and Meowth, a trio of   
#     Pokemon thieves who are apart of an evil organization called \"Team Rocket\".   
#     But everytime Team Rocket try to do their evil deeds, they fail thanks to   
#     Ash and his Pokemon.",  
#    "lastUpdated"=>1437155768,
#    "airsDayOfWeek"=>"",
#    "airsTime"=>"",
#    "rating"=>"TV-Y",
#    "imdbId"=>"tt0176385",
#    "zap2itId"=>"",
#    "added"=>"",
#    "addedBy"=>nil
#  }
# }
```
