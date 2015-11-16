# --* encoding: utf-8 *--
require 'fileutils'

def backup_filename(filename)
  filename + ".backup"
end

def backup_file(filename)
  FileUtils.cp(filename, backup_filename(filename))
end