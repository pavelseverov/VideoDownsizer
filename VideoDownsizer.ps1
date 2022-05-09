<# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
Video Downsizer v.1.0

https://github.com/pavelseverov/VideoDownsizer
Pavel Severov http://severov.net/ May 2022

You have many gigabytes of family videos of different smartphones/sizes/formats/orientations, etc.
You want to bring it to a common standard, reduce too large, do not touch too small and keep the timestamps.
Surprise! - No one popular video converter can do it in a right way.
Only magic FFmpeg can handle it with just one (but long) command line. So...

This script resizes any video files to MP4, 720x720 box, keeping aspect ratio and original file timestamp. Smaller videos will not be enlarged.

  1) Install FFmpeg: https://ffmpeg.org/download.html
  2) Redefine script's variables: FOLDER_INPUT, FOLDER_OUTPUT, FFMPEG
  3) Run the script: powershell .\VideoDownsizer.ps1
  4) Enjoy! :-)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #> 


$FOLDER_INPUT="N:\test_video_compression\video_src"
$FOLDER_OUTPUT="N:\test_video_compression\video_dst"
$FFMPEG="C:\PROGRA~1\ffmpeg\bin\ffmpeg.exe" 

$i=0
foreach ($src in Get-ChildItem $FOLDER_INPUT\*) {
  if (!$src.PSIsContainer) {
    $dst=$FOLDER_OUTPUT+"\"+$src.Basename+"_shr.mp4"
    $i++
    Write-Host $i"." $src.LastWriteTime $src "-->" $dst
    Remove-Item .\ffmpeg-20*.log #delete previous logs
    Remove-Item -LiteralPath $dst
    $ffmpeg_video_filters="""scale='min(720,iw)':'min(720,ih)':force_original_aspect_ratio=decrease,pad='iw+mod(iw\,2)':'ih+mod(ih\,2)'"""
    $ffmpeg_arguments=" -i """+$src+""" -vf "+$ffmpeg_video_filters+" -report -map_metadata 0 """+$dst+""""
    $process = Start-Process -WindowStyle Minimized -PassThru -Wait -FilePath $FFMPEG -ArgumentList $ffmpeg_arguments
    if ($process.ExitCode -gt 0) {
      Write-Host "*** FAILURE of $src encoding, check the ffmpeg*.log file"
      exit
    }
    ([io.FileInfo]($dst)).LastWriteTime = $src.LastWriteTime #restoring original timestamp
  }
}

Remove-Item .\ffmpeg-20*.log #delete the log of last encoding
Write-Host "Done."
