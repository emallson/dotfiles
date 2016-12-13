%sh{
    bg="rgb:202020"
    bg1="rgb:303030"
    fg="rgb:DCDCCC"
    fg1="rgb:ececdc"
    red="rgb:CC9393"
    orange="rgb:DFAF8F"
    yellow="rgb:F0DFAF"
    yellow_2="rgb:D0BF8F"
    green="rgb:7F9F7F"
    green2="rgb:9FBF9F"
    green4="rgb:BFDFBF"
    cyan="rgb:93E0E3"
    blue="rgb:8CD0D3"
    blue1="rgb:9ce0e3"
    blue_1="rgb:7cc0c3"
    magenta="rgb:DC8CC3"

    echo "
	face builtin ${fg}+b
        face keyword ${yellow}+b
	face comment ${green}
	face meta ${blue1}
	face string ${red}
	face identifier ${orange}
	face type ${blue_1}+i
	face value ${green4}
	face attribute keyword

        face Default ${fg},${bg}
	face MenuForeground ${green4}
	face MenuBackground ${fg},rgb:252525
	face MenuInfo ${green2}
	face PrimarySelection ${fg}+i
	face SecondarySelection ${yellow}+i
	face PrimaryCursor ${bg},${fg}
	face SecondaryCursor ${bg},${yellow}
	face Information ${green},${bg}
	face Error default,${red}
	face StatusLine ${cyan},${bg}
	face StatusLineMode ${yellow}+b
	face StatusLineInfo ${orange}
	face StatusLineValue ${red}
	face StatusCursor PrimaryCursor
	face Prompt ${fg1}+b
	face MatchingChar default+b
	face BufferPadding default
    "
}
