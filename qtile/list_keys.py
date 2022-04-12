from config import keys, mod
import os


output = []
for key in keys:
    output.append(f'{" + ".join(key.modifiers + [key.key])}: {key.desc}'.replace(mod, 'mod'))
text = "\n".join(output)

os.system(f'echo "{text}" | yad --text-info --geometry 1200x900')
