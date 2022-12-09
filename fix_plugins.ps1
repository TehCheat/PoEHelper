Get-ChildItem .\Plugins -Recurse -Filter *.csproj |
ForEach-Object{
Write-Host "Processing $($_.FullName)"
& ./ConvertTool/try-convert.exe -tfm net6.0-windows -w $_.FullName --most-recent-msbuild
$content = (Get-Content $_.FullName -Raw) -replace 
"<PackageReference Include=""Newtonsoft.Json"" Version=""[^""]+"" />", "<PackageReference Include=""Newtonsoft.Json"" Version=""13.0.1"" />" -replace
"<PackageReference Include=""SharpDX"" Version=""[^""]+"" />", "<PackageReference Include=""SharpDX"" Version=""4.2.0"" />" -replace
"<PackageReference Include=""SharpDX.Desktop"" Version=""[^""]+"" />", "<PackageReference Include=""SharpDX.Desktop"" Version=""4.2.0"" />" -replace
"<PackageReference Include=""SharpDX.Mathematics"" Version=""[^""]+"" />", "<PackageReference Include=""SharpDX.Mathematics"" Version=""4.2.0"" />" -replace
"<PackageReference Include=""System.Numerics.Vectors"" Version=""[^""]+"" />", "<PackageReference Include=""System.Numerics.Vectors"" Version=""4.5.0"" />" -replace
"<PackageReference Include=""System.Runtime.CompilerServices.Unsafe"" Version=""[^""]+"" />", "<PackageReference Include=""System.Runtime.CompilerServices.Unsafe"" Version=""5.0.0"" />"
if($content -notmatch "AppendTargetFrameworkToOutputPath")
{
$content = $content -replace "<Project Sdk=""Microsoft.NET.Sdk"">", @"
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <AppendTargetFrameworkToOutputPath>false</AppendTargetFrameworkToOutputPath>
  </PropertyGroup>
"@
}
if($content -notmatch "AppendRuntimeIdentifierToOutputPath")
{
$content = $content -replace "<Project Sdk=""Microsoft.NET.Sdk"">", @"
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <AppendRuntimeIdentifierToOutputPath>false</AppendRuntimeIdentifierToOutputPath>
  </PropertyGroup>
"@
}
if($content -notmatch "EnableDynamicLoading")
{
$content = $content -replace "<Project Sdk=""Microsoft.NET.Sdk"">", @"
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <EnableDynamicLoading>true</EnableDynamicLoading>
  </PropertyGroup>
"@
}
$content | Set-Content $_.FullName -NoNewline -Encoding UTF8
}
