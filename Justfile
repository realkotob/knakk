# Export the project

export-web:
    rm -rf export/web
    mkdir -p export/web
    godot --headless --export-release "Web" export/web/index.html 

export-linux:
    rm -rf export/linux
    mkdir -p export/linux
    godot --headless --export-release "Linux/X11" export/linux/knakk.x86_64 

export-osx:
    rm -rf export/osx
    mkdir -p export/osx
    godot --headless --export-release "OSX" export/osx/knakk.app

export-windows:
    rm -rf export/windows
    mkdir -p export/windows
    godot --headless --export-release "Windows Desktop" export/windows/knakk.exe

export-android:
    rm -rf export/android
    mkdir -p export/android
    godot --headless --export-release "Android aab" export/android/knakk.aab
    godot --headless --export-release "Android apk" export/android/knakk.apk

export: export-web export-linux export-osx export-windows export-android

# Upload exported files to various distribution platforms

release-web: export-web
    netlify deploy --dir export/web --prod

release-linux: export-linux
    butler push export/linux raffomania/knakk:linux

release-osx: export-osx
    butler push export/osx raffomania/knakk:osx

release-windows: export-windows
    butler push export/windows raffomania/knakk:windows

release-android: export-android
    butler push export/android/knakk.apk raffomania/knakk:android

release: release-web release-linux release-osx release-windows release-android 

generate-card-images:
    fd png$ GameScreen/Card/source_images -x magick convert {} -resize 295x410 -background transparent -gravity center -extent 295x410 GameScreen/Card/images/{/}