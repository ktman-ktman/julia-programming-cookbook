#!/bin/bash

initial_dir=${PWD}

# dotfiles
git clone https://github.com/ktman-ktman/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh ./install_vscode.sh
cd ${initial_dir}

# julia
if [[ ! -f "./.julia" ]] && [[ -f "./Project.toml" ]]
then
	julia --project=@. -e "using Pkg; Pkg.instantiate()"
fi