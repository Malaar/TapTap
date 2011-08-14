
require "_defines.rb"
require "_base.rb"
require "_skined.rb"

srcDir = GetSrcPath480x320ForUIInSkin($skinDefault, "MainMenu");
destDir = GetDestPathForSubDirInSkin($skinDefault, "UI");
name = "MainMenuUI"

PackToSingleAtlas(srcDir, destDir, name);