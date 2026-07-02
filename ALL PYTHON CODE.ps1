Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the Full Screen Form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Terminal Mainframe"
$form.BackColor = [System.Drawing.Color]::Black
$form.WindowState = "Maximized"
$form.FormBorderStyle = "None" 
$form.TopMost = $true 
$form.KeyPreview = $true 

# BLOCK ALL STANDARD CLOSING ATTEMPTS
$global:canClose = $false
$form.Add_FormClosing({
    if ($global:canClose -ne $true) {
        $_.Cancel = $true
    }
})

# SECRET UNLOCK KEY TRIGGER: Ctrl + Alt + Shift + H
$form.Add_KeyDown({
    param($sender, $e)
    if ($e.Control -and $e.Alt -and $e.Shift -and ($e.KeyCode -eq [System.Windows.Forms.Keys]::H)) {
        $global:canClose = $true
        $form.Close()
    }
})

# ==================== HACKER INTERFACE CONTROLS ====================
# Add Main Warning Text Label
$label = New-Object System.Windows.Forms.Label
$label.Text = "FATAL ERROR: SECURITY SUBSYSTEM FAILURE`nTHREAT LEVEL: CRITICAL`nUNAUTHORIZED PARTITION ACCESS ENFORCED"
$label.ForeColor = [System.Drawing.Color]::LimeGreen
$label.Font = New-Object System.Drawing.Font("Consolas", 20, [System.Drawing.FontStyle]::Bold)
$label.Size = New-Object System.Drawing.Size(1200, 160)
$label.Location = New-Object System.Drawing.Point(100, 50)
$form.Controls.Add($label)

# Add Detailed Terminal Log Output
$logBox = New-Object System.Windows.Forms.Label
$logBox.Text = ""
$logBox.ForeColor = [System.Drawing.Color]::DarkGreen
$logBox.Font = New-Object System.Drawing.Font("Consolas", 12)
$logBox.Size = New-Object System.Drawing.Size(1000, 240)
$logBox.Location = New-Object System.Drawing.Point(100, 220)
$form.Controls.Add($logBox)

# Add Progress Bar
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Size = New-Object System.Drawing.Size(1000, 30)
$progressBar.Location = New-Object System.Drawing.Point(100, 480)
$progressBar.Maximum = 30
$progressBar.Step = 1
$form.Controls.Add($progressBar)

# Add Percentage Counter Text
$pctLabel = New-Object System.Windows.Forms.Label
$pctLabel.Text = "Progress: 0%"
$pctLabel.ForeColor = [System.Drawing.Color]::LimeGreen
$pctLabel.Font = New-Object System.Drawing.Font("Consolas", 16)
$pctLabel.Size = New-Object System.Drawing.Size(300, 40)
$pctLabel.Location = New-Object System.Drawing.Point(1120, 480)
$form.Controls.Add($pctLabel)

# Add ASCII Art Label
$asciiLabel = New-Object System.Windows.Forms.Label
$asciiLabel.Text = @'
      XXXXXXXXXXXXX
   XXXXXXXXXXXXXXXXXXX
  XXXXXXXXXXXXXXXXXXXXX
  XXXXXXXX  XXX  XXXXXXXX
  XXXXXXXX  XXX  XXXXXXXX
  XXXX      XXX      XXXX
  XXXX      XXX      XXXX
  XXXXXXXXXXXXXXXXXXXXX
   XXXXXX X X X X XXXXX
    XXXXX X X X X XXXX
      XXXXXXXXXXXXX

      [ SYSTEM COMPROMISED ]
'@
$asciiLabel.ForeColor = [System.Drawing.Color]::LimeGreen
$asciiLabel.Font = New-Object System.Drawing.Font("Consolas", 14, [System.Drawing.FontStyle]::Bold)
$asciiLabel.Size = New-Object System.Drawing.Size(600, 350)
$asciiLabel.Location = New-Object System.Drawing.Point(450, 540)
$asciiLabel.Visible = $false
$form.Controls.Add($asciiLabel)


# ==================== BSOD INTERFACE CONTROLS ====================
# Add BSOD Screen Label
$bsodLabel = New-Object System.Windows.Forms.Label
$bsodLabel.Text = @'
:(  Your PC ran into a problem and needs to restart. We're just collecting some error info, and then we'll restart for you.

100% complete

For more information about this issue and possible fixes, visit https://windows.com

If you call a support person, give them this info:
Stop code: CRITICAL_PROCESS_DIED
'@
$bsodLabel.ForeColor = [System.Drawing.Color]::White
$bsodLabel.Font = New-Object System.Drawing.Font("Segoe UI", 16)
$bsodLabel.Size = New-Object System.Drawing.Size(1200, 500)
$bsodLabel.Location = New-Object System.Drawing.Point(150, 150)
$bsodLabel.Visible = $false
$form.Controls.Add($bsodLabel)

# Add Close Prompt Label (Hidden until 10 seconds of BSOD pass)
$closePrompt = New-Object System.Windows.Forms.Label
$closePrompt.Text = "[ Press CTRL + ALT + SHIFT + H to exit simulation ]"
$closePrompt.ForeColor = [System.Drawing.Color]::LightGray
$closePrompt.Font = New-Object System.Drawing.Font("Consolas", 12, [System.Drawing.FontStyle]::Italic)
$closePrompt.Size = New-Object System.Drawing.Size(600, 40)
$closePrompt.Location = New-Object System.Drawing.Point(150, 700)
$closePrompt.Visible = $false
$form.Controls.Add($closePrompt)


# ==================== ANIMATION LOGIC ====================
$logMessages = @(
    "[i] Establishing encrypted tunnel to cloud storage sync...",
    "[!] Warning: Kernel memory space modified.",
    "[i] Compressing local directory structures for offsite backup...",
    "[~] Uploading user profile hives to secure repository...",
    "[+] Cloud sync active: 4.1 GB transferred successfully.",
    "[i] Initiating deep directory purge routine...",
    "[-] Purging target path: C:\Windows\System32\drivers...",
    "[-] Deleting system binary architecture: C:\Windows\System32\*",
    "[!] Critical operating dependencies removed.",
    "[i] Clearing remaining shadow copy storage hdd_0..."
)

# Countdown Animation Logic (30 Seconds Hacker Screen + 10 Seconds BSOD)
$form.Add_Shown({
    $script:seconds = 0
    $timer = New-Object System.Windows.Forms.Timer
    $timer.Interval = 1000 
    $timer.Add_Tick({
        $script:seconds++
        
        if ($script:seconds -le 30) {
            # Standard Hacker View Routine
            $progressBar.PerformStep()
            $pctLabel.Text = "Progress: " + [math]::Round(($script:seconds / 30) * 100) + "%"
            
            $msgIndex = [math]::Floor(($script:seconds / 30) * $logMessages.Count)
            if ($msgIndex -lt $logMessages.Count) {
                $currentLines = $logBox.Text -split "`n"
                if ($currentLines -notcontains $logMessages[$msgIndex]) {
                    $logBox.Text += $logMessages[$msgIndex] + "`n"
                }
            }
        }
        elseif ($script:seconds -eq 31) {
            # Switch background to Windows BSOD Blue and clear out hacker text
            $form.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
            $label.Visible = $false
            $logBox.Visible = $false
            $progressBar.Visible = $false
            $pctLabel.Visible = $false
            $asciiLabel.Visible = $false
            
            # Show BSOD error message
            $bsodLabel.Visible = $true
        }
        elseif ($script:seconds -ge 41) {
            # Stop timer after 10 full seconds of BSOD display (Total 41 seconds)
            $timer.Stop()
            
        }
    })
    $timer.Start()
})

[System.Windows.Forms.Application]::Run($form)
