require "open3"

command = ARGV[2]
args = ARGV[3..]

stdout, stderr, status = Open3.capture3(command, *args)
STDOUT.write(stdout)
STDERR.write(stderr)

exit status.exitstatus
