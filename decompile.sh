#!bin/bash
#This script will decompile an APK using the tools
#dex2jar and framework-res.apk
#
#Author: Kyle Elmore
#
#Credits:
#StackOverflow Question: http://tinyurl.com/o67mrb9
#JD-Core-java: https://github.com/nviennot/jd-core-java
#dex2jar: http://code.google.com/p/dex2jar/
#apktool: http://ibotpeaches.github.io/Apktool/

#All the tools used by this program:
dex2jar="dex2jar-0.0.9.15"
JD_Decompiler="jd-decompiler/build/libs/jd-core-java-1.2.jar"
apktool="apktool/apktool"

#Returns the basename for an apk from the file's full path
getAppName() {
	fullPath=$1
	fullPath=${fullPath##*/}
	echo "${fullPath%.apk}"
}

#Returns the basename for a dex file from the file's full path
getAppNameDex() {
	fullPath=$1
	fullPath=${fullPath##*/}
	echo "${fullPath%.dex}"
}

#Check if APK argument supplied
if [ $# -eq 0 ]; then
	echo "Need apk as argument"
	exit
fi

#Get App name from APK argument
appName=$(getAppName $1)
echo "Copying $appName to APK directory..."

appLocation="APKs/$appName"

#Check for APK folder
if [ ! -d "APKs" ]; then
    mkdir "APKs"
fi

#Check if decompiled App already exists
if [ -d "$appLocation" ]; then
	echo "$appName folder already exists, deleting..."
	sudo rm -r $appLocation
fi

echo "Creating folder and unzipping apk"

mkdir $appLocation
cp $1 $appLocation

mv "$appLocation/$appName.apk" "$appLocation/$appName.zip"

#Unzip both dex2jar and the APK
unzip "$appLocation/$appName.zip" -d $appLocation > /dev/null
unzip "$dex2jar.zip" -d $appLocation > /dev/null

echo "Getting class files using dex2jar and JD-Core-Java:"

#Loop through all classes files and decompile them using
#dex2jar and JD-Core-Java
for classFile in "$appLocation/"*.dex
do
	name=$(getAppNameDex $classFile) 
	mkdir "$appLocation/$name"
	sh "$appLocation/$dex2jar/d2j-dex2jar.sh" "$classFile"
	java -jar $JD_Decompiler "$name-dex2jar".jar "$appLocation/$name" &> /dev/null
	rm c*.jar
done

echo "Getting manifest files using APKTool:"

sh $apktool d $1
#Using rsync instead of mv because rsync merges automatically
rsync -a "$appName/" $appLocation

echo "Performing clean up..."
rm -rf "$appName/"
rm "$appLocation/$appName".zip
mv $1 APKs/ &> /dev/null

echo "Done!"

exit