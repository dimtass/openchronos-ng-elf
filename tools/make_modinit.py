#!/usr/bin/env python2
# encoding: utf-8
# vim: set ts=4 :
#
#           Copyright (C) 2012 Angelo Arrifano <miknix@gmail.com>
#
# This file is part of OpenChronos. This file is free software: you can
# redistribute it and/or modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation, version 2.
#
# openchronos-ng is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc., 51
# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#

import modules
from config import OpenChronosApp

initcode_1 = "\
/* This file is autogenerated by tools/make_modinit.py, do not edit! */\n\
\n\n"

initcode_2 = "\n\
void mod_init(void)\n\
{\n\
"

app = OpenChronosApp()
app.load_config()
cfg = app.get_config()

f = open('modinit.c', 'w')

f.write(initcode_1)
for mod in modules.get_modules():
    MOD = mod.upper()
    try:
        if cfg["CONFIG_MOD_%s" % MOD]["value"]:
            f.write("extern void mod_%s_init();\n" % (mod) )
    except KeyError:
        pass

f.write(initcode_2)
for mod in modules.get_modules():
    MOD = mod.upper()
    try:
        if cfg["CONFIG_MOD_%s" % MOD]["value"]:
            f.write("    mod_%s_init();\n" % (mod) )
    except KeyError:
        pass
f.write("}\n")
f.close()
