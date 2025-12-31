#!/usr/bin/env python3
"""Simple CLI to count words in a file using argparse.

Usage:
  python word_count.py path/to/file.txt
"""
from __future__ import annotations

import argparse
import sys


def count_words_in_text(text: str) -> int:
    """Return number of words in the given text.

    Splits on any whitespace, which matches typical word-count behavior.
    """
    return len(text.split())


def count_file(path: str) -> int:
    with open(path, "r", encoding="utf-8") as fh:
        return count_words_in_text(fh.read())


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Count words in a file.")
    parser.add_argument("file", help="Path to input file")
    args = parser.parse_args(argv)

    try:
        count = count_file(args.file)
    except FileNotFoundError:
        print(f"Error: file not found: {args.file}", file=sys.stderr)
        return 2
    except Exception as exc:  # pragma: no cover - surface unexpected errors
        print(f"Error: {exc}", file=sys.stderr)
        return 1

    print(count)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
