require "fileutils"

class String
  def capitalize
    sub /^./, &:upcase
  end
end

class AssetGem
  def initialize(&block)
    instance_eval &block
  end

  def name(value = nil)
    if value.nil?
      @name
    else
      @name = value
    end
  end

  def author(value = nil)
    if value.nil?
      @author
    else
      @author = value
    end
  end

  def author_email(value = nil)
    if value.nil?
      @author_email
    else
      @author_email = value
    end
  end

  def description(value = nil)
    if value.nil?
      @description
    else
      @description = value
    end
  end

  def summary(value = nil)
    if value.nil?
      @summary
    else
      @summary = value
    end
  end

  def license(value = nil)
    if value.nil?
      @license
    else
      @license = value
    end
  end

  def homepage(value = nil)
    if value.nil?
      @homepage
    else
      @homepage = value
    end
  end

  def repo_path(value = nil)
    if value.nil?
      @repo_path
    else
      path = caller(0, 1).first.split(":", 2).first
      @repo_path = File.join File.expand_path("..", path), value
    end
  end

  def gem_path
    File.expand_path("../gems/#{name}", __FILE__).tap do |path|
      unless File.directory? path
        FileUtils.mkpath path
      end
    end
  end

  def add_asset!(file, destination)
    @assets[file] = File.join(gem_path, destination)
  end

  def asset(hash = nil)
    @assets ||= {}
    return @assets if hash.nil?

    hash.each do |key, value|
      add_asset! File.join(repo_path, key), value
    end
  end

  def asset_blob(hash)
    hash.each do |key, value|
      Dir[File.join(repo_path, key)].each do |file|
        add_asset! file, value
      end
    end
  end

  def replace_css(key = nil, value = nil)
    @replace_css ||= {}

    if key.nil? && value.nil?
      @replace_css
    else
      @replace_css[key] = value
    end
  end

  def modules
    @modules ||= name.split("-").map do |m|
      m.capitalize
    end
  end

  def current_version
    return @version if @version
    @version = system_exec("cd '#{repo_path}' && git describe --exact-match --tags HEAD").strip
    return @version if @version =~ /^\d+\.\d+\.\d+$/
    raise "Current version is unknown for #{name}"
  end

  def copy_assets!
    asset.each do |source, destination|
      unless File.directory? destination
        FileUtils.mkpath destination
      end

      FileUtils.cp source, destination
    end
  end

  def create_version!
    version = current_version
    path = File.join gem_path, "lib/#{name}"
    FileUtils.mkpath path
    contents = "# This is a generated file.\n"
    indentation = 0

    modules.each do |m|
      contents << "#{"  " * indentation}module #{m}\n"
      indentation += 1
    end

    ["class Version", "class << self", "def to_s", version.inspect].each do |line|
      contents << "#{"  " * indentation}#{line}\n"
      indentation += 1
    end

    indentation -= 1

    (modules.size + 3).times do
      indentation -= 1
      contents << "#{"  " * indentation}end\n"
    end

    File.write File.join(path, "version.rb"), contents
  end

  def create_include_file!
    path = File.join gem_path, "lib"
    FileUtils.mkpath path
    contents = "# This is a generated file.\n"
    contents << "require #{"#{name}/version".inspect}\n\n"
    indentation = 0

    modules.each do |m|
      contents << "#{"  " * indentation}module #{m}\n"
      indentation += 1
    end

    contents << "#{"  " * indentation}class Engine < ::Rails::Engine\n"
    contents << "#{"  " * indentation}end\n"

    modules.size.times do
      indentation -= 1
      contents << "#{"  " * indentation}end\n"
    end

    File.write File.join(path, "#{name}.rb"), contents
  end

  def create_gemspec!
    gemspec_path = File.join gem_path, "#{name}.gemspec"
    File.write gemspec_path, %{# This is a generated file.
require "rubygems/package_task"
require File.expand_path("../lib/#{name}/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name          = #{name.inspect}
  gem.version       = #{modules.join "::"}::Version.to_s
  gem.authors       = [#{author.inspect}, "Mike Virata-Stone"]
  gem.email         = [#{author_email.inspect}, "mike@virata-stone.com"]
  gem.description   = #{description.inspect}
  gem.summary       = #{summary.inspect}
  gem.license       = #{license.inspect}
  gem.homepage      = #{homepage.inspect}
  gem.files         = FileList["lib/**/*", "vendor/**/*"]
  gem.require_paths = ["lib"]
  gem.add_dependency "railties", ">= 3.0", "< 5.0"
end
}
  end

  def update_css!
    Dir[File.join(gem_path, "vendor/assets/stylesheets/*.css")].each do |css|
      path = "#{css}.erb"
      FileUtils.move css, path
      contents = File.read path

      replace_css.each do |key, value|
        contents.gsub! key, value
      end

      File.write path, contents
    end
  end

  def build!
    system_exec "cd '#{gem_path}' && gem build #{name}.gemspec"
  end

  def install!
    system_exec "cd '#{gem_path}' && gem install --no-ri --no-rdoc #{name}-#{current_version}.gem"
  end

  def push!
    system_exec "gem push #{name}-#{current_version}.gem"
  end
end

def asset_gems
  @asset_gems ||= []
end

def asset_gem(&block)
  asset_gems() << AssetGem.new(&block)
end

def system_exec(cmd)
  puts "Running: #{cmd}"
  %x[#{cmd}]
end
