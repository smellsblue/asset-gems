require File.expand_path("../asset_gems", __FILE__)

asset_gem do
  name "jquery-cookies-rails"
  version "2.2.0"
  modules "JQueryCookies::Rails"
  author "James Auldridge"
  description "This gem wraps the jquery.cookies JavaScript library as a Rails asset gem.  The library is by James Auldridge, and the gem is packaged by Mike Virata-Stone."
  summary "Rails asset gem for jquery.cookies."
  license "MIT"
  homepage "https://code.google.com/p/cookies/"
  directory_path "jquery.cookies"
  asset "jquery.cookies.2.2.0.js" => "app/assets/javascripts/jquery.cookies.js"
end

asset_gem do
  name "xregexp-rails"
  modules "XRegExp::Rails"
  author "Steven Levithan"
  author_email "steves_list@hotmail.com"
  description "This gem wraps the xregexp JavaScript library as a Rails asset gem.  The library is by Steven Levithan, and the gem is packaged by Mike Virata-Stone."
  summary "Rails asset gem for xregexp."
  license "MIT"
  homepage "http://xregexp.com/"
  repo_path "xregexp"
  asset "src/xregexp.js" => "app/assets/javascripts"
  asset "src/addons/unicode/unicode-blocks.js" => "app/assets/javascripts/xregexp"
  asset "src/addons/unicode/unicode-base.js" => "app/assets/javascripts/xregexp"
  asset "src/addons/unicode/unicode-properties.js" => "app/assets/javascripts/xregexp"
  asset "src/addons/unicode/unicode-scripts.js" => "app/assets/javascripts/xregexp"
  asset "src/addons/unicode/unicode-categories.js" => "app/assets/javascripts/xregexp"
  asset "src/addons/build.js" => "app/assets/javascripts/xregexp"
  asset "src/addons/matchrecursive.js" => "app/assets/javascripts/xregexp"
  asset "src/addons/prototypes.js" => "app/assets/javascripts/xregexp"
end

asset_gem do
  name "blueimp-gallery-rails"
  author "Sebastian Tschan"
  author_email "mail@blueimp.net"
  description "This gem wraps the blueimp Gallery JavaScript library as a Rails asset gem.  The library is by Sebastian Tschan, and the gem is packaged by Mike Virata-Stone."
  summary "Rails asset gem for blueimp Gallery."
  license "MIT"
  homepage "https://github.com/blueimp/Gallery"
  repo_path "Gallery"
  asset "js/blueimp-gallery.js" => "app/assets/javascripts"
  asset "js/blueimp-gallery-fullscreen.js" => "app/assets/javascripts"
  asset "js/blueimp-gallery-indicator.js" => "app/assets/javascripts"
  asset "js/blueimp-gallery-video.js" => "app/assets/javascripts"
  asset "js/blueimp-helper.js" => "app/assets/javascripts"
  asset "js/jquery.blueimp-gallery.js" => "app/assets/javascripts"
  asset "css/blueimp-gallery.css" => "app/assets/stylesheets"
  asset "css/blueimp-gallery-indicator.css" => "app/assets/stylesheets"
  asset "css/blueimp-gallery-video.css" => "app/assets/stylesheets"
  asset_blob "img/*" => "app/assets/images"
  replace_css /url\(\.\.\/img\/\s*([^)]*)\s*\)/, 'url(<%= image_path("\1") %>)'
end

asset_gem do
  name "blueimp-load-image-rails"
  modules "Blueimp::LoadImage::Rails"
  author "Sebastian Tschan"
  author_email "mail@blueimp.net"
  description "This gem wraps the blueimp JavaScript Load Image library as a Rails asset gem.  The library is by Sebastian Tschan, and the gem is packaged by Mike Virata-Stone."
  summary "Rails asset gem for blueimp JavaScript Load Image."
  license "MIT"
  homepage "https://github.com/blueimp/JavaScript-Load-Image"
  repo_path "JavaScript-Load-Image"
  asset "js/load-image.js" => "app/assets/javascripts"
  asset "js/load-image-ios.js" => "app/assets/javascripts"
  asset "js/load-image-orientation.js" => "app/assets/javascripts"
  asset "js/load-image-meta.js" => "app/assets/javascripts"
  asset "js/load-image-exif.js" => "app/assets/javascripts"
  asset "js/load-image-exif-map.js" => "app/assets/javascripts"
end

asset_gem do
  name "blueimp-templates-rails"
  modules "Blueimp::Templates::Rails"
  author "Sebastian Tschan"
  author_email "mail@blueimp.net"
  description "This gem wraps the blueimp JavaScript Templates library as a Rails asset gem.  The library is by Sebastian Tschan, and the gem is packaged by Mike Virata-Stone."
  summary "Rails asset gem for blueimp JavaScript Templates."
  license "MIT"
  homepage "https://github.com/blueimp/JavaScript-Templates"
  repo_path "JavaScript-Templates"
  asset "js/tmpl.js" => "app/assets/javascripts"
end

asset_gem do
  name "blueimp-canvas-to-blob-rails"
  modules "Blueimp::CanvasToBlob::Rails"
  author "Sebastian Tschan"
  author_email "mail@blueimp.net"
  description "This gem wraps the blueimp JavaScript Canvas to Blob library as a Rails asset gem.  The library is by Sebastian Tschan, and the gem is packaged by Mike Virata-Stone."
  summary "Rails asset gem for blueimp JavaScript Canvas to Blob."
  license "MIT"
  homepage "https://github.com/blueimp/JavaScript-Canvas-to-Blob"
  repo_path "JavaScript-Canvas-to-Blob"
  asset "js/canvas-to-blob.js" => "app/assets/javascripts"
end

asset_gem do
  name "blueimp-file-upload-rails"
  modules "Blueimp::FileUpload::Rails"
  author "Sebastian Tschan"
  author_email "mail@blueimp.net"
  description "This gem wraps the blueimp jQuery File Upload plugin as a Rails asset gem.  The plugin is by Sebastian Tschan, and the gem is packaged by Mike Virata-Stone."
  summary "Rails asset gem for blueimp jQuery File Upload."
  license "MIT"
  homepage "https://github.com/blueimp/jQuery-File-Upload"
  repo_path "jQuery-File-Upload"
  asset "js/cors/jquery.postmessage-transport.js" => "app/assets/javascripts/cors"
  asset "js/cors/jquery.xdr-transport.js" => "app/assets/javascripts/cors"
  asset "js/jquery.fileupload-angular.js" => "app/assets/javascripts"
  asset "js/jquery.fileupload-audio.js" => "app/assets/javascripts"
  asset "js/jquery.fileupload-image.js" => "app/assets/javascripts"
  asset "js/jquery.fileupload-process.js" => "app/assets/javascripts"
  asset "js/jquery.fileupload-ui.js" => "app/assets/javascripts"
  asset "js/jquery.fileupload-validate.js" => "app/assets/javascripts"
  asset "js/jquery.fileupload-video.js" => "app/assets/javascripts"
  asset "js/jquery.fileupload.js" => "app/assets/javascripts"
  asset "js/jquery.iframe-transport.js" => "app/assets/javascripts"
  asset "css/jquery.fileupload-ui-noscript.css" => "app/assets/stylesheets"
  asset "css/jquery.fileupload-ui.css" => "app/assets/stylesheets"
  asset_blob "img/*" => "app/assets/images"
  replace_css /url\(\.\.\/img\/\s*([^)]*)\s*\)/, 'url(<%= image_path("\1") %>)'
  files "app/**/*"
  dependency "blueimp-load-image-rails", :asset_require => true
  dependency "blueimp-templates-rails", :asset_require => true
  dependency "blueimp-canvas-to-blob-rails", :asset_require => true
  dependency "jquery-rails"
  dependency "jquery-ui-rails", :asset_require => true
end

task :default => :build

task :clean do
  selected_asset_gems.each &:clean!
end

task :copy_assets do
  selected_asset_gems.each &:copy_assets!
end

task :create_version do
  selected_asset_gems.each &:create_version!
end

task :create_include_file do
  selected_asset_gems.each &:create_include_file!
end

task :create_gemspec do
  selected_asset_gems.each &:create_gemspec!
end

task :update_css => :copy_assets do
  selected_asset_gems.each &:update_css!
end

task :move_assets => :update_css do
  selected_asset_gems.each &:move_assets!
end

task :generate => [:copy_assets, :update_css, :move_assets, :create_version, :create_include_file, :create_gemspec]

task :build => :generate do
  selected_asset_gems.each &:build!
end

task :install => :build do
  selected_asset_gems.each &:install!
end

task :push => :build do
  selected_asset_gems.each &:push!
end
