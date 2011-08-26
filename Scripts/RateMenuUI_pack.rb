
require "_defines.rb"
require "_base.rb"
require "_skined.rb"

srcDir = GetSrcPath480x320ForUIInSkin($skinDefault, "RateMenu");
destDir = GetDestPathForSubDirInSkin($skinDefault, "UI");
name = "RateMenuUI"

PackToSingleAtlas(srcDir, destDir, name);