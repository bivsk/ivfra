{
  extraFiles = {
    "lua/bivsk/tooling_info.lua".source = ./lua/bivsk/tooling_info.lua;
    "lua/bivsk/web_tools.lua".source = ./lua/bivsk/web_tools.lua;
  };

  # Small boolean function to convert a boolean to a string
  extraConfigLuaPre = /* Lua */ ''
    function bool2str(bool) return bool and "on" or "off" end
  '';
}
