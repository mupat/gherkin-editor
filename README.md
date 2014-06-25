# gherkin-editor
A simple editor to read and write gherkin feature files.

## Features
....

## troubleshooting suse
- if you get an error like 
```
error while loading shared libraries: libudev.so.0: can
not open shared object file: No such file or directory
```
check this [site](https://github.com/rogerwang/node-webkit/wiki/The-solution-of-lacking-libudev.so.0) and run the *One line fix*
- `sed -i 's/\x75\x64\x65\x76\x2E\x73\x6F\x2E\x30/\x75\x64\x65\x76\x2E\x73\x6F\x2E\x31/g' node_modules/nodewebkit/nodewebkit/nw`

## troubleshooting mac
- if you get an error like
```
Invalid package.json 
Field 'main' is required.
```
rename `packag.json` in `nodewebkit`
- `mv node_modules/nodewebkit/package.json node_modules/nodewebkit/_package.json`
