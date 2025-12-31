# Word Count Utility

Small example project that provides a CLI to count words in a text file.

Usage:

```bash
python word_count.py sample.txt
# prints the number of words in sample.txt
```

The script uses `argparse` and exposes `count_file(path)` for programmatic use.

Setup (virtual environment)

Create and activate a virtual environment, then run the script:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
# No external dependencies for this example; if you add packages,
# create `requirements.txt` and install with:
# pip install -r requirements.txt

python word_count.py sample.txt
```

On Windows (PowerShell):

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python word_count.py sample.txt
```

If you'd like, I can add a `requirements.txt` and a small test harness next.
