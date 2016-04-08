#!/usr/bin/env python
import re, os, fcntl

def get_authinfo(machine, port):
    fcntl.flock(open("/home/emallson/.authinfo.gpg"), fcntl.LOCK_EX)
    l = "machine {machine} login (?P<login>[^\"]*?) port {port} password \"(?P<password>[^\"]*)\"".format(machine=machine, port=port)
    p = re.compile(l)
    authinfo = os.popen("gpg2 -q --no-tty --use-agent -d ~/.authinfo.gpg").read()
    fcntl.flock(open("/home/emallson/.authinfo.gpg"), fcntl.LOCK_UN)
    return dict(zip(["username", "password"], p.search(authinfo).groups()))

def sub(mapping):
    def _sub(s):
        try:
            return mapping[s]
        except:
            return s
    return _sub

def rsub(mapping):
    return sub({v: k for k, v in mapping.items()})

def ignore(l):
    def _i(s):
        return s not in l
    return _i
