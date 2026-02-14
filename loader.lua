local args = ...

assert(args, 'Missing arguments')
assert(args.token, 'Missing spotify token')
if getcustomasset and args.icon == nil then
    args.icon = true
elseif not getcustomasset and args.icon == true or args.icon == nil then
    args.icon = false
end

local hud = loadstring(game:HttpGet(''))({
    icon = args.icon
})

local spotify = loadstring(game:HttpGet(''))({
    token = args.token
})

for _, v in {'spotify', 'spotify/cache'} do
    if not isfolder(v) then
        makefolder(v)
    end
end

do
    repeat
        local track = spotify:getTrack()

        if track then
            if track.expired then
                error('Spotify token expired: (rejoin and get a new one)')
            end

            if not isfile('spotify/cache/'..res.title..'_'..res.artists..'_cover.png') then
                writefile('spotify/cache/'..res.title..'_'..res.artists..'_cover.png', game:HttpGet(res.cover))
            end

			api.song.artistnameinst.Text = res.artists
			api.song.nameinst.Text = res.title

			if api.song.iconinst then
				api.song.iconinst.Image = getcustomasset('spotify/cache/'..res.title..'_'..res.artists..'_cover.png')
			end
        end

        task.wait(5)
    until false
end
