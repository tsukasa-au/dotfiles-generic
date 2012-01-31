Config { font = "xft:Monaco-10"
       , bgColor = "black"
       , fgColor = "grey"
       , position = Static {xpos = 1280, ypos = 0, width = 2560, height = 24 }
       , lowerOnStart = True
       , commands = [ Run Network "eth0" ["-L","0","-H","32","--normal","green","--high","red"] 10
                    , Run Cpu ["-L","3","-H","50","--normal","green","--high","red"] 5
                    , Run Memory ["-t","Mem: <usedratio>%"] 10
                    , Run Swap [] 10
                    , Run Date "%b %_d %R " "date" 10
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }{ %eth0% | %cpu% | %memory% * %swap%  <fc=#ee9a00>%date%</fc>   "
       }
-- , Run Com "mocp" ["--format", "'%song - %album <fc=#ee9a00>%state</fc>'"] "" 1
