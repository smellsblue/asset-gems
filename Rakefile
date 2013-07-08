require File.expand_path("../asset_gems", __FILE__)

asset_gem do
  name "blueimp-gallery-rails"
  author "Sebastian Tschan"
  author_email "mail@blueimp.net"
  description "This gem wraps the blueimp Gallery JavaScript library as a Rails asset gem.  The library is by Sebastian Tschan, and the gem is packaged by Mike Virata-Stone."
  summary "Rails asset gem for blueimp Gallery."
  license "MIT"
  homepage "https://github.com/blueimp/Gallery"
  repo_path "Gallery"
  asset "js/blueimp-gallery.js" => "vendor/assets/javascripts"
  asset "css/blueimp-gallery.css" => "vendor/assets/stylesheets"
  asset_blob "img/*" => "vendor/assets/images"
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
  asset "js/load-image.js" => "vendor/assets/javascripts"
  asset "js/load-image-ios.js" => "vendor/assets/javascripts"
  asset "js/load-image-meta.js" => "vendor/assets/javascripts"
  asset "js/load-image-exif.js" => "vendor/assets/javascripts"
  asset "js/load-image-exif-map.js" => "vendor/assets/javascripts"
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
  asset "js/tmpl.js" => "vendor/assets/javascripts"
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
  asset "js/canvas-to-blob.js" => "vendor/assets/javascripts"
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
  asset "js/cors/jquery.postmessage-transport.js" => "vendor/assets/javascripts/cors"
  asset "js/cors/jquery.xdr-transport.js" => "vendor/assets/javascripts/cors"
  asset "js/jquery.fileupload-angular.js" => "vendor/assets/javascripts"
  asset "js/jquery.fileupload-audio.js" => "vendor/assets/javascripts"
  asset "js/jquery.fileupload-image.js" => "vendor/assets/javascripts"
  asset "js/jquery.fileupload-process.js" => "vendor/assets/javascripts"
  asset "js/jquery.fileupload-ui.js" => "vendor/assets/javascripts"
  asset "js/jquery.fileupload-validate.js" => "vendor/assets/javascripts"
  asset "js/jquery.fileupload-video.js" => "vendor/assets/javascripts"
  asset "js/jquery.fileupload.js" => "vendor/assets/javascripts"
  asset "js/jquery.iframe-transport.js" => "vendor/assets/javascripts"
  asset "css/jquery.fileupload-ui-noscript.css" => "vendor/assets/stylesheets"
  asset "css/jquery.fileupload-ui.css" => "vendor/assets/stylesheets"
  asset_blob "img/*" => "vendor/assets/images"
  replace_css /url\(\.\.\/img\/\s*([^)]*)\s*\)/, 'url(<%= image_path("\1") %>)'
  dependency "blueimp-load-image-rails", :asset_require => true
  dependency "blueimp-templates-rails", :asset_require => true
  dependency "blueimp-canvas-to-blob-rails", :asset_require => true
  dependency "jquery-rails"
  dependency "jquery-ui-rails", :asset_require => true
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
