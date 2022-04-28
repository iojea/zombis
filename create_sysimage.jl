using PackageCompiler
create_sysimage([:Pluto, :PlutoUI, :Plots, :HypertextLiteral];
                #precompile_execution_file = "warmup.jl",
                #replace_default = true,
                sysimage_path="/home/jovyan/sysimage.so",
                cpu_target = PackageCompiler.default_app_cpu_target())
