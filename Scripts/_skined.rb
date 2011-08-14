#! user/bin/ruby

require "_defines.rb"

# skined

#====================================================================
# path to get graphics
# get path for subdir in 'UI' folder from source directory accordin to skin name and screen dimention
# @param screenDimention - dimention of the screen
# @param skinName - name of the skin directory
# @param subDirName - name of the subdir in 'UI' folder
def GetSrcPathForUIInSkin(screenDimention, skinName, subDirName)
	return screenDimention + '/' + skinName + '/' + 'UI' + '/' + subDirName;
end

#====================================================================
# path to get graphics
# get path for subdir in 'UI' folder from source directory accordin to skin name and screen dimention 480x320
# @param skinName - name of the skin directory
# @param subDirName - name of the subdir in 'UI' folder
def GetSrcPath480x320ForUIInSkin(skinName, subDirName)
	return GetSrcPathForUIInSkin($src480x320, skinName, subDirName);
end

#====================================================================
# path to get graphics
# get path for subdir in 'UI' folder from source directory accordin to skin name and screen dimention 960x640
# @param skinName - name of the skin directory
# @param subDirName - name of the subdir in 'UI' folder
def GetSrcPath960x640ForUIInSkin(skinName, subDirName)
	return GetSrcPathForUIInSkin($src960x640, skinName, subDirName);
end

#====================================================================
# path to put graphics
# get path for subdir in skin direcory with name 'skinName'
# this path for destination place for ready graphics based on 'Resources/assets' folder
def GetDestPathForSubDirInSkin(skinName, subDirName)
	return $destDirGraphics + '/' + skinName + '/' + subDirName;
end

#====================================================================
#====================================================================
#====================================================================
