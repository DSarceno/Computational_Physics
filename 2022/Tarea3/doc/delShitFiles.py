import subprocess
import sys

name = sys.argv[1]

subprocess.call(['rm', name + '.aux'])
subprocess.call(['rm', name + '.log'])
subprocess.call(['rm', name + '.out'])
subprocess.call(['rm', name + '.synctex.gz'])
