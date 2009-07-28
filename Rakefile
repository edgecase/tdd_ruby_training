#!/usr/bin/env ruby
# -*- ruby -*-

require 'rake/clean'

SRC_DIR      = 'src'
PROB_DIR     = 'koans'
SOLUTION_DIR = 'solution'
DIST_DIR     = 'dist'

SRC_FILES = FileList["#{SRC_DIR}/*"]
KOAN_FILES = SRC_FILES.pathmap("#{PROB_DIR}/%f")
SOLUTION_FILES = SRC_FILES.pathmap("#{SOLUTION_DIR}/%f")

TAR_FILE = "#{DIST_DIR}/rubykoans.tgz"
ZIP_FILE = "#{DIST_DIR}/rubykoans.zip"

CLOBBER.include(DIST_DIR)

module Koans
  def Koans.remove_solution(line)
    line = line.gsub(/\b____\([^\)]+\)/, "____")
    line = line.gsub(/\b___\([^\)]+\)/, "___")
    line = line.gsub(/\b__\([^\)]+\)/, "__")
    line = line.gsub(%r(/\#\{__\}/), "/__/")
    line
  end

  def Koans.make_koan_file(infile, outfile)
    if infile =~ /edgecase/
      cp infile, outfile
    else
      open(infile) do |ins|
        open(outfile, "w") do |outs|
          state = :copy
          ins.each do |line|
            state = :skip if line =~ /^ *#--/
            case state
            when :copy
              outs.puts remove_solution(line)
            else
              # do nothing
            end
            state = :copy if line =~ /^ *#\+\+/
          end
        end
      end
    end
  end
end

task :dbg do
  puts "KOAN: #{SRC_PROB_FILES}"
end

directory DIST_DIR
directory PROB_DIR
directory SOLUTION_DIR

file ZIP_FILE => KOAN_FILES + [DIST_DIR] do
  sh "zip #{ZIP_FILE} #{PROB_DIR}/*"
end

file TAR_FILE => KOAN_FILES + [DIST_DIR] do
  sh "tar zcvf #{TAR_FILE} #{PROB_DIR}"
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

task :koan => KOAN_FILES 
task :clobber_koans do
  rm_r PROB_DIR
end

SRC_FILES.each do |koan_src|
  file koan_src.pathmap("#{PROB_DIR}/%f") => [PROB_DIR, koan_src] do |t|
    Koans.make_koan_file koan_src, t.name
  end
end
