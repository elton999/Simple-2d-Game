let fs = require('fs');
let path = require('path');
let project = new Project('Game 2d');
project.addDefine('HXCPP_API_LEVEL=332');
project.targetOptions = {"html5":{},"flash":{},"android":{},"ios":{}};
project.setDebugDir('build/windows');
await project.addProject('build/windows-build');
await project.addProject('d:/steam/steamapps/common/Kode Studio/resources/app/kodeExtensions/kha/Kha');
resolve(project);
