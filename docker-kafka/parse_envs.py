#!/bin/python

import re
from os import environ

envvars = {}

startswith = re.compile("^[\w]+\.")
with open("{}/config/server.properties".format(environ['KAFKA_HOME']), "r") as f:
    for line in f:
        if startswith.match(line) is not None:
            key, value = line.strip().split("=", 1)
            envvars[key] = value

for key in environ:
    if key.startswith("kafka."):
        envvars[key.replace("kafka.", "")] = environ[key]


with open("{}/config/server-generated.properties".format(environ['KAFKA_HOME']), "w+") as f:
    for key in envvars:
        f.write("{}={}\n".format(key, envvars[key]))