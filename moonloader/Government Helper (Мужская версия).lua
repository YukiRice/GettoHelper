script_name('Government Helper')
script_author('VK - @xkelling')


require "lib.moonloader"
local dlstatus = require('moonloader').download_status
local keys = require "vkeys"
local sampev = require 'lib.samp.events'
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

local script_vers = 2
local script_vers_text = "1.1"

local update_url = "https://raw.githubusercontent.com/YukiRice/GettoHelper/main/update.ini" -- ��� ���� ���� ������
local update_path = getWorkingDirectory() .. "/update.ini" -- � ��� ���� ������

local script_url = "" -- ��� ���� ������
local script_path = thisScript().path

local main_window_state = imgui.ImBool(false)
local sw, sh = getScreenResolution()
local themes = import "resource/imgui_themes.lua"
local open_buttons = false
local open_info = false
local open_sobes = false

local inicfg = require 'inicfg'
local directIni = "moonloader\\config\\GovHelper.ini"

local mainIni = inicfg.load(nil, directIni)

if not doesFileExist("moonloader/config/GovHelper.ini") then
inicfg.save(mainIni, "GovHelper.ini") end

local fa = require 'faIcons'
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig() -- to use 'imgui.ImFontConfig.new()' on error
        font_config.MergeMode = true
        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fontawesome-webfont.ttf', 14.0, font_config, fa_glyph_ranges)
    end
end

local tag = "{ADFF2F}[GH]{FFFFFF} "
local main_color_text = "{ADFF2F}"
local white_color = "{FFFFFF}"

-- ����� �����
imgui.SwitchContext()
local style = imgui.GetStyle()
local colors = style.Colors
local clr = imgui.Col
local ImVec4 = imgui.ImVec4

style.WindowRounding = 2.0
style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
style.ChildWindowRounding = 2.0
style.FrameRounding = 2.0
style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
style.ScrollbarSize = 13.0
style.ScrollbarRounding = 0
style.GrabMinSize = 8.0
style.GrabRounding = 1.0

colors[clr.FrameBg]                = ImVec4(0.42, 0.48, 0.16, 0.54)
colors[clr.FrameBgHovered]         = ImVec4(0.85, 0.98, 0.26, 0.40)
colors[clr.FrameBgActive]          = ImVec4(0.85, 0.98, 0.26, 0.67)
colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
colors[clr.TitleBgActive]          = ImVec4(0.42, 0.48, 0.16, 1.00)
colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
colors[clr.CheckMark]              = ImVec4(0.85, 0.98, 0.26, 1.00)
colors[clr.SliderGrab]             = ImVec4(0.77, 0.88, 0.24, 1.00)
colors[clr.SliderGrabActive]       = ImVec4(0.85, 0.98, 0.26, 1.00)
colors[clr.Button]                 = ImVec4(0.85, 0.98, 0.26, 0.40)
colors[clr.ButtonHovered]          = ImVec4(0.85, 0.98, 0.26, 1.00)
colors[clr.ButtonActive]           = ImVec4(0.82, 0.98, 0.06, 1.00)
colors[clr.Header]                 = ImVec4(0.85, 0.98, 0.26, 0.31)
colors[clr.HeaderHovered]          = ImVec4(0.85, 0.98, 0.26, 0.80)
colors[clr.HeaderActive]           = ImVec4(0.85, 0.98, 0.26, 1.00)
colors[clr.Separator]              = colors[clr.Border]
colors[clr.SeparatorHovered]       = ImVec4(0.63, 0.75, 0.10, 0.78)
colors[clr.SeparatorActive]        = ImVec4(0.63, 0.75, 0.10, 1.00)
colors[clr.ResizeGrip]             = ImVec4(0.85, 0.98, 0.26, 0.25)
colors[clr.ResizeGripHovered]      = ImVec4(0.85, 0.98, 0.26, 0.67)
colors[clr.ResizeGripActive]       = ImVec4(0.85, 0.98, 0.26, 0.95)
colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.81, 0.35, 1.00)
colors[clr.TextSelectedBg]         = ImVec4(0.85, 0.98, 0.26, 0.35)
colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
colors[clr.ComboBg]                = colors[clr.PopupBg]
colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)

function imgui.Link(link)
    if status_hovered then
        local p = imgui.GetCursorScreenPos()
        imgui.TextColored(imgui.ImVec4(0, 0.5, 1, 1), link)
        imgui.GetWindowDrawList():AddLine(imgui.ImVec2(p.x, p.y + imgui.CalcTextSize(link).y), imgui.ImVec2(p.x + imgui.CalcTextSize(link).x, p.y + imgui.CalcTextSize(link).y), imgui.GetColorU32(imgui.ImVec4(0, 0.5, 1, 1)))
    else
        imgui.TextColored(imgui.ImVec4(0, 0.3, 0.8, 1), link)
    end
    if imgui.IsItemClicked() then os.execute('explorer '..link)
    elseif imgui.IsItemHovered() then
        status_hovered = true else status_hovered = false
    end
end

function imgui.TextQuestion(text)
    imgui.TextDisabled('(?)')
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.PushTextWrapPos(450)
        imgui.TextUnformatted(text)
        imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end


function main()
if not isSampfuncsLoaded() or not isSampLoaded() then return end
while not isSampAvailable() do wait(100) end
		sampAddChatMessage(tag .. "������ ������� ��������. �����: Yuki_Rice" , -1)
		sampAddChatMessage(tag .. "������� ���� �������: /gh ��� /govhelper" , -1)
		sampAddChatMessage(tag.. "����� �� ������� Arizona RolePlay Yuma. {FF0000}IP - 185.169.134.107:7777", -1)
		sampfuncsLog(tag .. "Loaded!")
		sampRegisterChatCommand("gh", cmd_gh)
		sampRegisterChatCommand("GovHelper", cmd_gh)
		sampRegisterChatCommand("givepass", cmd_givepass)
		sampRegisterChatCommand("invite", cmd_invite)
		sampRegisterChatCommand("uninvite", cmd_uninvite)
		sampRegisterChatCommand("fwarn", cmd_fwarn)
		sampRegisterChatCommand("unfwarn", cmd_unfwarn)
		sampRegisterChatCommand("blacklist", cmd_blacklist)
		sampRegisterChatCommand("unblacklist", cmd_unblacklist)
		sampRegisterChatCommand("unblacklistoff", cmd_unblacklistoff)
		sampRegisterChatCommand("fmute", cmd_fmute)
		sampRegisterChatCommand("funmute", cmd_funmute)
		sampRegisterChatCommand("fmutes", cmd_fmutes)
		sampRegisterChatCommand("giverank", cmd_giverank)
	  sampRegisterChatCommand("setnick", cmd_setnick)
		sampRegisterChatCommand("setrank", cmd_setrank)
    imgui.Process = false

		downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage(tag.. "���� ����������! ������: " .. updateIni.info.vers_text, -1)
                update_state = true
            end
            os.remove(update_path)
        end
    end)

while true do
wait(0)
if main_window_state.v == false then
	imgui.Process = false

	if update_state then
			downloadUrlToFile(script_url, script_path, function(id, status)
					if status == dlstatus.STATUS_ENDDOWNLOADDATA then
							sampAddChatMessage(tag.. "������ ������� ��������!", -1)
							thisScript():reload()
					end
			end)
			break
end
end
end
end

function cmd_gh(arg)
	main_window_state.v = not main_window_state.v
	imgui.Process = main_window_state.v
end

function imgui.OnDrawFrame()
	imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(330, 350), imgui.Cond.FirstUseEver)
	imgui.Begin("Government Helper", main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse) -- ������ �����
	imgui.SetCursorPos(imgui.ImVec2(20, 30))
	imgui.Text(u8" ��������� ������� - /gh ��� /GovHelper ")
	imgui.Separator()
	imgui.Text (u8'��� ���: ' .. u8(mainIni.config.name))
	imgui.SameLine()
  imgui.TextQuestion(u8'������������ � ������� "�������������"\n�������� - /setnick')
	imgui.Text (u8'���� ���������: ' .. u8(mainIni.config.rank))
	imgui.SameLine()
  imgui.TextQuestion(u8'������������ � ������� "�������������"\n�������� - /setrank')
	imgui.Separator()


	imgui.SetCursorPosX((imgui.GetWindowWidth() - 150) / 150) -- ������� �������
	if imgui.Button(open_buttons and fa.ICON_SEARCH .. u8' ������� �������' or fa.ICON_SEARCH .. u8' ������� �������', imgui.ImVec2(325,30)) then
	  open_buttons = not open_buttons
	end

	if open_buttons then
		imgui.Separator()
	  imgui.Text(u8"/givepass - ������ ������� ��������")
		imgui.Text(u8"/invite - ������� �������� �� �������")
		imgui.Text(u8"/uninvite - ������� ��������")
		imgui.Text(u8"/fwarn - ������ �������")
		imgui.Text(u8"/unfwarn - ����� �������")
		imgui.Text(u8"/blacklist - ������� �������� � ������ ������")
		imgui.Text(u8"/unblacklist - ������� �������� �� ������� ������")
		imgui.Text(u8"/unblacklistoff - ������� �������� �� �������...")
		imgui.Text(u8"...������ � ��������")
		imgui.Text(u8"/fmute - ��������� �������� ����� (��������)")
		imgui.Text(u8"/funmute - ���������� �������� �����")
		imgui.Text(u8"/fmutes - ��������� �������� ����� �� 10 �����")
		imgui.Text(u8"/giverank - �������� ���� ����������")
		imgui.Text(u8"/setnick - �������� ��� � �������")
		imgui.Text(u8"/setrank - �������� ��������� � �������")
		imgui.Separator()
	end -- ������� �������

	imgui.SetCursorPosX((imgui.GetWindowWidth() - 150) / 150) -- �������������
	if imgui.Button(open_buttons and fa.ICON_MALE .. u8' �������������' or fa.ICON_MALE .. u8' �������������', imgui.ImVec2(325,30)) then
	  open_sobes = not open_sobes
	end
	if open_sobes then
imgui.Separator()
		imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8"�����������").x) / 2)
	  if imgui.Button(u8"�����������") then
			lua_thread.create(function()
			sampSendChat("������ ����! ���� ����� " ..mainIni.config.name.. ".")
			wait(1500)
			sampSendChat("� ����������� " ..mainIni.config.rank.. ".")
			wait(1500)
			sampSendChat("�� ������ �� �������������?")
		end)
		end

		imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8"��������� ���������").x) / 2)
		if imgui.Button(u8"��������� ���������") then
			lua_thread.create(function()
			sampSendChat("������, ����� ������������ ���� ���������.")
			wait(1500)
			sampSendChat("� ������: �������, ���.����� � ��������.")
		end)
		end

		imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8"������ �� ��").x) / 2)
				if imgui.Button(u8"������ �� ��") then
					lua_thread.create(function()
					sampSendChat("�������! ���� ��������� � �������.")
					wait(1500)
					sampSendChat("����� ��� �������� �� ���� ��������.")
					wait(1500)
					sampSendChat("��� ����� ��?")
				end)
				end

		imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8"������ �2 �� ��").x) / 2)
						if imgui.Button(u8"������ �2 �� ��") then
							lua_thread.create(function()
							sampSendChat("������.")
							wait(1500)
							sampSendChat("/b ��� ����� �� � ��?")
						end)
						end

		imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8"��������").x) / 2)
						if imgui.Button(u8"��������") then
sampAddChatMessage(tag.. "�������� - /invite [id]", -1)
						end

		imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8"���������").x) / 2)
						if imgui.Button(u8"���������") then
							lua_thread.create(function()
							sampSendChat("� ���������, �� �� ������ ��� �������� �� ��������� ��������.")
							wait(1500)
							sampSendChat("��������� �� ��������� �������������.")
						end)
						end
imgui.Separator()



	end -- �������������

	imgui.SetCursorPosX((imgui.GetWindowWidth() - 150) / 150) -- ������ "����������"
	if imgui.Button(open_buttons and fa.ICON_INFO_CIRCLE.. u8' ����������' or fa.ICON_INFO_CIRCLE.. u8' ����������', imgui.ImVec2(325,30)) then
	  open_info = not open_info
	end
	if open_info then
	  imgui.Text(u8"����� ������� - Yuki_Rice")
			imgui.Text(u8"����� �� ���� - ")
			imgui.SameLine()
       imgui.Link('https://vk.com/xkelling','VK')
				imgui.Separator()
					imgui.Text(u8"������ ������� - 1.0")
								imgui.Text(u8"����������� �� ��������� ������� � �� ��.")
	end -- ����� "����������"
	imgui.End() -- ����� �����
end

function cmd_givepass(arg)
	var1 = string.match(arg, "(%d+)")
	if var1 == nill or var1 == ""
	then
        sampAddChatMessage(tag .. "�������: /givepass [id]", -1)
    else
        lua_thread.create(function()
        sampSendChat("/me ������ ������ ����� �� ��� �����")
        wait(1400)
        sampSendChat("/me ������ ����� � ����� ��������� ���������")
        wait(1400)
        sampSendChat("/do ����� ���������� ��������.")
        wait(1400)
        sampSendChat("/me ������� ������ � ����� � ������� �������� �������")
        wait(1)
        sampSendChat('/givepass ' ..var1) end)
    end
	end


	function cmd_invite(arg)
		var1 = string.match(arg, "(%d+)")
		if var1 == nill or var1 == ""
		then
	        sampAddChatMessage(tag .. "�������: /invite [id]", -1)
	    else
	        lua_thread.create(function()
	        sampSendChat("/me ������ ������� �� �����")
	        wait(1400)
	        sampSendChat("/me ������� ������� � ����� � ���������� '�������������' ")
	        wait(1400)
	        sampSendChat("/me ����� � ������ '����������' � ����� �� ������ '�������� ����������' ")
	        wait(1400)
	        sampSendChat("/do ������ � ���������� ��������.")
					wait(1400)
		      sampSendChat("/me �������� ������� � ����� ��� � ������")
					wait(1400)
		      sampSendChat("���������� ���! ����������� �� ������ �� ������ �����.")
	        wait(1400)
	        sampSendChat('/invite ' ..var1) end)
	    end
		end


		function cmd_uninvite(arg)
				var1, var2 = string.match(arg, "(%d+) (.+)")
				if var1 == nill or var1 == ""
				then
						sampAddChatMessage(tag .. "�������: /uninvite [id] [�������]", -1)
				else
						lua_thread.create(function()
						sampSendChat("/me ������ ������� �� �����")
						wait(1400)
						sampSendChat("/me ������� ������� � ����� � ���������� '�������������' ")
						wait(1400)
						sampSendChat("/me ����� � ������ '����������' � ����� �� ������ '������� ����������' ")
						wait(1400)
						sampSendChat("/do ������ � ���������� �������.")
						wait(1400)
						sampSendChat("/me �������� ������� � ����� ��� � ������")
						wait(1400)
						sampSendChat("��������, �� �� �� ��������� � ����� �������.")
						wait(1400)
						sampSendChat('/uninvite ' ..var1  ..var2) end)
				end
			end

			function cmd_fwarn(arg)
					var1, var2 = string.match(arg, "(%d+) (.+)")
					if var1 == nill or var1 == ""
					then
							sampAddChatMessage(tag .. "�������: /fwarn [id] [�������]", -1)
					else
							lua_thread.create(function()
							sampSendChat("/me ������ ������� �� �����")
							wait(1400)
							sampSendChat("/me ������� ������� � ����� � ���������� '�������������' ")
							wait(1400)
							sampSendChat("/me ����� � ������ '����������' � ����� �� ������ '������ �������' ")
							wait(1400)
							sampSendChat("/do ������ � ���������� ��������.")
							wait(1400)
							sampSendChat("/me �������� ������� � ����� ��� � ������")
							wait(1400)
							sampSendChat('/fwarn ' ..var1  ..var2) end)
					end
				end

				function cmd_unfwarn(arg)
						var1 = string.match(arg, "(%d+)")
						if var1 == nill or var1 == ""
						then
								sampAddChatMessage(tag .. "�������: /unfwarn [id]", -1)
						else
								lua_thread.create(function()
								sampSendChat("/me ������ ������� �� �����")
								wait(1400)
								sampSendChat("/me ������� ������� � ����� � ���������� '�������������' ")
								wait(1400)
								sampSendChat("/me ����� � ������ '����������' � ����� �� ������ '����� �������' ")
								wait(1400)
								sampSendChat("/do ������ � ���������� ��������.")
								wait(1400)
								sampSendChat("/me �������� ������� � ����� ��� � ������")
								wait(1400)
								sampSendChat('/unfwarn ' ..var1) end)
						end
					end

					function cmd_blacklist(arg)
							var1, var2 = string.match(arg, "(%d+) (.+)")
							if var1 == nill or var1 == ""
							then
									sampAddChatMessage(tag .. "�������: /blacklist [id] [�������]", -1)
							else
									lua_thread.create(function()
									sampSendChat("/me ������ ������� �� �����")
									wait(1400)
									sampSendChat("/me ������� ������� � ����� � ���������� '�������������' ")
									wait(1400)
									sampSendChat("/me ����� � ������ '׸���� ������' � ����� �� ������ '�������� �������� � ������' ")
									wait(1400)
									sampSendChat("/do ������ � �������� ���������.")
									wait(1400)
									sampSendChat("/me �������� ������� � ����� ��� � ������")
									wait(1400)
									sampSendChat('/blacklist ' ..var1  ..var2) end)
							end
						end

						function cmd_unblacklist(arg)
								var1 = string.match(arg, "(%d+)")
								if var1 == nill or var1 == ""
								then
										sampAddChatMessage(tag .. "�������: /unblacklist [id]", -1)
								else
										lua_thread.create(function()
										sampSendChat("/me ������ ������� �� �����")
										wait(1400)
										sampSendChat("/me ������� ������� � ����� � ���������� '�������������' ")
										wait(1400)
										sampSendChat("/me ����� � ������ '׸���� ������' � ����� �� ������ '������� �������� �� ������' ")
										wait(1400)
										sampSendChat("/do ������ � �������� �������.")
										wait(1400)
										sampSendChat("/me �������� ������� � ����� ��� � ������")
										wait(1400)
										sampSendChat('/unblacklist ' ..var1) end)
								end
							end

							function cmd_unblacklistoff(arg)
									var1 = string.match(arg, "(.+)")
									if var1 == nill or var1 == ""
									then
											sampAddChatMessage(tag .. "�������: /unblacklistoff [name]", -1)
									else
											lua_thread.create(function()
											sampSendChat("/me ������ ������� �� �����")
											wait(1400)
											sampSendChat("/me ������� ������� � ����� � ���������� '�������������' ")
											wait(1400)
											sampSendChat("/me ����� � ������ '׸���� ������' � ����� �� ������ '������� �������� �� ������' ")
											wait(1400)
											sampSendChat("/do ������ � �������� �������.")
											wait(1400)
											sampSendChat("/me �������� ������� � ����� ��� � ������")
											wait(1400)
											sampSendChat('/unblacklistoff ' ..var1) end)
									end
								end

								function cmd_fmute(arg)
										var1, var2 = string.match(arg, "(%d+) (.+)")
										if var1 == nill or var1 == ""
										then
												sampAddChatMessage(tag .. "�������: /fmute [id] [�������]", -1)
										else
												lua_thread.create(function()
												sampSendChat("/me ������ ������� �� �����")
												wait(1400)
												sampSendChat("/me ������� ������� � ����� � ���������� '�������������' ")
												wait(1400)
												sampSendChat("/me ����� � ������ '����� �����������' � ����� �� ������ '��������� ����� ����������' ")
												wait(1400)
												sampSendChat("/do ������ � ����� ���������� ���� ��������.")
												wait(1400)
												sampSendChat("/me �������� ������� � ����� ��� � ������")
												wait(1400)
												sampSendChat('/fmute ' ..var1  ..var2) end)
										end
									end

									function cmd_funmute(arg)
											var1 = string.match(arg, "(%d+)")
											if var1 == nill or var1 == ""
											then
													sampAddChatMessage(tag .. "�������: /funmute [id]", -1)
											else
													lua_thread.create(function()
													sampSendChat("/me ������ ������� �� �����")
													wait(1400)
													sampSendChat("/me ������� ������� � ����� � ���������� '�������������' ")
													wait(1400)
													sampSendChat("/me ����� � ������ '����� �����������' � ����� �� ������ '�������� ����� ����������' ")
													wait(1400)
													sampSendChat("/do ������ � ����� ���������� ���� ��������.")
													wait(1400)
													sampSendChat("/me �������� ������� � ����� ��� � ������")
													wait(1400)
													sampSendChat('/funmute ' ..var1) end)
											end
										end

										function cmd_fmutes(arg)
												var1 = string.match(arg, "(%d+)")
												if var1 == nill or var1 == ""
												then
														sampAddChatMessage(tag .. "�������: /fmutes [id]", -1)
												else
														lua_thread.create(function()
														sampSendChat("/me ������ ������� �� �����")
														wait(1400)
														sampSendChat("/me ������� ������� � ����� � ���������� '�������������' ")
														wait(1400)
														sampSendChat("/me ����� � ������ '����� �����������' � ����� �� ������ '��������� ����� ����������' ")
														wait(1400)
														sampSendChat("/do ������ � ����� ���������� ���� ��������.")
														wait(1400)
														sampSendChat("/me �������� ������� � ����� ��� � ������")
														wait(1400)
														sampSendChat('/fmutes ' ..var1) end)
												end
											end

											function cmd_giverank(arg)
													var1, var2 = string.match(arg, "(%d+) (%d+)")
													if var1 == nill or var1 == ""
													then
															sampAddChatMessage(tag .. "�������: /giverank [id] [����� �����]", -1)
													else
															lua_thread.create(function()
															sampSendChat("/me ������ ������� �� �����")
															wait(1400)
															sampSendChat("/me ������� ������� � ����� � ���������� '�������������' ")
															wait(1400)
															sampSendChat("/me ����� � ������ '����������' � ����� �� ������ '���������' ")
															wait(1400)
															sampSendChat("/me ������� ������ � ����������")
															wait(1400)
															sampSendChat("/do ������ � ��������� ���������� ���� ��������.")
															wait(1400)
															sampSendChat("/me �������� ������� � ����� ��� � ������")
															wait(1400)
															sampSendChat('/giverank ' ..var1  ..var2) end)
													end
												end


function cmd_setnick(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "�������: /setnick [name] (������ - ��� ����)", -1)
	else
mainIni.config.name = arg
if inicfg.save(mainIni, directIni) then
		sampAddChatMessage(tag.. "�� ������� �������� ���� ��� � �������!", -1)
				sampAddChatMessage(tag.. "��� ����� ��� - {ADFF2F}" ..mainIni.config.name, -1)
end
end
end

function cmd_setrank(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "�������: /setrank [��������] (������ - ����������)", -1)
	else
mainIni.config.rank = arg
if inicfg.save(mainIni, directIni) then
		sampAddChatMessage(tag.. "�� ������� �������� ���� ��������� � �������!", -1)
				sampAddChatMessage(tag.. "���� ����� ��������� - {ADFF2F}" ..mainIni.config.rank, -1)
end
end
end
