notification :terminal_notifier

guard 'spork' do
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb') { :rspec }
end

params = {
  wait:           60,
  all_after_pass: false,
  all_on_start:   true,
  cmd: "bundle exec rspec"
}

guard 'rspec', cmd: 'bundle exec rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb})             { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')         { "spec" }
end
