"""
Encrypt files using Mozilla SOPS.

This script encrypts modified files in a specified directory and its subdirectories,
adding the .enc extension to the encrypted versions. It integrates with Git to ensure
only encrypted files are committed. Excludes .py files to avoid encrypting itself.
"""

import argparse
import subprocess
import sys
from collections import defaultdict
from pathlib import Path


def get_modified_files(directory: Path) -> list[Path]:
    """
    Get a list of modified files in the specified directory and its subdirectories
    using Git's diff command.
    """
    try:
        # Use git diff to find modified files in the staging area
        result = subprocess.run(
            [
                "git",
                "diff",
                "--cached",
                "--name-only",
                "--diff-filter=ACM",
                str(directory),
            ],
            check=True,
            text=True,
            capture_output=True,
        )
        modified_files = result.stdout.splitlines()
        return [Path(file) for file in modified_files if Path(file).exists()]
    except subprocess.CalledProcessError as e:
        print(f"Error retrieving modified files: {e.stderr}", file=sys.stderr)
        sys.exit(1)


def encrypt_file(src_path: Path) -> Path:
    """Encrypt a file using sops and return the destination path."""
    dst_path = Path(f"{src_path}.enc")
    subprocess.run(
        ["sops", "-e", "--output", str(dst_path), str(src_path)],
        check=True,
        text=True,
        capture_output=True,
    )
    return dst_path


def stage_encrypted_file(file_path: Path):
    """Stage an encrypted file for commit."""
    subprocess.run(["git", "add", str(file_path)], check=True)


def remove_plaintext_file_from_staging(file_path: Path):
    """Remove a plaintext file from the Git staging area."""
    subprocess.run(["git", "reset", "HEAD", str(file_path)], check=True)
    file_path.unlink()  # Delete the plaintext file


def main() -> None:
    """Main function to parse arguments and run the encryption process."""
    parser = argparse.ArgumentParser(
        description="Encrypt modified files in a directory and its subdirectories using SOPS."
    )
    parser.add_argument("directory", help="Root directory containing files to encrypt")
    args = parser.parse_args()

    root_dir = Path(args.directory)

    if not root_dir.exists() or not root_dir.is_dir():
        print(f"Error: '{args.directory}' is not a valid directory", file=sys.stderr)
        sys.exit(1)

    # Track encrypted files by directory for summary
    encrypted_files = defaultdict(list)

    # Get modified files in the directory and its subdirectories
    modified_files = get_modified_files(root_dir)

    if not modified_files:
        print(f"No modified files found in '{root_dir}'. Skipping encryption.")
        sys.exit(0)

    # Process all modified files
    for src_path in modified_files:
        # Skip already encrypted files or .py files
        if src_path.name.endswith(".enc") or src_path.suffix == ".py":
            print(f"Skipping file: {src_path}")
            continue

        try:
            # Encrypt the file
            dst_path = encrypt_file(src_path)
            parent_dir = (
                src_path.parent.relative_to(root_dir)
                if src_path.parent != root_dir
                else Path(".")
            )
            encrypted_files[parent_dir].append(src_path.name)

            # Stage the encrypted file
            stage_encrypted_file(dst_path)

            # Remove the plaintext file from the staging area
            remove_plaintext_file_from_staging(src_path)

            print(f"Encrypted: {src_path} → {dst_path}")
        except subprocess.CalledProcessError as e:
            print(f"Error encrypting {src_path}: {e.stderr}", file=sys.stderr)

    # Print summary by directory
    print("\nEncryption Summary:")
    print("===================")

    if not encrypted_files:
        print("No files were encrypted.")
    else:
        for directory, files in sorted(encrypted_files.items()):
            dir_path = root_dir / directory if directory != Path(".") else root_dir
            print(f"\n{dir_path}:")
            for file in sorted(files):
                print(f"  - {file}")

        total_files = sum(len(files) for files in encrypted_files.values())
        total_dirs = len(encrypted_files)
        print(
            f"\nTotal: {total_files} file(s) encrypted across {total_dirs} director{'y' if total_dirs == 1 else 'ies'}"
        )


if __name__ == "__main__":
    main()
