$ErrorActionPreference= 'silentlycontinue'

# Executa como administrador, libera a politica de execu��o de Scripts e permanece no diret�rio atual.
if(-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        Start-Process PowerShell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Unrestricted -Command `"cd '$pwd'; & '$PSCommandPath';`"";
        Exit;
    }
}
Clear-Host

# Cria o usu�rio "NOME_USU�RIO" e define a senha
net user "NOME_USU�RIO" 'SENHA_USU�RIO' /add

# Impede a expira��o da senha ap�s 42 dias
NET ACCOUNTS /MAXPWAGE:UNLIMITED

# Seta o usu�rio "NOME_USU�RIO" como ADM
net localgroup Administradores "NOME_USU�RIO" /add

# Remove o usu�rio "NOME_USU�RIO" como usu�rio comum
net localgroup Usu�rios "NOME_USU�RIO" /delete

Clear-Host

Write-Output ("============================")
Write-Output ("Usu�rio criado com sucesso!")
Write-Output ("============================")