local switch_words = {
    { 'true', 'false' },
    { 'on', 'off' },
    { 'yes', 'no' },
    { 'enable', 'disable' },
    { 'todo', 'done' },
    { '+', '-' },
    { '>', '<' },
    { '==', '!=' },
}

local push_words = {}

for _, value in ipairs(switch_words) do
    local w1, w2 = value[1], value[2]
    -- lower
    table.insert(push_words, value)
    -- upper
    table.insert(push_words, {string.upper(w1), string.upper(w2)})
    -- capitalize
    w1, _ = string.gsub(w1, '^%l', string.upper)
    w2, _ = string.gsub(w2, '^%l', string.upper)
    table.insert(push_words, {w1, w2})
end

vim.g.switch_custom_definitions = push_words
