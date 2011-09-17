
require "_defines.rb"
require "_base.rb"
require "_skined.rb"

srcDir = GetSrcPath480x320ForUIInSkin($skinDefault, "PackMenu");
destDir = GetDestPathForSubDirInSkin($skinDefault, "UI");
name = "PackMenuUI"

PackToSingleAtlas(srcDir, destDir, name);