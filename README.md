# start, stop and restart script for unix mongodb-server

## Install MongoDB Community Edition

### Download the binary files
```
curl -O https://fastdl.mongodb.org/osx/mongodb-osx-x86_64-3.4.4.tgz
```

### Extract the files from the downloaded archive
```
tar -zxvf mongodb-osx-x86_64-3.4.4.tgz
```

### Copy the extracted archive to the target directory
```
mkdir -p mongodb
cp -R -n mongodb-osx-x86_64-3.4.4/ mongodb
```

### Ensure the location of the binaries is in the PATH variable
```
export PATH=<mongodb-install-directory>/bin:$PATH
```

## Example mongod.conf configuration file
```
systemLog:
   destination: file
   path: "/var/log/mongodb/mongod.log"
   logAppend: true
storage:
   journal:
      enabled: true
processManagement:
   fork: true
net:
   bindIp: 127.0.0.1
   port: 27017
setParameter:
   enableLocalhostAuthBypass: false
...
```

## start, stop, restart script usage
Set the following variables inside the script

mongodb home path:
```
MONGOHOME=".../mongodb"
```
mongodb data directory path:
```
MONGODBPATH=".../mongodb/data"
```
mongodb configuration file path:
```
MONGODBCONFIG=".../mongod.conf"
```
