require 'settingslogic'

# Public: Reads in the config/settings.yml files and makes its entries
# available as Settings.whatever. You must require lib/settings.rb
# in classes where you wish to use this functionality. See manifest_scraper.rb
# for an example
#
class Settings < Settingslogic
  source File.expand_path( "../../../conf/settings.example.yml", __FILE__ )
end
