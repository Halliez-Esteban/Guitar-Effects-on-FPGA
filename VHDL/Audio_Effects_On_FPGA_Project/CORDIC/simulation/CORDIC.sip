set_global_assignment -entity "CORDIC" -library "lib_CORDIC" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "CORDIC" -library "lib_CORDIC" -name IP_TOOL_VERSION "19.1"
set_global_assignment -entity "CORDIC" -library "lib_CORDIC" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_CORDIC" -name SPD_FILE [file join $::quartus(sip_path) "../CORDIC.spd"]
set_global_assignment -library "lib_CORDIC" -name MISC_FILE [file join $::quartus(sip_path) "../../CORDIC.qsys"]

set_global_assignment -library "lib_CORDIC" -name MISC_FILE [file join $::quartus(sip_path) "CORDIC.vhd"]
set_global_assignment -library "lib_CORDIC" -name MISC_FILE [file join $::quartus(sip_path) "submodules/dspba_library_package.vhd"]
set_global_assignment -library "lib_CORDIC" -name MISC_FILE [file join $::quartus(sip_path) "submodules/dspba_library.vhd"]
set_global_assignment -library "lib_CORDIC" -name MISC_FILE [file join $::quartus(sip_path) "submodules/CORDIC_CORDIC_0.vhd"]
