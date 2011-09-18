
require "_defines.rb"
require "_base.rb"
require "_skined.rb"

srcDir = GetSrcPath480x320ForUIInSkin($skinDefault, "HelpMenu");
destDir = GetDestPathForSubDirInSkin($skinDefault, "UI");
name = "HelpMenuUI"

PackToSingleAtlas(srcDir, destDir, name);