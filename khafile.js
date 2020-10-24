let project = new Project('Game 2d');
project.addAssets('Assets/**');
project.addShaders('Shaders/**');
project.addSources('Sources/');
project.addSources('Sources/UmbrellaToolKit/');
resolve(project);
