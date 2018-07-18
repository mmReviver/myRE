## My RE Toolset

### APK Kitchen
- **apkx** - Android APK Decompilation for the Lazy

```bash
$ git clone https://github.com/b-mueller/apkx
$ cd apkx
$ sudo ./install.sh
```

```bash
$ apkx -c enjarify -d procyon HelloWorld.apk 
Extracting HelloWord.apk to HelloWord
Converting: classes.dex -> classes.jar (enjarify)
enjarify HelloWord/classes.dex -> HelloWord/classes.jar
Decompiling to HelloWord/src (procyon)
```

- **apktools** - Android APK extract, de-compile & re-packaging tool

```bash
# Extract & de-compile apk to smali
$ apktool d target.apk

# Re-package
$ apktool b target_folder -o repackaged_target.apk
```

- **unzip** - unzip to extract the apk packet
Will get the file structure
    + META-INF/
    + lib/ARCH/xxxlib.so
    + res/
    + assets/
    + AndroidManifest.xml
    + classes.dex
    + resources.arsc

```bash
$ unzip target.apk -d target_folder
```

- **signapk** - Jar tool to sign apk file

```bash
$ java -jar signapk.jar certificate.pem privatekey.pk8 APK_TO_SIGN.apk SIGNED_APK.apk
```

- **keytool+jarsigner** - Generate key pairs and sign zip/apk

```bash
# Generate RSA key pairs with keytool (java tool in JDK)
$ keytool --genkey -v --keystore PATH_TO_KEY_STORE --alias MY_KEY_ALIAS --storepass MY_KEYSTORE_PASSWORD --keypass MY_KEYSTORE_PASSWORD --keyalg RSA --validity 14000

# Sign the zip or apk with jarsigner (java tool in JDK)
$ jarsigner -verbose -keystore PATH_TO_KEY_STORE.keystore -storepass MY_KEYSTORE_PASSWORD -keypass MY_KEYSTORE_PASSWORD MY_KEY_ALIAS

# Verify in case
$ jarsigner -keystore PATH_TO_KEY_STORE.keystore -storepass MY_KEYSTORE_PASSWORD -keypass MY_KEYSTORE_PASSWORD MY_KEY_ALIAS

# Align Everything
$ zipalign -v 4 TARGET_SIGNED_ZIP ALIGNED_SIGNED_ZIP_FILE

# Install
$ adb install ALIGNED_SIGNED_ZIP_FILE

```
### Dex & Jar
- **Enjarify** - dex to jar decompiler

https://github.com/Storyyeller/enjarify

```bash
$ enjarify classes.dex -o classes.jar
```

- **dex2jar** - same as enjarify

- **smali / baksmali**

https://bitbucket.org/JesusFreke/smali/downloads/

```bash
$ java -jar baksmali.jar d target.dex -o target_dir
$ java -jar smali.jar a target_dir -o target.dex
```

- **jadx-gui** - GUI for jar/dex file decompilation, Java code viewer


- **ByteCodeViewer** - Smali / Java code viewer
```bash
wget https://github.com/Konloch/bytecode-viewer/releases/download/2.9.10/Bytecode-Viewer-2.9.10.jar
echo "java -jar ~/bin/Bytecode-Viewer-2.9.10.jar" > bytecodeviewer
chmod +x bytecodeviewer
./bytecodeviewer
```

### Linux-based binary analysis tools
- **file** - list file info

```bash
# Check library file type, e.g. stripped? architecture?
$ file lib/armeabi/xxxlib.so
```

- **strings** - list plaintext strings in library or binary

```bash
$ strings lib/armeabi/xxxlib.so
```

- **nm** - Listing symbols on a *non-stripped* binary

```bash
$ arm-linux-androideabi-nm PATH_TO_LIB.so
```

- **readelf / objdump** - Display information about an elf format object

```bash
$ arm-linux-androideabi-readelf -h PATH_TO_LIB.so
$ arm-linux-androideabi-objdump -h PATH_TO_LIB.so
```

- **ndk-depends** - Check library dependencies  

```bash
$ <NDK-PATH>/ndk-depends PATH_TO_LIB.so

# Optional
$ arm-linux-androideabi-readelf -d PATH_TO_LIB.so
$ arm-linux-androideabi-objdump -tT PATH_TO_LIB.so
```

### Other binary analysis tools
- **ProGuard** - java class file shrinker, optimizer, obfuscator, and preverifier

https://www.guardsquare.com/proguard

```bash
$ tar zxvf ProGuard.tar.gz
$ cd ProGuard/bin
$ ./proguard-gui.sh
```

- **Androguard** - Reverse engineering, Malware and goodware analysis of Android applications ... and more (ninja !)

https://github.com/androguard/androguard

Docs:

http://androguard.readthedocs.io

- **dexlib2** - Lib to parse dex and smali code

(No docs)

https://github.com/JesusFreke/smali/tree/master/dexlib2

