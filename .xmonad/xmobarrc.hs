Config { font = "xft:Monaco-10"
       , bgColor = "black"
       , fgColor = "grey"
       , position = Static {xpos = 0, ypos = 0, width = 1336, height = 24 }
       , lowerOnStart = True
       , commands = [ Run Network "wlan0" ["-L","0","-H","32","--normal","green","--high","red"] 10
                    , Run Network "eth0" ["-L","0","-H","32","--normal","green","--high","red"] 10
                    , Run Network "usb0" ["-L","0","-H","32","--normal","green","--high","red"] 10
                    , Run Network "bnep0" ["-L","0","-H","32","--normal","green","--high","red"] 10
                    , Run Cpu ["-t","<total>","-L","3","-H","50","--normal","green","--high","red"] 5
                    , Run Memory ["-t","<usedratio>%"] 10
                    , Run Swap ["-t", "<usedratio>%"] 10
                    , Run Battery ["-t", "<left>"] 30
                    , Run Date "%b %_d %R " "date" 10
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }{ %battery% | %cpu% | %memory% <fc=#ee9a00>%date%</fc>    "
       }
-- , Run Com "mocp" ["--format", "'%song - %album <fc=#ee9a00>%state</fc>'"] "" 1
-- , template = "%StdinReader% }{ %wlan0% %eth0% | %battery% %cpu% | %memory% <fc=#ee9a00>%date%</fc>    "
