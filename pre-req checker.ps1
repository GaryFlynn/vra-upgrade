$role = Read-Host -Prompt "Enter the vRA Role ie. DEM/WEB/DEM and WEB"

function SchUseStrongCrypto {
    $path = "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319"
    $name = "SchUseStrongCrypto"
    $value = "1"
    New-ItemProperty -Path  $path -Name $name -Value $value -PropertyType DWORD -Force | Out-Null
    Write-Host -ForegroundColor Green "Created..." $path"\"$name "with value" $value

    $path = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319"
    $name = "SchUseStrongCrypto"
    $value = "1"
    New-ItemProperty -Path  $path -Name $name -Value $value -PropertyType DWORD -Force | Out-Null
    Write-Host -ForegroundColor Green "Created..." $path"\"$name "with value" $value
}

function SystemDefaultTlsVersions {
    $path = "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319"
    $name = "SystemDefaultTlsVersions"
    $value = "1"
    New-ItemProperty -Path  $path -Name $name -Value $value -PropertyType DWORD -Force | Out-Null
    Write-Host -ForegroundColor Green "Created..." $path"\"$name "with value" $value

    $path = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319"
    $name = "SystemDefaultTlsVersions"
    $value = "1"
    New-ItemProperty -Path  $path -Name $name -Value $value -PropertyType DWORD -Force | Out-Null
    Write-Host -ForegroundColor Green "Created..." $path"\"$name "with value" $value
}

function NonHTTPActivation {
    $name = "NET-Non-HTTP-Activ"
    Install-WindowsFeature -Name $name
    Write-Host -ForegroundColor Green "Added Windows Feature" $name
}

function Java {
    if ($env:JAVA_HOME) {
        Write-Host -ForegroundColor Yellow "JAVA_HOME is currently set to" $env:JAVA_HOME
        if ($env:JAVA_HOME.Contains("181")) {
            Write-Host -ForegroundColor Green "Java 8 update 181 is installed"
        }
        else {
            Write-Host -ForegroundColor Red "INSTALL JAVA 8 UPDATE 181 MANUALLY"
        }
    }
    else {
        Write-Host -ForegroundColor Red "JAVA_HOME variable not set!"
    }
}

function tls12 {
    $path = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols"
    $name = "TLS 1.2"
    New-Item -Path $path -Name $name -Force | Out-Null
    Write-Host -ForegroundColor Green "Created..." $path"\"$name

    $path = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2"
    $name = "Client"
    New-Item -Path $path -Name $name -Force | Out-Null
    Write-Host -ForegroundColor Green "Created..." $path"\"$name

    $path = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client"
    $name = "DisabledByDefault"
    $value = "0"
    New-ItemProperty -Path  $path -Name $name -Value $value -PropertyType DWORD -Force | Out-Null
    Write-Host -ForegroundColor Green "Created..." $path"\"$name "with value" $value

    $path = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client"
    $name = "Enabled"
    $value = "1"
    New-ItemProperty -Path  $path -Name $name -Value $value -PropertyType DWORD -Force | Out-Null
    Write-Host -ForegroundColor Green "Created..." $path"\"$name "with value" $value
}

if ($role.ToUpper().Contains("DEM")) {
    SchUseStrongCrypto
    SystemDefaultTlsVersions
    NonHTTPActivation
}

if ($role.ToUpper().Contains("WEB")) {
    SchUseStrongCrypto
    SystemDefaultTlsVersions
    Java
    tls12
}


