#!/usr/bin/env python3
import sys
import os
from ruamel.yaml import YAML

def debug_print(msg):
    if os.getenv('is_debug', '').lower() == 'true':
        print(f"[DEBUG] {msg}", file=sys.stdout)

def format_yaml_file(input_path, output_path):
    yaml = YAML()
    yaml.explicit_start = True  # Add ---
    yaml.indent(mapping=2, sequence=4, offset=2)

    debug_print(f"Reading file: {input_path}")
    with open(input_path, 'r') as f:
        data = yaml.load(f)
        debug_print(f"YAML type: {type(data)}")

    with open(output_path, 'w') as f:
        yaml.dump(data, f)

    print(f"[INFO] Wrote formatted: {output_path}", file=sys.stdout)

def main():
    if len(sys.argv) != 3:
        print(f"[ERROR] Usage: {sys.argv[0]} <input_dir> <output_dir>", file=sys.stderr)
        sys.exit(1)

    input_dir, output_dir = sys.argv[1], sys.argv[2]

    if not os.path.isdir(input_dir):
        print(f"[ERROR] Input '{input_dir}' is not a directory", file=sys.stderr)
        sys.exit(1)

    os.makedirs(output_dir, exist_ok=True)
    debug_print(f"Created output dir: {output_dir}")

    for filename in os.listdir(input_dir):
        if filename.endswith(('.yaml', '.yml')):
            input_path = os.path.join(input_dir, filename)
            output_path = os.path.join(output_dir, filename)

            try:
                format_yaml_file(input_path, output_path)
            except Exception as e:
                print(f"[ERROR] Failed on {input_path}: {e}", file=sys.stderr)

if __name__ == "__main__":
    main()
