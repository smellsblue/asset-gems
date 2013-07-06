require File.expand_path("../asset_gems", __FILE__)

asset_gem do
  name "blueimp-gallery-rails"
  author "Sebastian Tschan"
  author_email "mail@blueimp.net"
  description "This gem wraps the blueimp Gallery JavaScript library as a Rails asset gem.  The library is by Sebastian Tschan, and the gem is packaged by Mike Virata-Stone."
  summary "Rails asset gem for blueimp Gallery."
  license "MIT"
  homepage "http://blueimp.github.io/Gallery/"
  repo_path "Gallery"
  asset "js/blueimp-gallery.js" => "vendor/assets/javascripts"
  asset "css/blueimp-gallery.css" => "vendor/assets/stylesheets"
  asset_blob "img/*" => "vendor/assets/images"
  replace_css /url\(\.\.\/img\/\s*([^)]*)\s*\)/, 'url(<%= image_path("\1") %>)'
end

task :default => :build

task :copy_assets do
  asset_gems.each &:copy_assets!
end

task :create_version do
  asset_gems.each &:create_version!
end

task :create_include_file do
  asset_gems.each &:create_include_file!
end

task :create_gemspec do
  asset_gems.each &:create_gemspec!
end

task :update_css => :copy_assets do
  asset_gems.each &:update_css!
end

task :generate => [:copy_assets, :update_css, :create_version, :create_include_file, :create_gemspec]

task :build => :generate do
  asset_gems.each &:build!
end

task :install => :build do
  asset_gems.each &:install!
end

task :push => :build do
  asset_gems.each &:push!
end
