#!/usr/bin/env ruby
# -*- ruby -*-

require 'rake/clean'

SRC_DIR='test'
SRC_FILES = FileList["#{SRC_DIR}/*.rb"]

DIST_DIR='dist'
TAR_FILE = "#{DIST_DIR}/ruby101.tgz"
ZIP_FILE = "#{DIST_DIR}/ruby101.zip"

CLOBBER.include(DIST_DIR)

directory DIST_DIR

file ZIP_FILE => SRC_FILES + [DIST_DIR] do
  sh "zip #{DIST_DIR}/ruby101.zip #{SRC_DIR}/*"
end

file TAR_FILE => SRC_FILES + [DIST_DIR] do
  sh "tar zcvf #{TAR_FILE} #{SRC_DIR}"
end

desc "Create packaged files for distribution"
task :package => [TAR_FILE, ZIP_FILE]

desc "Check that the require files match the about_* files"
task :check do
  about_files = Dir['about_*.rb'].size
  about_requires = `grep require path_to_enlightenment.rb | wc -l`.to_i
  puts "# of about files:    #{about_files}"
  puts "# of about requires: #{about_requires}"
end
