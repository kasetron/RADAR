from PIL import Image
import os
from typing import Literal

def convert_png_to_green_txt(
    input_path: str,
    output_txt: str,
    width: int,
    height: int,
    bits: int = 1,                     # 4 o 8
    preserve_aspect: bool = False,
    order: Literal['row','col'] = 'row',
    save_packed_hex: bool = True,
):
    if not os.path.exists(input_path):
        raise FileNotFoundError(input_path)

    img = Image.open(input_path).convert('RGB')

    # Resize
    if preserve_aspect:
        tmp = img.copy()
        tmp.thumbnail((width, height), Image.LANCZOS)
        bg = Image.new('RGB', (width, height), (0,0,0))
        bg.paste(tmp, ((width-tmp.width)//2, (height-tmp.height)//2))
        img = bg
    else:
        if img.size != (width, height):
            img = img.resize((width, height), Image.LANCZOS)

    # Estrai canale G
    _, g, _ = img.split()

    # Quantizzazione
    max_val = (1 << bits) - 1
    scale = 255 / max_val
    green_vals = [
        0 if v < 10 else int(v / scale)
        for v in g.getdata()
    ]

    # Riordino col-major se richiesto
    if order == 'col':
        col_vals = []
        for x in range(width):
            for y in range(height):
                col_vals.append(green_vals[y*width + x])
        green_vals = col_vals

    # TXT output (un valore per riga)
    with open(output_txt, 'w') as f:
        f.write('\n'.join(f"{v:01b}" for v in green_vals))

    print(f"Saved {len(green_vals)} green values ({bits} bit)")

    # HEX pack (valori interi, NON bitstream)
    if save_packed_hex:
        hex_path = os.path.splitext(output_txt)[0] + '.hex'
        with open(hex_path, 'w') as fh:
            for v in green_vals:
                fh.write(f"{v:02X}\n")
        print(f"Saved HEX to {hex_path}")

# Esempio di utilizzo
if __name__ == "__main__":
    convert_png_to_green_txt(
        input_path = "radar.png",
        output_txt = "radar_green.txt",
        width = 638,
        height = 399,
        bits = 1,                 # 0–15
        preserve_aspect = False,
        order = 'row',
        save_packed_hex = True
    )