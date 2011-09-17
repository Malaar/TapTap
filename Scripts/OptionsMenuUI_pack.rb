
require "_defines.rb"
require "_base.rb"
require "_skined.rb"

srcDir = GetSrcPath480x320ForUIInSkin($skinDefault, "OptionsMenu");
destDir = GetDestPathForSubDirInSkin($skinDefault, "UI");
name = "OptionsMenuUI"

PackToSingleAtlas(srcDir, destDir, name);