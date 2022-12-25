require "open3"
require "pathname"
require "tmpdir"

def copy_executable_in_directory(executable_path, dir)
  executable_path_inside_dir = Pathname.new(File.join(dir, executable_path))
  FileUtils.mkdir_p(executable_path_inside_dir.dirname)
  FileUtils.copy(executable_path, executable_path_inside_dir)
end

command = ARGV[2]
args = ARGV[3..]

chroot_dir = Dir.mktmpdir
copy_executable_in_directory(command, chroot_dir) if File.exist?(command)
Dir.chroot(chroot_dir)

stdout, stderr, status = Open3.capture3(command, *args)
STDOUT.write(stdout)
STDERR.write(stderr)

exit status.exitstatus
