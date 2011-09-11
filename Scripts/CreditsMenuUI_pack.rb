
require "_defines.rb"
require "_base.rb"
require "_skined.rb"

srcDir = GetSrcPath480x320ForUIInSkin($skinDefault, "CreditsMenu");
destDir = GetDestPathForSubDirInSkin($skinDefault, "UI");
name = "CreditsMenuUI"

PackToSingleAtlas(srcDir, destDir, name);