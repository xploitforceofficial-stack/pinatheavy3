--[[ 
    PinatHub Stealth Loader - Ultra Stable
    Fix: Silent Crash & No Log Issue
]]

local _game = game
local _hget = _game.HttpGet
local _lstr = loadstring
local _pcall = pcall

-- 1. DATA ENKRIPSI
local _0x_k = 7 
local _0x_d = {
    115,118,104,107,122,123,121,112,117,110,47,110,104,110,108,65,79,123,123,119,78,108,123,47,41,111,123,123,119,122,65,54,54,119,112,117,104,123,115,104,104,125,128,50,115,118,104,111,108,121,53,125,108,121,106,108,115,51,104,119,119,54,104,119,112,54,115,118,104,111,108,121,41,48,48,47,48
}

-- 2. DECODER SEDERHANA (Mencegah Silent Error)
local function _0x_dec(_0x_t, _0x_key)
    local _0x_res = ""
    for i = 1, #_0x_t do
        _0x_res = _0x_res .. string.char(_0x_t[i] - _0x_key)
    end
    return _0x_res
end

-- 3. EKSEKUSI UTAMA
local function _0x_exec()
    local _0x_url = _0x_dec(_0x_d, _0x_k)
    -- Bersihkan karakter aneh
    _0x_url = _0x_url:gsub('["\']', "") 

    -- Gunakan pcall hanya pada proses yang berisiko
    local success, content = _pcall(function()
        return _hget(_game, _0x_url)
    end)

    if success and content and #content > 0 then
        local func, parseErr = _lstr(content)
        if func then
            -- Jalankan script utama
            task.spawn(func)
        else
            warn("PinatHub: Gagal memuat script utama -> " .. tostring(parseErr))
        end
    else
        -- Failsafe ke Backup jika Vercel error/403
        local backup_url = "https://raw.githubusercontent.com/xploitforceofficial-stack/pinatpublicloader/refs/heads/main/pinatloader.lua"
        local b_success, b_content = _pcall(function() return _hget(_game, backup_url) end)
        
        if b_success and b_content then
            local b_func = _lstr(b_content)
            if b_func then task.spawn(b_func) end
        else
            print("PinatHub: Semua koneksi gagal. Periksa jaringan kamu.")
        end
    end
end

-- Jalankan
_0x_exec()
