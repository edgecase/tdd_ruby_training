#!/usr/bin/env ruby
# -*- ruby -*-

require 'rake/clean'

SRC_DIR='solutions'
KOAN_DIR='koans'

SRC_FILES = FileList["#{SRC_DIR}/*"]
KOAN_SRC_FILES = FileList["#{SRC_DIR}/about_*.rb"]

KOAN_FILES = KOAN_SRC_FILES.pathmap("#{KOAN_DIR}/%f")
OTHER_FILES = SRC_FILES.pathmap("#{KOAN_DIR}/%f")
OTHER_FILES.exclude("#{KOAN_DIR}/about_*.rb")
WORK_FILES = KOAN_FILES + OTHER_FILES

DIST_DIR='dist'
TAR_FILE = "#{DIST_DIR}/rubykoans.tgz"
ZIP_FILE = "#{DIST_DIR}/rubykoans.zip"

CLOBBER.include(DIST_DIR)

task :dbg do
  puts "KOAN: #{KOAN_FILES}"
  puts "OTHER: #{OTHER_FILES}"
end

rule "#{KOAN_DIR}/about_*.rb" => lambda { |fn| fn.pathmap("#{SRC_DIR}/%f") } do |r|
  make r.target
end

directory DIST_DIR

file ZIP_FILE => WORK_FILES + [DIST_DIR] do
  sh "zip #{ZIP_FILE} #{KOAN_DIR}/*"
end

file TAR_FILE => WORK_FILES + [DIST_DIR] do
  sh "tar zcvf #{TAR_FILE} #{KOAN_DIR}"
end

desc "Create packaged files for distribution"
task :package => [TAR_FILE, ZIP_FILE]

desc "Upload the package files to the web server"
task :upload => [TAR_FILE, ZIP_FILE] do
  sh "scp #{TAR_FILE} linode:sites/onestepback.org/download"
  sh "scp #{ZIP_FILE} linode:sites/onestepback.org/download"
end

desc "Check that the require files match the about_* files"
task :check do
  about_files = Dir['about_*.rb'].size
  about_requires = `grep require path_to_enlightenment.rb | wc -l`.to_i
  puts "# of about files:    #{about_files}"
  puts "# of about requires: #{about_requires}"
end
