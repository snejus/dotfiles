require 'cairo'

conky_start = 1
processor = ''
distribution = ''
mounted_media = ''
topprocesses = ''
cpus = -1
ncpu = 0
cpu_temp_file = ''
active_network_interface = false
fan = -1
fan_files = {}
fan_rpms = {}
ctemp = 0
start_flag = 1
cpu_min_freq = {}
cpu_max_freq = {}

cpu_temp_update_freq = 4

-- Configs
ENABLE_COLORS = true
COLOR_SHUFFLE = 1

_COLORS = {"#f1c40f", "#884ea0", "#3498db", "#2ecc71", "#ec7063", "#82e0aa", "#C41CB8", "#EDEA29"}
COLORS = {"#ffffff"}

_TOP_COLORS = {"#f3d346","#f4bb2f","#f3a422","#f18f1a","#f1721a","#f1441a"}
_TOP_COLORS_SIZE = 6

RED_START = 0x44
RED_END = 0xff
GREEN_START = 0xFF
GREEN_END = 0x00

-- Conky main function
function conky_main()
    if conky_window == nil then
        return
    end
    local cs = cairo_xlib_surface_create(conky_window.display,
                                         conky_window.drawable,
                                         conky_window.visual,
                                         conky_window.width,
                                         conky_window.height)
    cr = cairo_create(cs)
    
    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr=nil
    if start_flag == 1 then
        local file = io.popen("lscpu -a -p='cpu' | tail -n 1")
        ncpu = trim(file:read("*a"))
        file:close()
        if COLOR_SHUFFLE and ENABLE_COLORS then
            COLORS = shuffle(_COLORS)
        end
        start_flag = 0
    end
end

-- Returns processor name
function conky_processor()
    if processor == '' then
        local file = io.popen("lscpu | grep -Po '(?<=Model name:)(.*)'")
        processor = trim(file:read("*a"))
        file:close()
    end

    return processor
end

-- Returns distribution name
function conky_distribution()
    if distribution == '' then
        local file = io.popen('cat /etc/lsb-release | grep -Po --regexp "(?<=DISTRIB_ID=).*$"')
        distribution = trim(file:read("*a"))
        file = io.popen('cat /etc/lsb-release | grep -Po --regexp "(?<=DISTRIB_RELEASE=).*$"')
        distribution = distribution .. " " .. trim(file:read("*a"))
        file:close()
    end

    return distribution
end

-- Draws max n mounted partitions and its stats
function conky_mountmedia(n)
    if tonumber(conky_parse("$updates")) % 4 == 0 then
        local file = io.popen('lsblk | grep -oE ".*sd.* part /.*" | grep -oE "(/.*)"')
        local count = 1
        local media = ''
        for line in file:lines() do
            local short_name = string.sub(string.sub(trim(line), string.find(trim(line), '/[^/]*$')), 1)
            if count <= tonumber(n) then
                media = media
                        .. "${goto 10}" .. "${color ".. COLORS[(count % table.getn(COLORS))+1] .."}" .. short_name .. "${goto  150}${fs_bar 7,70 " .. trim(line)
                        .. "}${goto 255}${fs_used " .. trim(line) .. "}/${fs_size " .. trim(line) .. "}" .. "$color"
                        .. "\n"
            else
                break
            end
            count = count + 1
        end
        file:close()
        mounted_media = media
        return media
    end 
        return mounted_media
end

-- Draws all cpu cores stats
function conky_drawcpus()
    if cpus == -1 or tonumber(conky_parse("$updates")) % 2 == 0 then
        -- local file = io.popen("lscpu -a -p='cpu' | tail -n 1")
        -- local ncpu = trim(file:read("*a"))
        -- file:close()
        local conky_cpus = ''
        for c = 1, tonumber(ncpu)  do
            if c % 2 ~= 0 then
                conky_cpus = conky_cpus
                             .. "${goto 20}${color ".. (ENABLE_COLORS and get_color_freq_cpu(c-1) or "#FFFFFF").."}" .. c ..": ${goto 42}${cpu cpu".. c
                             .."}%${goto 90}${cpubar 7,30 cpu".. c
                             .."}${goto 130}${freq_g ".. c
                             .."}GHz${goto 200}${color ".. (ENABLE_COLORS and get_color_freq_cpu(c) or "#FFFFFF") .."}| ".. c+1 
                             ..":${goto 240}${cpu cpu".. c+1
                             .."}%${goto 285}${cpubar 7,30 cpu".. c+1 .."}${goto 325}${freq_g ".. c+1 .."}GHz"
                             .. "${color}\n"
            end
        end
        cpus = conky_cpus
        return conky_cpus
    end
    return cpus   
end

-- Draws max n network interfaces
function conky_drawnetworks(n)
    local active_ifaces = {}
    if active_network_interface == false or tonumber(conky_parse("$updates")) % 2 == 0 then
        local ifaces = io.popen('ip link | grep -Po --regexp "(?<=[0-9]: ).*"')
        for line in ifaces:lines() do
            if string.find(line, "<BROADCAST") then
                local iface = string.gsub(string.match(line, "^.*:"), ":", "")
                table.insert( active_ifaces, iface)
            end
        end
        ifaces:close()
        if table.maxn(active_ifaces) >= 1 then
            local draw_other_ifaces = '${goto 10}${font FontAwesome}${font} ${color #00FF00}Network Interfaces $color \n'
            for i, iface in pairs(active_ifaces) do
                if i <= tonumber(n) then
                    draw_other_ifaces = draw_other_ifaces
                                        .. "${goto 20}".. "${color ".. COLORS[(i % table.getn(COLORS)) + 1] .."}" .. i ..". "
                                        .. iface .." "..  "${font FontAwesome} ${font}${voffset 0} ${addrs " .. iface ..  "}${color}" .. "\n"
                                        .. "${goto 20}${upspeedgraph " .. iface ..  " 20,175 00ffff 00ff00}${goto 202}${downspeedgraph "
                                        .. iface ..  " 20,175 FFFF00 DD3A21}" .. "\n"
                                        .. "${font FontAwesome}${goto 50}${font} ${upspeed "
                                        .. iface ..  "}${font FontAwesome}${goto 250}${font} ${downspeed " .. iface ..  "}" .. "\n"
                    if i < table.maxn( active_ifaces ) and i ~= tonumber(n) then
                        draw_other_ifaces = draw_other_ifaces .. "${goto 20}${stippled_hr 1}\n"
                    end
                end
            end
            active_network_interface = draw_other_ifaces
            return active_network_interface
        else
            active_network_interface = '${goto 10}${font FontAwesome}${font} ${color #00FF00}Network Interfaces $color \n${goto 50} Device not connected.\n'
        end
    end
    return active_network_interface
end

-- Returns CPU temperature in Celsius
function conky_cputemp()
    if tonumber(conky_parse("$updates")) % cpu_temp_update_freq == 0 or ctemp == 0 then
        -- Get find cpu temp file on first call
        if ctemp == 0 then
            local all_hwmon_temp_names = io.popen('ls /sys/class/hwmon/*/temp* | grep -Po --regexp ".*(label)$"')
            for l in all_hwmon_temp_names:lines() do
                local name = io.popen('cat ' .. l):read("*a")
                if name:match("^Package*") then
                    cpu_temp_file = l:gsub("label", "input")
                    break
                end
            end
            all_hwmon_temp_names:close()
        end
        cpu_temp_file_handle = io.open(cpu_temp_file, "r")
        ctemp = tonumber(cpu_temp_file_handle:read("*a"))  / 1000
        cpu_temp_file_handle:close()
    end
    if ctemp > 75 then
        cpu_temp_update_freq = 2
        return "${color #ff0000}${font FontAwesome} ${font}${blink " .. ctemp .. "}${color}"
    elseif ctemp > 50 then
        cpu_temp_update_freq = 4
    else
        cpu_temp_update_freq = 6
    end
    return "${font FontAwesome} ${font}" .. ctemp
end

-- Returns Nth fan's speed in RPM
function conky_fanrpm(n)
    if tonumber(conky_parse("$updates")) % 4 == 0 or fan == -1 then
        if fan == -1 or fan_files[n] == nil then
            local all_hwmon_fans = io.popen('ls /sys/class/hwmon/*/fan?_input')
            for l in all_hwmon_fans:lines() do
                if l:match('fan' .. n .. '_input') then
                    fan_files[n] = l
                end
            end
            all_hwmon_fans:close()
        end
        local fan_file = io.open(fan_files[n], 'r')
        fan_rpms[n] = tonumber(fan_file:read('*a'))
        fan = 1
        fan_file:close()
        return fan_rpms[n]
    end
    return fan_rpms[n]
end

function get_color_freq_cpu(n)
    local min, max, cur, mid, mapped_color
    if cpu_min_freq[n+1] == nil then
        min = get_cpu_min_freq(n)
        if min == nil then
            min = 1200000
        end
        cpu_min_freq[n+1] = min
    else
        min = cpu_min_freq[n+1]
    end

    if cpu_max_freq[n+1] == nil then
        max = get_cpu_max_freq(n)
        if max == nil then
            max = 3000000
        end
        cpu_max_freq[n+1] = max
    else
        max = cpu_max_freq[n+1]
    end
    mid = math.floor(min+max/2)
    cur = get_cpu_freq(n)
    if cur == nil then
        cur = 2000000
    end
    if cur <= mid then
        red = map(cur, min, mid, RED_START, RED_END)
        mapped_color = string.format( "#%02xff00", red)
    else
        green = map(cur, mid, max, GREEN_START, GREEN_END)
        mapped_color = string.format( "#ff%02x00", green)
    end

    return mapped_color
end

function get_cpu_freq(cpu)
    local path = '/sys/devices/system/cpu/cpu' .. cpu .. '/cpufreq/scaling_cur_freq'
    local cpu_freq = io.open( path, 'r' )
    local freq = tonumber(cpu_freq:read('*a'))
    return freq
end

function get_cpu_max_freq(cpu)
    local path = '/sys/devices/system/cpu/cpu' .. cpu .. '/cpufreq/cpuinfo_max_freq'
    local cpu_freq = io.open( path, 'r' )
    local freq = tonumber(cpu_freq:read('*a'))
    return freq
end

function get_cpu_min_freq(cpu)
    local path = "/sys/devices/system/cpu/cpu" .. cpu .. "/cpufreq/cpuinfo_min_freq"
    local cpu_freq = io.open( path, 'r' )
    local freq = tonumber(cpu_freq:read('*a'))
    return freq
end

function conky_topprocess(n)
    local p
    col = "${color #ffffff}"
    if topprocesses == '' then
        topprocesses = topprocesses .. "${color #00FF00}${goto 10}Name ${goto 190}Pid${goto 255}Cpu%${goto 310}Mem%${color}\n"
        for p = 1, tonumber(n) do
            if ENABLE_COLORS then
                col = "${color " .. _TOP_COLORS[(_TOP_COLORS_SIZE + 1) - p] .. "}"
            end
            topprocesses = topprocesses
                        .. col .. "${goto 10}${top name ".. p .. "} ${goto 180}${top pid ".. p .. "}${goto 235}${top cpu ".. p
                        .. "}${goto 290}${top mem ".. p .. "}${color}\n"
        end   
    end
    return topprocesses
end


function map(x, in_min, in_max, out_min, out_max)
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end

-- Trims given string and returns
function trim(s)
   return s:gsub("^%s+", ""):gsub("%s+$", "")
end

-- shuffle function
function shuffle(tbl)
  for i = #tbl, 2, -1 do
    local j = math.random(i)
    tbl[i], tbl[j] = tbl[j], tbl[i]
  end
  return tbl
end
