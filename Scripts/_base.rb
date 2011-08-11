#! user/bin/ruby

#====================================================================
#remake destination directory
def PrepareDestinationDir(destDir)
    if !File.directory?(destDir)
		Dir.mkdir(destDir)
    end
end

#====================================================================
#to process by ImageMagick all png files in directory and place it in target directory 
def ProcessSubDir (srcDir, destDir)
    PrepareDestinationDir(destDir)
    files = Dir.entries(srcDir)
	for file in files
		if File.extname(file) == ".png"
			puts "Process file: #{file}"
			fileFrom = srcDir + "/" + file
   		    fileTo = destDir + "/" + file
	#		puts "convert -resize 50% #{fileFrom} #{fileTo}"
			system("convert -resize 50% '#{fileFrom}' '#{fileTo}'")
		end
	end
end

#====================================================================
def ProcessAnimationsDir (srcDir, destDir, subDir = "")
	curDir = srcDir + subDir
	puts "Current dir: #{curDir}"
	PrepareDestinationDir(destDir)
	elements = Dir.entries(curDir)
	puts "Elements count: #{elements.count}"
	for e in elements
		if File.directory?(curDir + "/" + e) and e[0,1] != '.'
			puts "\n\nProcess sub dir: #{e}"
			ProcessAnimationsDir(srcDir, destDir, subDir + "/" + e)
		elsif File.extname(e) == ".png"
			puts "Process file: #{e	}"
			fileFrom = curDir + "/" + e
   		    fileTo = destDir + "/" + e
			puts "convert -resize 50% #{fileFrom} #{fileTo}"
			system("convert -resize 50% '#{fileFrom}' '#{fileTo}'")
		end
	end
end


#====================================================================
def ProcessDir(srcDir, destDir, subDir = "")
	curDir = srcDir + subDir
	puts "Current dir: #{curDir}"
	PrepareDestinationDir(destDir)
	elements = Dir.entries(curDir + subDir)
	puts "Elements count: #{elements.count}"
	for e in elements
		if File.directory?(curDir + "/" + e) and e[0,1] != '.'
			puts "\n\nProcess sub dir: #{e}"
			ProcessDir(srcDir, destDir, subDir + "/" + e)
		elsif File.extname(e) == ".png"
			puts "Process file: #{e	}"
			fileFrom = curDir + "/" + e
   		    fileTo = destDir + subDir + "/" + e
			puts "convert -resize 50% #{fileFrom} #{fileTo}"
			system("convert -resize 50% '#{fileFrom}' '#{fileTo}'")
		end
	end
end

#====================================================================
# pack all png files in srcDir in SEVERAL atlas and put it in destDir
def PackToAtlas(srcDir, destDir, name)
	puts "Process '#{name}': #{destDir}/#{name}"
	dirs = Dir.entries(srcDir)
	i = 0
	for dir in dirs
    	if (!File.file?(dir)) and (dir[0,5] == 'part_')
    		curSubDir = srcDir + "/" + dir

   			system("TexturePacker --data #{destDir}/#{name}_#{i}.plist --sheet #{destDir}/#{name}_#{i}.png --format cocos2d --algorithm Basic --max-width 1024 --max-height 1024 #{curSubDir} --shape-padding 1")
   			i = i + 1
	    end
    end
	
	puts "\n\n"
end

#====================================================================
# pack all png files in srcDir in ONE atlas and put it in destDir
def PackToSingleAtlas(srcDir, destDir, name)
	puts "Process '#{name}': #{destDir}/#{name}"
	system("TexturePacker --data #{destDir}/#{name}_#{0}.plist --sheet #{destDir}/#{name}_#{0}.png --format cocos2d --algorithm Basic --max-width 1024 --max-height 1024 #{srcDir} --shape-padding 1")

	puts "\n\n"
end

#====================================================================
