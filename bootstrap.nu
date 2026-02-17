#!/usr/bin/env nu
# Bootstrap script to compile Fennel config on a fresh system

let nvim_config = $"($env.HOME)/.config/nvim"
let hotpot_path = $"/tmp/hotpot.nvim"

# Clone hotpot to tmp if it doesn't exist
if not ($hotpot_path | path exists) {
    print "Cloning hotpot.nvim to /tmp..."
    git clone --filter=blob:none --branch=v0.14.8 https://github.com/rktjmp/hotpot.nvim.git $hotpot_path
}

# Compile all fennel files
print "Compiling Fennel config..."
nvim --headless --clean --cmd $"set rtp+=($hotpot_path)" $"+lua require('hotpot').api.make.auto.build('($nvim_config)', {verbose=true, force=true})" +quit

print "✓ Done! You can now start nvim normally"
print $"  (Hotpot was cloned to /tmp and can be deleted)"
