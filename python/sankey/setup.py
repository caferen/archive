from cx_Freeze import setup, Executable
import sys



sys.argv.append("build")
base = None    

executables = [Executable("sankey.py", base=base)]

packages = ["idna", "xlrd", "plotly.graph_objects"]
options = {
    'build_exe': {    
        'packages':packages,
    },    
}

setup(
    name = "sankey",
    options = options,
    version = "1.0",
    description = '',
    executables = executables
)