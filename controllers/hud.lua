local args = ...
local icon = args.icon

local api = {
    song = {
        nameinst = nil,
        artistnameinst = nil,
        iconinst = nil
    }
}

local cloneref = cloneref or function(obj)
	return obj
end

local Services = setmetatable({}, {
	__index = function(self, obj)
		return cloneref(game:GetService(obj))
	end
})

local Players = Services.Players
local lplr = Players.LocalPlayer

local gethui = get_hidden_ui or gethui or function()
	return (Services.RunService:IsStudio() and lplr.PlayerGui) or cloneref(game:GetService('CoreGui'))
end

local function makeCorner(parent: GuiObject, radius: number)
	local corner = Instance.new('UICorner')
	corner.CornerRadius = UDim.new(0, radius)
	corner.Parent = parent

	return corner
end

local function addPadding(parent: GuiObject, paddingB: number, paddingL: number, paddingR: number, paddingT: number)
	local padding = Instance.new('UIPadding')
	padding.PaddingBottom = UDim.new(0, paddingB)
	padding.PaddingLeft = UDim.new(0, paddingL)
	padding.PaddingRight = UDim.new(0, paddingR)
	padding.PaddingTop = UDim.new(0, paddingT)
	padding.Parent = parent

	return padding
end

do
	local SpotifyHUD = Instance.new('ScreenGui')
	SpotifyHUD.ResetOnSpawn = false
	SpotifyHUD.IgnoreGuiInset = true
	SpotifyHUD.Parent = gethui()

	local Main = Instance.new('Frame')
	Main.AnchorPoint = Vector2.new(0.5, 0.01)
	Main.AutomaticSize = Enum.AutomaticSize.X
	Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	Main.Position = UDim2.fromScale(0.5, 0.01)
	Main.Size = UDim2.fromOffset(220, 60)
	Main.Parent = SpotifyHUD

	makeCorner(Main, 20)

	local MainUILayout = Instance.new('UIListLayout')
	MainUILayout.Padding = UDim.new(0, 0)
	MainUILayout.FillDirection = Enum.FillDirection.Horizontal
	MainUILayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	MainUILayout.VerticalAlignment = Enum.VerticalAlignment.Center
	MainUILayout.SortOrder = Enum.SortOrder.LayoutOrder
	MainUILayout.Parent = Main

	local Container = Instance.new('Frame')
	Container.AutomaticSize = Enum.AutomaticSize.X
	Container.BackgroundTransparency = 1
	Container.Size = UDim2.new(0, 225, 1, 0)
	Container.Parent = Main

	local ContainerUILayout = Instance.new('UIListLayout')
	ContainerUILayout.Padding = UDim.new(0, 0)
	ContainerUILayout.FillDirection = Enum.FillDirection.Horizontal
	ContainerUILayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	ContainerUILayout.VerticalAlignment = Enum.VerticalAlignment.Center
	ContainerUILayout.SortOrder = Enum.SortOrder.LayoutOrder
	ContainerUILayout.Parent = Container

	local SongIcon
	addPadding(Container, 0, icon and 10 or 0, 10, 0)

	if icon then
		SongIcon = Instance.new('ImageLabel')
		SongIcon.BackgroundTransparency = 1
		SongIcon.Size = UDim2.fromOffset(35, 35)
		SongIcon.Image = 'rbxassetid://134476270255159'
		SongIcon.ScaleType = Enum.ScaleType.Fit
		SongIcon.Parent = Container

		makeCorner(SongIcon, 15)
		api.song.iconinst = SongIcon
	end

	do
		local TextContainer = Instance.new('Frame')
		TextContainer.AutomaticSize = Enum.AutomaticSize.X
		TextContainer.BackgroundTransparency = 1
		TextContainer.Size = UDim2.fromScale(0, 1)
		TextContainer.Parent = Container

		local TContainerUILayout = Instance.new('UIListLayout')
		TContainerUILayout.Padding = UDim.new(0, 3)
		TContainerUILayout.FillDirection = Enum.FillDirection.Vertical
		TContainerUILayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
		TContainerUILayout.VerticalAlignment = Enum.VerticalAlignment.Top
		TContainerUILayout.Parent = TextContainer

		addPadding(TextContainer, 0, icon and 10 or 15, 15, 10)

		local SongName = Instance.new('TextLabel')
		SongName.AutomaticSize = Enum.AutomaticSize.X
		SongName.BackgroundTransparency = 1
		SongName.Size = UDim2.fromOffset(150, 25)
		SongName.FontFace = Font.fromName('Montserrat', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
		SongName.Text = 'BROTHER NOAH (Kevin Durrant)'
		SongName.TextColor3 = Color3.fromRGB(255, 255, 255)
		SongName.TextSize = 16
		SongName.TextXAlignment = Enum.TextXAlignment.Left
		SongName.TextYAlignment = Enum.TextYAlignment.Center
		SongName.Parent = TextContainer
		api.song.nameinst = SongName

		local SongArtists = Instance.new('TextLabel')
		SongArtists.AutomaticSize = Enum.AutomaticSize.X
		SongArtists.BackgroundTransparency = 1
		SongArtists.Size = UDim2.fromOffset(100, 0)
		SongArtists.FontFace = Font.fromName('Montserrat', Enum.FontWeight.Medium, Enum.FontStyle.Normal)
		SongArtists.Text = 'Lil Godd, Kid Carrillo'
		SongArtists.TextColor3 = Color3.fromRGB(91, 91, 91)
		SongArtists.TextSize = 12
		SongArtists.TextXAlignment = Enum.TextXAlignment.Left
		SongArtists.TextYAlignment = Enum.TextYAlignment.Center
		SongArtists.Parent = TextContainer
		api.song.artistnameinst = SongArtists
	end

	local ContainerImage = Instance.new('ImageLabel')
	ContainerImage.BackgroundTransparency = 1
	ContainerImage.Size = UDim2.fromOffset(35, 25)
	ContainerImage.Image = 'rbxassetid://11432850205'
	ContainerImage.ImageColor3 = Color3.fromRGB(255, 168, 133)
	ContainerImage.ScaleType = Enum.ScaleType.Fit
	ContainerImage.Parent = Container
end

return api
