# wallpaper-processor
Creates a resized and cropped version and a blurred version of any image file, letting you choose the blur level and opting for pixel spread.
## Features:
- **Interactive:** no command arguments, just answer 3 questions.
- **Automatic resolution detection**.
- **Intelligent crop** to your aspect ratio, no stretching.
- Pixel spread (that grainy effect).


## Requirements:
- [`ImageMagick`](https://imagemagick.org/script/download.php)


## Usage
First, give execution permissions, only before first use:
    <pre>
    <b>~ $</b> sudo chmod +x process-wallpaper.sh</pre>
Use:
    <pre>
    <b>~ $</b> ./process-wallpaper.sh image_file.jpg</pre>
### Example
<pre>
<b>~ $</b> ./process-wallpaper.sh image_file.jpg
Loaded <b>image_file.jpg</b>
Automatically get your resolution? (<b>Y</b>es / <b>N</b>o / default: <b>Yes</b>):y
Getting resolution from xrandr... 
Resolution set to <b>1920x1080</b>.
How much blur? (<b>L</b>ow / <b>H</b>igh / <b>U</b>ltra / default: <b>High</b>):u
Blur set to <b>ultra</b>.
Do you want to avoid/skip spread? (that grainy effect) (Yes /No / default: No):n
Processing <b>with</b> spread.
Execute? (y/n):y
Processing...
Done!
<b>~ $</b>
</pre>