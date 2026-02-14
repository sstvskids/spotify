local spotify = {}

local args = ...
local token = args.token

local request = request or http.request or syn.request

do
    local suc, res = pcall(function()
    	return request({
    		Url = 'https://api.spotify.com/v1/me/player',
    		Method = 'GET',
    		Headers = {
    			Accept = 'application/json',
    			Authorization = 'Bearer '..token
    		}
    	})
    end)

    if not suc or not res.StatusCode == 200 then
        return error('Failed to fetch Spotify data (invalid token?)')
    end
end

do
    function spotify:getTrack()
        local suc, res = pcall(function()
			return request({
				Url = 'https://api.spotify.com/v1/me/player/',
				Method = 'GET',
				Headers = {
					Accept = 'application/json',
					Authorization = 'Bearer '..token
				}
			})
		end)

		if suc and res.StatusCode == 200 then
			local data, artist = httpService:JSONDecode(res.Body), ''

			if data and data.item then
				for i, v in data.item.artists do
					artist = artist .. v.name

					if i < #data.item.artists then
						artist = artist .. ', '
					end
				end

				return {
					title = data.item.name,
					artists = artist,
					cover = data.item.album.images[1].url,
					isPlaying = data.is_playing,
					expired = false
				}
			end

			return {expired = true}
		end

		return {expired = true}, error('Failed to fetch track info: function (getTrackInfo)')
    end
end

return spotify
