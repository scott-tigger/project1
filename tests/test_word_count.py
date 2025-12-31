from __future__ import annotations

from pathlib import Path

import word_count


def test_count_words_in_text():
    s = "hello  world\nthis is  a test"
    # splits on any whitespace
    assert word_count.count_words_in_text(s) == 6


def test_count_file_and_main_prints(capsys):
    sample = Path(__file__).parent.parent / "sample.txt"
    # verify count_file
    assert word_count.count_file(str(sample)) == 17

    # verify main prints the count and returns 0
    rc = word_count.main([str(sample)])
    captured = capsys.readouterr()
    assert rc == 0
    assert captured.out.strip() == "17"


def test_file_not_found(capsys):
    rc = word_count.main(["this_file_does_not_exist_12345.txt"])
    captured = capsys.readouterr()
    assert rc == 2
    assert "Error: file not found" in captured.err

