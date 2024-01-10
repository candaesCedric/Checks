while ($true) {
    if (Get-ChildItem "$HOME\stop.*" | Where-Object { !$_.PSIsContainer }) { break }

    Add-Type -TypeDefinition '
        using System;
        using System.Runtime.InteropServices;

        public class Keyboard {
            [DllImport("user32.dll")]
            public static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, int dwExtraInfo);
        }
    '

    [Keyboard]::keybd_event(0x55, 0, 0, 0) 
    Start-Sleep -Milliseconds 100
    [Keyboard]::keybd_event(0x55, 0, 2, 0) 

    Start-Sleep -Seconds 5
}