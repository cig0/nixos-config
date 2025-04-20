#!/usr/bin/env python3.12

"""
Encrypt files using Mozilla SOPS.

This script encrypts modified files in a specified directory and its subdirectories,
adding the .enc extension to the encrypted versions. It integrates with Git to ensure
only encrypted files are committed. Excludes .py files to avoid encrypting itself.
"""

import subprocess
import sys
from pathlib import Path


def get_modified_files(directory: Path) -> list[Path]:
    """Get modified files in the staging area under the given directory."""
    result = subprocess.run(
        ["git", "diff", "--cached", "--name-only", "--diff-filter=ACM", str(directory)],
        text=True,
        capture_output=True,
        check=True,
    )
    return [Path(file) for file in result.stdout.splitlines() if Path(file).exists()]


def encrypt_file(src_path: Path) -> Path:
    """Encrypt a file using SOPS and return the destination path."""
    dst_path = src_path.with_suffix(src_path.suffix + ".enc")
    subprocess.run(["sops", "-e", "--output", str(dst_path), str(src_path)], check=True)
    return dst_path


def stage_encrypted_file(file_path: Path):
    """Stage an encrypted file for commit."""
    subprocess.run(["git", "add", str(file_path)], check=True)


def unstage_plaintext_file(file_path: Path):
    """Unstage a plaintext file from the Git staging area."""
    subprocess.run(["git", "reset", "HEAD", str(file_path)], check=True)


def main():
    """Main function to run the encryption process."""
    import argparse  # Import here to keep the script lean

    parser = argparse.ArgumentParser(
        description="Encrypt modified files in a directory using SOPS.",
        epilog="Example: python3 sops-encrypt.py secrets/",
    )
    parser.add_argument("directory", help="Directory containing files to encrypt")

    args = parser.parse_args()

    # Validate the provided directory
    root_dir = Path(args.directory)
    if not root_dir.exists():
        print(f"Error: Directory '{args.directory}' does not exist.", file=sys.stderr)
        exit(1)
    if not root_dir.is_dir():
        print(f"Error: '{args.directory}' is not a valid directory.", file=sys.stderr)
        exit(1)

    # Get modified files and process them
    modified_files = get_modified_files(root_dir)
    if not modified_files:
        print(f"No modified files found in '{root_dir}'. Skipping encryption.")
        exit(0)

    for src_path in modified_files:
        if src_path.suffix == ".enc" or src_path.suffix == ".py":
            print(f"Skipping file: {src_path}")
            continue

        try:
            dst_path = encrypt_file(src_path)
            stage_encrypted_file(dst_path)
            unstage_plaintext_file(src_path)
            print(f"Encrypted: {src_path} → {dst_path}")
        except subprocess.CalledProcessError as e:
            print(f"Error processing {src_path}: {e.stderr}", file=sys.stderr)


if __name__ == "__main__":
    main()
