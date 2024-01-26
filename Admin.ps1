$ErrorActionPreference= 'silentlycontinue'

# Executa como administrador, libera a politica de execução de Scripts e permanece no diretório atual.
if(-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        Start-Process PowerShell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Unrestricted -Command `"cd '$pwd'; & '$PSCommandPath';`"";
        Exit;
    }
}
Clear-Host

# Cria o usuário "NOME_USUÁRIO" e define a senha
net user "NOME_USUÁRIO" 'SENHA_USUÁRIO' /add

# Impede a expiração da senha após 42 dias
NET ACCOUNTS /MAXPWAGE:UNLIMITED

# Seta o usuário "NOME_USUÁRIO" como ADM
net localgroup Administradores "NOME_USUÁRIO" /add

# Remove o usuário "NOME_USUÁRIO" como usuário comum
net localgroup Usuários "NOME_USUÁRIO" /delete

Clear-Host

Write-Output ("============================")
Write-Output ("Usuário criado com sucesso!")
Write-Output ("============================")
