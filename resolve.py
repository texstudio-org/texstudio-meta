'''
Script to resolve memory addresses in a backtrace to code lines using addr2line
Note: On win use addr2line.exe from binutils-2.22-1-mingw32-bin. Newer ones seem to habe a bug.
      See: http://mingw.5.n7.nabble.com/BUG-Windows-Last-version-of-Addr2line-tool-mingw-td31395.html
'''

import os
import re
import argparse

# addr2line command (include path if necessary)
ADDR2LINE = "addr2line.exe"
# default executable (can be overridden using the -e argument)
DEFAULT_EXECUTABLE = "./debug_executables/txs2.6.2/texstudio.exe"

class BacktraceResolver(object):
	def __init__(self, executable=None):
		if executable is None:
			self.executable = DEFAULT_EXECUTABLE
		else:
			self.executable = executable
		self.remove_paths = True
		
	def resolve_address(self, addr):
		cmd = "{addr2line} -e {exe} {addr}".format(addr2line=ADDR2LINE, exe=self.executable, addr=addr)
		return os.popen(cmd).read().strip()

	def parse_backtrace(self, backtrace):
		with open(backtrace, "r") as f:
			for line in f:
				match = re.match("^\[bt\] ([01234567890ABCDEF]+) (.*)$", line)
				if match:
					addr = "0x"+match.group(1)
					srcline = self.resolve_address(addr)
					if srcline=="??:0":
						print line.rstrip()
						continue
					if self.remove_paths:
						srcline = srcline.split("/")[-1]
					print "[bt] {addr}  {srcline} {text}".format(addr=match.group(1), srcline=srcline, text=match.group(2))
				else:
					print line.rstrip()
	
if __name__ == "__main__":
	parser = argparse.ArgumentParser(description="Script to resolve memory addresses in a backtrace to code lines using addr2line")
	parser.add_argument("backtrace", help="backtrace file to analyze")
	parser.add_argument("-e", "--executable", help="a version of the executable inclucing debug information")
	args = parser.parse_args()
	resolver = BacktraceResolver(args.executable)
	resolver.parse_backtrace(args.backtrace)
