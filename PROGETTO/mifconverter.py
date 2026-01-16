# convert_txt_to_mif.py
input_file = "radar_green.txt"
output_file = "radar_green.mif"

width = 4
depth = 262144

with open(input_file) as f:
    lines = [line.strip() for line in f if line.strip()]

with open(output_file, "w") as f:
    f.write(f"WIDTH={width};\n")
    f.write(f"DEPTH={depth};\n")
    f.write("ADDRESS_RADIX=DEC;\n")
    f.write("DATA_RADIX=BIN;\n")
    f.write("CONTENT BEGIN\n")
    for addr, line in enumerate(lines):
        f.write(f"{addr} : {line};\n")
    f.write("END;\n")
