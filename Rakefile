# Modified Ryan Bates' version
#
# Copyright (c) 2009 Ryan Bates
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'rake'
require 'erb'
require 'fileutils'

namespace :ssh do
  namespace :config do

    desc "Generate .ssh/config file from template and includes"
    task :generate do
      Dir.glob("ssh/include/*").each do |path|
        file = path.split("/").last
        content = File.read path
        eval "$#{file} = '#{content}'"
      end
      File.open 'ssh/config', 'w' do |f|
        f.print ERB.new(File.read("ssh/config.erb")).result(binding)
        f.close
      end
      File.chmod 0600, "ssh/config"

    end
  end
end

namespace :iterm do

  pref = "~/Library/Preferences/com.googlecode.iterm2"
  namespace :keys do

    key  = "GlobalKeyMap"
    keys = "iterm2/#{key}"

    directory "iterm2"

    desc "Save global key mapping to file"
    task :export => "iterm2" do
      sh "defaults read #{pref} #{key} > #{keys}"
    end

    desc "Load global key mapping from file to iTerm2 defaults"
    task :import do
      data = File.read keys rescue "File does not exist: #{keys}"
      # data = File.read keys rescue "File does not exist: #{keys}"

      sh "defaults write #{pref} #{key} \'#{data}\'"
    end
  end
end

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  Dir['*'].each do |file|
    next if skip?(file)

    if File.exist?(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"))
      if replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub('.erb', '')}? [ynarq] (yes/no/all/rename/quit) "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'r'
          rename_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file.sub('.erb', '')}"
        end
      end
    else
      link_file(file)
    end
  end

  # Handle things separately .ssh and .vim
  # FileUtils::mkdir_p "~/.vim"
  # link_file("vim/snippets") # handle separately, as vim/ already should exist
  link_file("ssh/config")
end

def skip?(file)
  %w[.DS_Store Rakefile README.rdoc dotfiles.tmproj backup ssh iterm2].include?(file)
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file.sub('.erb', '')}"}
  link_file(file)
end

def rename_file(file)
  system %Q{mv "$HOME/.#{file.sub('.erb', '')}" "$HOME/.#{file.sub('.erb', '')}.backup.#{Time.now.strftime "%Y-%m-%d"}" }
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub('.erb', '')}"
    File.open(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end
