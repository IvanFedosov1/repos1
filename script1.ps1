$dir = "C:\dir1"
$list = Get-ChildItem -Path $dir

ForEach ($item in $list){
$full_name = $item.FullName
$ext = Get-ItemProperty -Path $full_name | select -Property Extension
$ext = "$ext"

if ($ext -eq "@{Extension=.zip}"){}
else {
    $date = Get-Date
    Compress-Archive -Path $full_name -DestinationPath ($full_name + ".zip") -CompressionLevel Optimal -Update  2>> "C:\dir1\errorlog.txt"
    echo "$date файл $item был заархивирован">> "C:\dir1\log.txt"
    echo "--------------------------------------------------------------------------------" >> "C:\dir1\log.txt"
    }

}
