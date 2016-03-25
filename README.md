# APKDecompiler
Bash script to decompile an APK

APKDecompiler is a Bash script that can decompile any apk.
It uses [dex2jar]http://code.google.com/p/dex2jar/, [JD-Core-java](https://github.com/nviennot/jd-core-java), and [apktool](http://ibotpeaches.github.io/Apktool/) to get all the class and manifest files from an APK. 

## Usage


```bash
sh decompiler.sh [App.apk]
```

That's it! Just put the apk you want to be decompiled as an argument to the script, and it will be decompiled and placed into APKs > App for you.

*Remember to add executable privileges to decompile.sh by running:

```bash
chmod +x decompile.sh
```

##Note
 
When I uploaded these files, I was using dex2jar 0.0.9.15 (06/05/2013), JD-Core-Java (06/14/2015), and APKTool 2.0.3 (12/31/2015).

I have no plans of keeping up with this project (which means it's unlikely I'll be updating to later releases of these programs) and honestly, I'm not even sure if it would work in Linux (since I haven't tested it), so keep that in mind.