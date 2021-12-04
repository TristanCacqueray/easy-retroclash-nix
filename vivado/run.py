#!/bin/python3
# SPDX-License-Identifier: Apache-2.0

import os
import subprocess
import sys
from pathlib import Path

ROOT = "/var/home/vivado"
prefix = "/opt/Xilinx/Vivado/2018.2/bin/" if sys.argv[1] == "vivado" else ""

os.environ["LC_ALL"] = "C"
os.environ["HOME"] = "/home/centos"
# Map the host project to /src and preserve the relative work dir
cwd = Path(os.getcwd())
if cwd.parent.name == "_build":
    project_root = cwd.parent.parent
    work = "_build/" + cwd.name
else:
    project_root = cwd
    work = ""

cmd = (
    ["bwrap", "--ro-bind", ROOT, "/"]
    + ["--dev", "/dev", "--dev-bind", "/dev/bus", "/dev/bus"]
    + ["--tmpfs", "/run", "--tmpfs", "/tmp"]
    + ["--proc", "/proc"]
    + ["--unshare-ipc", "--unshare-net", "--unshare-pid"]
    + ["--bind", str(project_root), "/usr/src", "--chdir", "/usr/src/" + work]
    + [prefix + sys.argv[1]]
    + sys.argv[2:]
)
if subprocess.Popen(cmd).wait():
    exit(1)
