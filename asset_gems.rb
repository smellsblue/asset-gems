require "fileutils"
require "yaml"

class String
  def capitalize
    sub /^./, &:upcase
  end
end

class AssetGem
  def initialize(&block)
    dependency "railties", ">= 3.0", "< 6.0"
    files "lib/**/*"
    files "app/**/*"
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

  def directory_path(value = nil)
    if value.nil?
      @directory_path || repo_path
    else
      path = caller(0, 1).first.split(":", 2).first
      @directory_path = File.join File.expand_path("..", path), value
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

  def asset_require(value = nil)
    @asset_require ||= []

    if value.nil?
      @asset_require
    else
      @asset_require << value
    end
  end

  def files(value = nil)
    @files ||= []

    if value.nil?
      @files
    else
      @files << value
    end
  end

  def dependency(gem = nil, *versions)
    @dependencies ||= []
    options = {}

    if gem.nil?
      @dependencies
    else
      options = versions.pop if versions.last.kind_of? Hash
      asset_require gem if options[:asset_require]
      @dependencies << ([gem] + versions)
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
    destination = File.join gem_path, destination
    @assets[file] = destination

    if destination =~ /(?:\.js|\.css|\.png|\.jpg|\.jpeg|\.gif)$/
      dir = File.dirname destination
      file_source = File.basename file
      file_destination = File.basename destination
      @assets[file] = dir
      mv File.join(dir, file_source) => destination
    end
  end

  def mv(hash = nil)
    @moves ||= {}
    return @moves if hash.nil?

    hash.each do |key, value|
      @moves[key] = value
    end
  end

  def asset(hash = nil)
    @assets ||= {}
    return @assets if hash.nil?

    hash.each do |key, value|
      add_asset! File.join(directory_path, key), value
    end
  end

  def asset_blob(hash)
    hash.each do |key, value|
      Dir[File.join(directory_path, key)].each do |file|
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

  def modules(value = nil)
    if value.nil?
      @modules ||= name.split("-").map do |m|
        m.capitalize
      end
    else
      @modules = value.split "::"
    end
  end

  def version(value)
    @version = value
  end

  def current_version
    return @version if @version
    raise "Cannot determine the version when there is no repo!" if repo_path.nil?
    @version = system_exec("cd '#{repo_path}' && git describe --exact-match --tags HEAD").strip

    if @version =~ /^v?(\d+\.\d+\.\d+)$/
      @version = Regexp.last_match[1]
      return @version
    end

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

  def move_assets!
    mv.each do |source, destination|
      FileUtils.mv source, destination
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
    contents << "require #{"#{name}/version".inspect}\n"

    asset_require.each do |requirement|
      contents << "require #{requirement.inspect}\n"
    end

    contents << "\n"
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
    emails = [author_email, "mike@virata-stone.com"].compact.inspect

    gemspec_path = File.join gem_path, "#{name}.gemspec"
    File.write gemspec_path, %{# This is a generated file.
require "rubygems/package_task"
require File.expand_path("../lib/#{name}/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name          = #{name.inspect}
  gem.version       = #{modules.join "::"}::Version.to_s
  gem.authors       = [#{author.inspect}, "Mike Virata-Stone"]
  gem.email         = #{emails}
  gem.description   = #{description.inspect}
  gem.summary       = #{summary.inspect}
  gem.license       = #{license.inspect}
  gem.homepage      = #{homepage.inspect}
  gem.files         = FileList[#{files.map(&:inspect).join ", "}]
  gem.require_paths = ["lib"]
  #{dependency.map { |x| "gem.add_dependency #{x.map(&:inspect).join(", ")}" }.join("\n  ")}
end
}
  end

  def update_css!
    Dir[File.join(gem_path, "app/assets/stylesheets/*.css"), File.join(gem_path, "app/assets/stylesheets/*.scss")].each do |css|
      contents = File.read css
      changed = false

      replace_css.each do |key, value|
        changed = !contents.gsub!(key, value).nil?
      end

      # Files that are already scss shouldn't need to be erbs.
      if changed
        if css =~ /\.css$/
          path = "#{css}.erb"
          FileUtils.move css, path
        else
          path = css
        end

        File.write path, contents
      end
    end
  end

  def build!
    system_exec "cd '#{gem_path}' && gem build #{name}.gemspec"
  end

  def install!
    system_exec "cd '#{gem_path}' && gem install --no-ri --no-rdoc #{name}-#{current_version}.gem"
  end

  def push!
    if AssetGem::Pushed.include? name, current_version
      puts "#{name}-#{current_version}.gem has already been pushed."
    else
      system_exec "cd '#{gem_path}' && gem push #{name}-#{current_version}.gem"
      AssetGem::Pushed.push!(name, current_version)
    end
  end

  def clean!
    system_exec "git clean -d -x -f '#{gem_path}'"
  end

  class Pushed
    class << self
      def yaml_file
        File.expand_path "../pushed.yml", __FILE__
      end

      def all
        @all ||= YAML.load(File.read(yaml_file))
      end

      def for_gem(name)
        all[name] ||= []
      end

      def include?(name, version)
        for_gem(name).include? version
      end

      def push!(name, version)
        for_gem(name) << version
        save!
      end

      def save!
        File.write yaml_file, all.to_yaml
      end
    end
  end
end

def asset_gems
  @asset_gems ||= []
end

def selected_asset_gems
  only = ENV["only"]

  if only
    asset_gems.select { |x| x.name == only }
  else
    asset_gems
  end
end

def asset_gem(&block)
  asset_gems() << AssetGem.new(&block)
end

def system_exec(cmd)
  puts "Running: #{cmd}"
  %x[#{cmd}]
end
