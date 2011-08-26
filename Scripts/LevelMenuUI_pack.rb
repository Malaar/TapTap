
require "_defines.rb"
require "_base.rb"
require "_skined.rb"

srcDir = GetSrcPath480x320ForUIInSkin($skinDefault, "LevelMenu");
destDir = GetDestPathForSubDirInSkin($skinDefault, "UI");
name = "LevelMenuUI"

PackToSingleAtlas(srcDir, destDir, name);