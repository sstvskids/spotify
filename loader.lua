local args = ...

assert(args, 'Missing arguments')
assert(args.token, 'Missing spotify token')
if getcustomasset and args.icon == nil then
    args.icon = true
elseif not getcustomasset and args.icon == true or args.icon == nil then
    args.icon = false
end

local hud = loadstring(game:HttpGet('https://raw.githubusercontent.com/sstvskids/spotify/refs/heads/main/controllers/hud.lua'))({
    icon = args.icon
})

local spotify = loadstring(game:HttpGet('https://raw.githubusercontent.com/sstvskids/spotify/refs/heads/main/controllers/spotify.lua'))({
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

            if not isfile('spotify/cache/'..track.title..'_'..track.artists..'_cover.png') then
                writefile('spotify/cache/'..track.title..'_'..track.artists..'_cover.png', game:HttpGet(track.cover))
            end

			hud.song.artistnameinst.Text = track.artists
			hud.song.nameinst.Text = track.title

			if hud.song.iconinst then
				hud.song.iconinst.Image = getcustomasset('spotify/cache/'..track.title..'_'..track.artists..'_cover.png')
			end
        end

        task.wait(5)
    until false
end
