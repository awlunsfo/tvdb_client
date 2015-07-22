namespace :version do

  desc "Bumps up the version number by the patch level"
  task :patch do
    bump_version( "patch" )
  end

  desc "Bumps up the version number by a minor release level"
  task :minor do
    bump_version( "minor" )
  end

  desc "Bumps up the version number by a major release level"
  task :major do
    bump_version( "major" )
  end

  desc "TVDB's current version"
  task :current do
    puts TVDB::VERSION
  end

  desc "Bypass incremental bumping and set the version to whatever you specify in the format: #.#.#"
  task :set, [:version] do |t, args|
    raise "Version must match the following format: #.#.#" unless args[:version].match( /^[0-9].[0-9].[0-9]$/ )
    write_version_file( args[:version] )
  end

  def bump_version( version_level )
    current_version = Semantic::Version.new( TVDB::VERSION )

    case version_level
    when "patch"
      current_version.patch += 1
    when "minor"
      current_version.minor += 1
      current_version.patch  = 0
    when "major"
      current_version.major += 1
      current_version.minor  = 0
      current_version.patch  = 0

    end

    write_version_file( current_version )
  end

  def write_version_file( version )
    yes_or_no = ask( "You are about to change TVDB to version: #{version}. Continue? [y/n]" )

    continue?( yes_or_no )
    create_new_version_file( version )
    add_entry_to_changelog( version )
  end

  def continue?( yes_or_no )
    case yes_or_no
    when "y"
      puts 'Continuing...'
    when "n"
      abort( 'Looks like you changed your mind. Exiting!' )
    else
      puts "Please respond with either 'y' or 'n'."
    end
  end

  def create_new_version_file( version )
    @new_version = version
    template     = File.expand_path( "#{Settings.paths.templates}/versioning/version.rb.erb", __FILE__ )

    erb               = ERB.new( File.read( template ) )
    file_output       = erb.result(binding)
    file_output_path  = File.expand_path( '../../lib/tvdb/version.rb', __FILE__ )

    File.open( file_output_path, 'w' ) { |f| f.write( file_output ) }

    message = [
      "\nTVDB has been updated to version: #{version}!",
      "A new entry has appeared in the CHANGELOG!",
      " ",
      "Please edit the new CHANGELOG entry and add it along with version.rb to the repo."
    ].join( "\n" )

    puts message
  end

  def add_entry_to_changelog( version )
    @new_version  = version
    chlg_temp     = "#{Settings.paths.templates}/versioning/changelog_entry_template.md.erb"
    template      = File.expand_path( chlg_temp, __FILE__ )

    erb           = ERB.new( File.read( template ) )
    file_output   = erb.result(binding)
    changelog     = File.expand_path( '../../CHANGELOG.md', __FILE__ )

    new_changelog = File.read( changelog ).lines.insert(2, file_output)

    File.open( changelog, 'w' ) { |f| f.write( new_changelog.join('') ) }
  end


end
