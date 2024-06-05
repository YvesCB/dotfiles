local ns = vim.api.nvim_create_namespace("markdown_format")
local current_marks = {}

--- Helper function to print tables
---
--- @param o table
--- @return string
local function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

--- Find the location of all the words on a line that are surrounded by asterisks
---
--- @param line string
--- @return table
local function find_area_in_asterisks(line)
	local result = {}

	local open = false

	local open_pos = 0
	local close_pos = 0

	for i = 1, #line do
		if string.sub(line, i, i) == "*" then
			if not open then
				open = true
				open_pos = i
			else
				open = false
				close_pos = i
				table.insert(result, { open_pos, close_pos })
			end
		end
	end

	dump(result)

	return result
end

--- Creates a highlight on the character at the given position
---
--- @param area_start integer
--- @param area_end integer
--- @param line_number integer
local function highlight_area_on_line(area_start, area_end, line_number)
	-- TODO: get rid of * chars, only show word
	-- TODO: find out how to do italics
	local highlight = "Conceal"
	local text_to_highlight =
		string.sub(vim.api.nvim_buf_get_lines(0, line_number, line_number + 1, false)[1], area_start + 1, area_end - 1)
	local virtual_text = { { text_to_highlight, highlight } }

	local start_mark = vim.api.nvim_buf_set_extmark(0, ns, line_number, area_start - 1, {
		end_line = line_number,
		end_col = area_start,
		hl_group = "Conceal",
	})

	local end_mark = vim.api.nvim_buf_set_extmark(0, ns, line_number, area_end - 1, {
		end_line = line_number,
		end_col = area_end,
		hl_group = "Conceal",
	})

	current_marks = { start_mark, end_mark }
	-- vim.api.nvim_buf_set_extmark(0, ns, line_number, area_start - 1, {
	-- 	virt_text = virtual_text,
	-- 	virt_text_pos = "overlay",
	-- 	virt_text_hide = true,
	-- })
end

local first_line = vim.api.nvim_buf_get_lines(0, 0, -1, false)[1]
local words_inside_asterisk = find_area_in_asterisks(first_line)

-- TODO: Do this for all lines on the buffer
-- TODO: Redo for current line when user is typing
for _, area in ipairs(words_inside_asterisk) do
	highlight_area_on_line(area[1], area[2], 0)
end
