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

local update_url = "https://raw.githubusercontent.com/YukiRice/GettoHelper/main/update.ini" -- тут тоже свою ссылку
local update_path = getWorkingDirectory() .. "/update.ini" -- и тут свою ссылку

local script_url = "" -- тут свою ссылку
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

-- Стиль имуги
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
		sampAddChatMessage(tag .. "Скрипт успешно загружен. Автор: Yuki_Rice" , -1)
		sampAddChatMessage(tag .. "Главное меню скрипта: /gh или /govhelper" , -1)
		sampAddChatMessage(tag.. "Играю на сервере Arizona RolePlay Yuma. {FF0000}IP - 185.169.134.107:7777", -1)
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
                sampAddChatMessage(tag.. "Есть обновление! Версия: " .. updateIni.info.vers_text, -1)
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
							sampAddChatMessage(tag.. "Скрипт успешно обновлен!", -1)
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
	imgui.Begin("Government Helper", main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse) -- Начало Имгуи
	imgui.SetCursorPos(imgui.ImVec2(20, 30))
	imgui.Text(u8" Активация скрипта - /gh или /GovHelper ")
	imgui.Separator()
	imgui.Text (u8'Ваш ник: ' .. u8(mainIni.config.name))
	imgui.SameLine()
  imgui.TextQuestion(u8'Используется в разделе "Собеседование"\nИзменить - /setnick')
	imgui.Text (u8'Ваша должность: ' .. u8(mainIni.config.rank))
	imgui.SameLine()
  imgui.TextQuestion(u8'Используется в разделе "Собеседование"\nИзменить - /setrank')
	imgui.Separator()


	imgui.SetCursorPosX((imgui.GetWindowWidth() - 150) / 150) -- Команды скрипта
	if imgui.Button(open_buttons and fa.ICON_SEARCH .. u8' Команды скрипта' or fa.ICON_SEARCH .. u8' Команды скрипта', imgui.ImVec2(325,30)) then
	  open_buttons = not open_buttons
	end

	if open_buttons then
		imgui.Separator()
	  imgui.Text(u8"/givepass - Выдать паспорт человеку")
		imgui.Text(u8"/invite - Принять человека во фракцию")
		imgui.Text(u8"/uninvite - Уволить человека")
		imgui.Text(u8"/fwarn - Выдать выговор")
		imgui.Text(u8"/unfwarn - Снять выговор")
		imgui.Text(u8"/blacklist - Занести человека в чёрный список")
		imgui.Text(u8"/unblacklist - Вынести человека из чёрного списка")
		imgui.Text(u8"/unblacklistoff - Вынести человека из чёрного...")
		imgui.Text(u8"...списка в оффлайне")
		imgui.Text(u8"/fmute - Заглушить человеку рацию (временно)")
		imgui.Text(u8"/funmute - Разглушить человеку рацию")
		imgui.Text(u8"/fmutes - Заглушить человеку рацию на 10 минут")
		imgui.Text(u8"/giverank - Изменить ранг сотрудника")
		imgui.Text(u8"/setnick - Изменить ник в скрипте")
		imgui.Text(u8"/setrank - Изменить должность в скрипте")
		imgui.Separator()
	end -- Команды скрипта

	imgui.SetCursorPosX((imgui.GetWindowWidth() - 150) / 150) -- Собеседование
	if imgui.Button(open_buttons and fa.ICON_MALE .. u8' Собеседование' or fa.ICON_MALE .. u8' Собеседование', imgui.ImVec2(325,30)) then
	  open_sobes = not open_sobes
	end
	if open_sobes then
imgui.Separator()
		imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8"Приветствие").x) / 2)
	  if imgui.Button(u8"Приветствие") then
			lua_thread.create(function()
			sampSendChat("Добрый день! Меня зовут " ..mainIni.config.name.. ".")
			wait(1500)
			sampSendChat("Я действующий " ..mainIni.config.rank.. ".")
			wait(1500)
			sampSendChat("Вы пришли на собеседование?")
		end)
		end

		imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8"Попросить документы").x) / 2)
		if imgui.Button(u8"Попросить документы") then
			lua_thread.create(function()
			sampSendChat("Хорошо, тогда предоставьте Ваши документы.")
			wait(1500)
			sampSendChat("А именно: паспорт, мед.карта и лицензии.")
		end)
		end

		imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8"Вопрос на МГ").x) / 2)
				if imgui.Button(u8"Вопрос на МГ") then
					lua_thread.create(function()
					sampSendChat("Отлично! Ваши документы в порядке.")
					wait(1500)
					sampSendChat("Прошу Вас ответить на пару вопросов.")
					wait(1500)
					sampSendChat("Что такое ПГ?")
				end)
				end

		imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8"Вопрос №2 на МГ").x) / 2)
						if imgui.Button(u8"Вопрос №2 на МГ") then
							lua_thread.create(function()
							sampSendChat("Хорошо.")
							wait(1500)
							sampSendChat("/b что такое МГ и ТК?")
						end)
						end

		imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8"Одобрено").x) / 2)
						if imgui.Button(u8"Одобрено") then
sampAddChatMessage(tag.. "Напишите - /invite [id]", -1)
						end

		imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8"Отклонено").x) / 2)
						if imgui.Button(u8"Отклонено") then
							lua_thread.create(function()
							sampSendChat("К сожалению, но мы должны Вам отказать по некоторым причинам.")
							wait(1500)
							sampSendChat("Приходите на следующее собеседование.")
						end)
						end
imgui.Separator()



	end -- Собеседование

	imgui.SetCursorPosX((imgui.GetWindowWidth() - 150) / 150) -- Начало "Информация"
	if imgui.Button(open_buttons and fa.ICON_INFO_CIRCLE.. u8' Информация' or fa.ICON_INFO_CIRCLE.. u8' Информация', imgui.ImVec2(325,30)) then
	  open_info = not open_info
	end
	if open_info then
	  imgui.Text(u8"Автор скрипта - Yuki_Rice")
			imgui.Text(u8"Связь со мной - ")
			imgui.SameLine()
       imgui.Link('https://vk.com/xkelling','VK')
				imgui.Separator()
					imgui.Text(u8"Версия скрипта - 1.0")
								imgui.Text(u8"Предложения по улучшению скрипта в ЛС ВК.")
	end -- Конец "Информация"
	imgui.End() -- Конец имуги
end

function cmd_givepass(arg)
	var1 = string.match(arg, "(%d+)")
	if var1 == nill or var1 == ""
	then
        sampAddChatMessage(tag .. "Введите: /givepass [id]", -1)
    else
        lua_thread.create(function()
        sampSendChat("/me достал чистый бланк из под стола")
        wait(1400)
        sampSendChat("/me достал ручку и начал заполнять документы")
        wait(1400)
        sampSendChat("/do Бланк документов заполнен.")
        wait(1400)
        sampSendChat("/me положил бланки в папку и передал человеку паспорт")
        wait(1)
        sampSendChat('/givepass ' ..var1) end)
    end
	end


	function cmd_invite(arg)
		var1 = string.match(arg, "(%d+)")
		if var1 == nill or var1 == ""
		then
	        sampAddChatMessage(tag .. "Введите: /invite [id]", -1)
	    else
	        lua_thread.create(function()
	        sampSendChat("/me достал планшет из сумки")
	        wait(1400)
	        sampSendChat("/me включил планшет и зашел в приложение 'Правительство' ")
	        wait(1400)
	        sampSendChat("/me зашел в раздел 'Сотрудники' и нажал на кнопку 'Добавить сотрудника' ")
	        wait(1400)
	        sampSendChat("/do Данные о сотруднике занесены.")
					wait(1400)
		      sampSendChat("/me выключил планшет и убрал его в карман")
					wait(1400)
		      sampSendChat("Поздравляю Вас! Переодеться Вы можете на втором этаже.")
	        wait(1400)
	        sampSendChat('/invite ' ..var1) end)
	    end
		end


		function cmd_uninvite(arg)
				var1, var2 = string.match(arg, "(%d+) (.+)")
				if var1 == nill or var1 == ""
				then
						sampAddChatMessage(tag .. "Введите: /uninvite [id] [Причина]", -1)
				else
						lua_thread.create(function()
						sampSendChat("/me достал планшет из сумки")
						wait(1400)
						sampSendChat("/me включил планшет и зашел в приложение 'Правительство' ")
						wait(1400)
						sampSendChat("/me зашел в раздел 'Сотрудники' и нажал на кнопку 'Удалить сотрудника' ")
						wait(1400)
						sampSendChat("/do Данные о сотруднике удалены.")
						wait(1400)
						sampSendChat("/me выключил планшет и убрал его в карман")
						wait(1400)
						sampSendChat("Извините, но мы не нуждаемся в ваших услугах.")
						wait(1400)
						sampSendChat('/uninvite ' ..var1  ..var2) end)
				end
			end

			function cmd_fwarn(arg)
					var1, var2 = string.match(arg, "(%d+) (.+)")
					if var1 == nill or var1 == ""
					then
							sampAddChatMessage(tag .. "Введите: /fwarn [id] [Причина]", -1)
					else
							lua_thread.create(function()
							sampSendChat("/me достал планшет из сумки")
							wait(1400)
							sampSendChat("/me включил планшет и зашел в приложение 'Правительство' ")
							wait(1400)
							sampSendChat("/me зашел в раздел 'Сотрудники' и нажал на кнопку 'Выдать выговор' ")
							wait(1400)
							sampSendChat("/do Данные о сотруднике изменены.")
							wait(1400)
							sampSendChat("/me выключил планшет и убрал его в карман")
							wait(1400)
							sampSendChat('/fwarn ' ..var1  ..var2) end)
					end
				end

				function cmd_unfwarn(arg)
						var1 = string.match(arg, "(%d+)")
						if var1 == nill or var1 == ""
						then
								sampAddChatMessage(tag .. "Введите: /unfwarn [id]", -1)
						else
								lua_thread.create(function()
								sampSendChat("/me достал планшет из сумки")
								wait(1400)
								sampSendChat("/me включил планшет и зашел в приложение 'Правительство' ")
								wait(1400)
								sampSendChat("/me зашел в раздел 'Сотрудники' и нажал на кнопку 'Снять выговор' ")
								wait(1400)
								sampSendChat("/do Данные о сотруднике изменены.")
								wait(1400)
								sampSendChat("/me выключил планшет и убрал его в карман")
								wait(1400)
								sampSendChat('/unfwarn ' ..var1) end)
						end
					end

					function cmd_blacklist(arg)
							var1, var2 = string.match(arg, "(%d+) (.+)")
							if var1 == nill or var1 == ""
							then
									sampAddChatMessage(tag .. "Введите: /blacklist [id] [Причина]", -1)
							else
									lua_thread.create(function()
									sampSendChat("/me достал планшет из сумки")
									wait(1400)
									sampSendChat("/me включил планшет и зашел в приложение 'Правительство' ")
									wait(1400)
									sampSendChat("/me зашел в раздел 'Чёрный список' и нажал на кнопку 'Добавить человека в список' ")
									wait(1400)
									sampSendChat("/do Данные о человеке добавлены.")
									wait(1400)
									sampSendChat("/me выключил планшет и убрал его в карман")
									wait(1400)
									sampSendChat('/blacklist ' ..var1  ..var2) end)
							end
						end

						function cmd_unblacklist(arg)
								var1 = string.match(arg, "(%d+)")
								if var1 == nill or var1 == ""
								then
										sampAddChatMessage(tag .. "Введите: /unblacklist [id]", -1)
								else
										lua_thread.create(function()
										sampSendChat("/me достал планшет из сумки")
										wait(1400)
										sampSendChat("/me включил планшет и зашел в приложение 'Правительство' ")
										wait(1400)
										sampSendChat("/me зашел в раздел 'Чёрный список' и нажал на кнопку 'Удалить человека из списка' ")
										wait(1400)
										sampSendChat("/do Данные о человеке удалены.")
										wait(1400)
										sampSendChat("/me выключил планшет и убрал его в карман")
										wait(1400)
										sampSendChat('/unblacklist ' ..var1) end)
								end
							end

							function cmd_unblacklistoff(arg)
									var1 = string.match(arg, "(.+)")
									if var1 == nill or var1 == ""
									then
											sampAddChatMessage(tag .. "Введите: /unblacklistoff [name]", -1)
									else
											lua_thread.create(function()
											sampSendChat("/me достал планшет из сумки")
											wait(1400)
											sampSendChat("/me включил планшет и зашел в приложение 'Правительство' ")
											wait(1400)
											sampSendChat("/me зашел в раздел 'Чёрный список' и нажал на кнопку 'Удалить человека из списка' ")
											wait(1400)
											sampSendChat("/do Данные о человеке удалены.")
											wait(1400)
											sampSendChat("/me выключил планшет и убрал его в карман")
											wait(1400)
											sampSendChat('/unblacklistoff ' ..var1) end)
									end
								end

								function cmd_fmute(arg)
										var1, var2 = string.match(arg, "(%d+) (.+)")
										if var1 == nill or var1 == ""
										then
												sampAddChatMessage(tag .. "Введите: /fmute [id] [Причина]", -1)
										else
												lua_thread.create(function()
												sampSendChat("/me достал планшет из сумки")
												wait(1400)
												sampSendChat("/me включил планшет и зашел в приложение 'Правительство' ")
												wait(1400)
												sampSendChat("/me зашел в раздел 'Рации сотрудников' и нажал на кнопку 'Выключить рацию сотруднику' ")
												wait(1400)
												sampSendChat("/do Данные о рации сотрудника были изменены.")
												wait(1400)
												sampSendChat("/me выключил планшет и убрал его в карман")
												wait(1400)
												sampSendChat('/fmute ' ..var1  ..var2) end)
										end
									end

									function cmd_funmute(arg)
											var1 = string.match(arg, "(%d+)")
											if var1 == nill or var1 == ""
											then
													sampAddChatMessage(tag .. "Введите: /funmute [id]", -1)
											else
													lua_thread.create(function()
													sampSendChat("/me достал планшет из сумки")
													wait(1400)
													sampSendChat("/me включил планшет и зашел в приложение 'Правительство' ")
													wait(1400)
													sampSendChat("/me зашел в раздел 'Рации сотрудников' и нажал на кнопку 'Включить рацию сотруднику' ")
													wait(1400)
													sampSendChat("/do Данные о рации сотрудника были изменены.")
													wait(1400)
													sampSendChat("/me выключил планшет и убрал его в карман")
													wait(1400)
													sampSendChat('/funmute ' ..var1) end)
											end
										end

										function cmd_fmutes(arg)
												var1 = string.match(arg, "(%d+)")
												if var1 == nill or var1 == ""
												then
														sampAddChatMessage(tag .. "Введите: /fmutes [id]", -1)
												else
														lua_thread.create(function()
														sampSendChat("/me достал планшет из сумки")
														wait(1400)
														sampSendChat("/me включил планшет и зашел в приложение 'Правительство' ")
														wait(1400)
														sampSendChat("/me зашел в раздел 'Рации сотрудников' и нажал на кнопку 'Выключить рацию сотруднику' ")
														wait(1400)
														sampSendChat("/do Данные о рации сотрудника были изменены.")
														wait(1400)
														sampSendChat("/me выключил планшет и убрал его в карман")
														wait(1400)
														sampSendChat('/fmutes ' ..var1) end)
												end
											end

											function cmd_giverank(arg)
													var1, var2 = string.match(arg, "(%d+) (%d+)")
													if var1 == nill or var1 == ""
													then
															sampAddChatMessage(tag .. "Введите: /giverank [id] [Номер ранга]", -1)
													else
															lua_thread.create(function()
															sampSendChat("/me достал планшет из сумки")
															wait(1400)
															sampSendChat("/me включил планшет и зашел в приложение 'Правительство' ")
															wait(1400)
															sampSendChat("/me зашел в раздел 'Сотрудники' и нажал на кнопку 'Должности' ")
															wait(1400)
															sampSendChat("/me изменил данные о сотруднике")
															wait(1400)
															sampSendChat("/do Данные о должности сотрудника были изменены.")
															wait(1400)
															sampSendChat("/me выключил планшет и убрал его в карман")
															wait(1400)
															sampSendChat('/giverank ' ..var1  ..var2) end)
													end
												end


function cmd_setnick(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "Введите: /setnick [name] (Пример - Юки Райс)", -1)
	else
mainIni.config.name = arg
if inicfg.save(mainIni, directIni) then
		sampAddChatMessage(tag.. "Вы успешно изменили свой ник в скрипте!", -1)
				sampAddChatMessage(tag.. "Ваш новый ник - {ADFF2F}" ..mainIni.config.name, -1)
end
end
end

function cmd_setrank(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "Введите: /setrank [Название] (Пример - Губернатор)", -1)
	else
mainIni.config.rank = arg
if inicfg.save(mainIni, directIni) then
		sampAddChatMessage(tag.. "Вы успешно изменили свою должность в скрипте!", -1)
				sampAddChatMessage(tag.. "Ваша новая должность - {ADFF2F}" ..mainIni.config.rank, -1)
end
end
end
