# VideoDownsizer
You have many gigabytes of family videos of different smartphones/sizes/formats/orientations, etc.
You want to bring it to a common standard, reduce too large, do not touch too small and keep the timestamps.
Surprise! - No one popular video converter can do it in a right way.
Only magic FFmpeg can handle it, with just one (but long) command line. So...

This script resizes any video files to MP4, 720x720 box, keeping aspect ratio and original file timestamp. Smaller videos will not be enlarged.

  1) Install FFmpeg: https://ffmpeg.org/download.html
  2) Redefine script's variables: `FOLDER_INPUT, FOLDER_OUTPUT, FFMPEG`
  3) Run the script: `powershell .\VideoDownsizer.ps1`
  4) Enjoy! :-)
