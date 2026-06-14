#!/bin/bash

steamcmd_dir="$HOME/steamcmd"
install_dir="$HOME/.klei/DoNotStarveTogether/dedi-sv-install"
cluster_name="dedi-sv"
dontstarve_dir="$HOME/.klei/DoNotStarveTogether"
mods_source_dir="$dontstarve_dir/$cluster_name/mods"

function fail()
{
	echo Error: "$@" >&2
	exit 1
}

function check_for_file()
{
	if [ ! -e "$1" ]; then
		fail "Missing file: $1"
	fi
}

cd "$steamcmd_dir" || fail "Missing $steamcmd_dir directory!"

check_for_file "steamcmd.sh"
check_for_file "$dontstarve_dir/$cluster_name/cluster.ini"
check_for_file "$dontstarve_dir/$cluster_name/cluster_token.txt"
check_for_file "$dontstarve_dir/$cluster_name/Master/server.ini"
check_for_file "$dontstarve_dir/$cluster_name/Caves/server.ini"

./steamcmd.sh +force_install_dir "$install_dir" +login anonymous +app_update 343050 +quit

if [ -f "$mods_source_dir/dedicated_server_mods_setup.lua" ]; then
    cp "$mods_source_dir/dedicated_server_mods_setup.lua" "$install_dir/mods/"
    echo "Copied dedicated_server_mods_setup.lua"
else
    echo "WARNING: No dedicated_server_mods_setup.lua found at $mods_source_dir"
fi

if [ -f "$mods_source_dir/modoverrides.lua" ]; then
    cp "$mods_source_dir/modoverrides.lua" "$dontstarve_dir/$cluster_name/Overworld/"
    cp "$mods_source_dir/modoverrides.lua" "$dontstarve_dir/$cluster_name/Caves/"
    echo "Copied modoverrides.lua to both shards"
else
    echo "WARNING: No modoverrides.lua found at $mods_source_dir"
fi

check_for_file "$install_dir/bin64"

cd "$install_dir/bin64" || fail

run_shared=(./dontstarve_dedicated_server_nullrenderer_x64)
run_shared+=(-console)
run_shared+=(-cluster "$cluster_name")
run_shared+=(-monitor_parent_process $$)

"${run_shared[@]}" -shard Caves  | sed 's/^/Caves:  /' &
"${run_shared[@]}" -shard Master | sed 's/^/Master: /'
