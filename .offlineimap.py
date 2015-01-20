#!/usr/bin/env python
import re, os

def get_authinfo(machine, port):
    l = "machine {machine} login (?P<login>[^\"]*?) port {port} password \"(?P<password>[^\"]*)\"".format(machine=machine, port=port)
    p = re.compile(l)
    authinfo = os.popen("gpg2 -q --no-tty -d ~/.authinfo.gpg").read()
    return dict(zip(["username", "password"], p.search(authinfo).groups()))
