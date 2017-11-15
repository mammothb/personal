# Custom functions
function which($cmd)
{
	get-command $cmd | % { $_.Path }
}

function chillhop()
{
	streamlink --hls-segment-threads 3 --player "mpv --cache=4096" https://www.youtube.com/watch?v=hX3j0sQ7ot8 worst
}

function sudo_bang_bang
{
    $cmd = (Get-History ((Get-History).Count))[0].CommandLine
    Write-Host "Running $cmd in $PWD"
    sudo powershell -NoExit -Command "pushd '$PWD'; Write-host 'cmd to run: $cmd'; $cmd"
}

function sudo
{
    if($args[0] -eq "!!") {
         sudo_bang_bang;
    }
    else {
       $file, [string]$arguments = $args;
       $psi = new-object System.Diagnostics.ProcessStartInfo $file;
       $psi.Arguments = $arguments;
       $psi.Verb = "runas";
       $psi.WorkingDirectory = get-location;
       [System.Diagnostics.Process]::Start($psi);
    }
}

# Set theme
. (Join-Path -Path (Split-Path -Parent -Path $PROFILE) -ChildPath $(
	switch($HOST.UI.RawUI.BackgroundColor.ToString()) {
		'White' { 'Set-SolarizedLightColorDefaults.ps1' }
		'Black' { 'Set-SolarizedDarkColorDefaults.ps1' }
		default { return }
	}))
