function applyListeners {
    Write-Host "[INFO] applyListeners"
    $listenAddresses = (Get-ItemProperty -Path "HKLM:\Software\Policies\Syncthing" -Name "listenAddresses" -ErrorAction SilentlyContinue).listenAddresses
    if ($listenAddresses -eq $null) {
        $listenAddresses = "tcp4://:22000, dynamic+https://relays.syncthing.net/endpoint"
    }
    #
    $xml = New-Object XML
    $xml.PreserveWhitespace = $true
    $xml.Load($configXml)
    #
    $optionsNode = $xml.SelectSingleNode('//configuration/options')
    #
    # Remove all listenAddress
    $toRemove = @()
    foreach ($node in $optionsNode.ChildNodes) {
        if ($node.NodeType -eq "Element" -and $node.Name -eq "listenAddress") {
            $prev = $node.PreviousSibling
            if ($prev -and $prev.NodeType -eq "Whitespace") {
                $toRemove += $prev
            }
            $toRemove += $node
        }
    }
    foreach ($n in $toRemove) {
        $optionsNode.RemoveChild($n) | Out-Null
    }
    #
    # Add listenAddress
    $refChild = $optionsNode.FirstChild
    foreach ($addr in $listenAddresses -split ', ') {
        $node = $xml.CreateElement('listenAddress')
        $node.InnerText = $addr
        $newNode = $optionsNode.InsertBefore($node, $refChild)
        $optionsNode.InsertBefore($xml.CreateWhitespace("`r`n        "), $newNode) | Out-Null
    }
    #
    $xml.Save($configXml);
}
#
#
# Runtime Variables.
$configXml = (${ENV:ProgramData} + "\Syncthing\config.xml")
#
applyListeners
Exit 0
