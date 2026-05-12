[reflection.assembly]::LoadWithPartialName("System.Drawing") | Out-Null

# Path to the image
$imgPath = "assets\bg-forest.png"
$fullPath = (Get-ChildItem $imgPath).FullName
$tempPath = [System.IO.Path]::GetTempFileName() + ".png"

# Load the image
$originalBitmap = [System.Drawing.Bitmap]::FromFile($fullPath)

# Create a new bitmap with the same dimensions
$width = $originalBitmap.Width
$height = $originalBitmap.Height
$enhanced = New-Object System.Drawing.Bitmap($width, $height)

# Process pixel by pixel
for($y = 0; $y -lt $height; $y++) {
    for($x = 0; $x -lt $width; $x++) {
        $pixel = $originalBitmap.GetPixel($x, $y)
        
        # Extract RGB components
        $r = [int]$pixel.R
        $g = [int]$pixel.G
        $b = [int]$pixel.B
        $a = [int]$pixel.A
        
        # Apply contrast: new_value = (old_value - 128) * 1.2 + 128
        $r = [System.Math]::Min(255, [System.Math]::Max(0, ($r - 128) * 1.2 + 128))
        $g = [System.Math]::Min(255, [System.Math]::Max(0, ($g - 128) * 1.2 + 128))
        $b = [System.Math]::Min(255, [System.Math]::Max(0, ($b - 128) * 1.2 + 128))
        
        # Create new pixel with adjusted contrast
        $newPixel = [System.Drawing.Color]::FromArgb([int]$a, [int]$r, [int]$g, [int]$b)
        $enhanced.SetPixel($x, $y, $newPixel)
    }
}

# Save to temporary location
$enhanced.Save($tempPath)

# Clean up - dispose of bitmap first to release the file lock
$enhanced.Dispose()
$originalBitmap.Dispose()

# Now replace the original file
Remove-Item $fullPath -Force
Move-Item $tempPath $fullPath -Force

Write-Host "Contrast increased by +20 for bg-forest.png"

Write-Host "Contrast increased by +20 for bg-forest.png"
