$dir = "C:\backup"
$list = Get-ChildItem -Path $dir

ForEach ($item in $list){
$name = $item.FullName
$ext = Get-ItemProperty -Path $name | select -Property Extension
$ext = "$ext"

if ($ext -eq "@{Extension=.zip}"){}
else {
    $date = Get-Date
    Compress-Archive -Path $name -DestinationPath ($name + ".zip") -CompressionLevel Optimal -Update  
    echo "$date файл $item был заархивирован">> "C:\backup\log.txt"
    echo "--------------------------------------------------------------------------------" >> "C:\backup\log.txt"
    }
}
