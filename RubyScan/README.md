# RubyScan 🔍

RubyScan is a simple command-line malware scanner written in Ruby.  
It uses the VirusTotal API to scan URLs and display a clean, readable report in the terminal.

This project was built as a learning exercise in Ruby , focusing on usability, structure, and real-world tooling.
---

## What it does

RubyScan lets you:

- Scan URLs using VirusTotal
- View a readable scan report in your terminal
- Get a clear verdict (CLEAN / MALICIOUS)
- Export results to JSON
- Keep a log of previous scans
- Watch a progress bar while analysis runs

It’s designed to feel like a real security tool, not just a demo script.

---

## 📦 Installation

Clone the project:

```bash
git clone https://github.com/emilkadelaetsuuur/RubyScan.git
cd RubyScan
```

Install required gems:

```bash
gem install colorize ruby-progressbar
```

Or use Bundler if included:

```bash
bundle install
```

---

## 🔑 VirusTotal API setup

You’ll need a free VirusTotal API key.

1. In file called:

```
config.rb
```

2. Add your key:

```ruby
API_KEY = "YOUR_API_KEY"
BASE_URL = "https://www.virustotal.com/api/v3"
```

That’s it — you’re ready to scan.

---

## ▶ Usage

Run the program:

```bash
ruby main.rb
```

Follow the menu prompts and choose what you want to scan.

---

## 📁 Project structure

```
rubyscan/
│
├── main.rb          # CLI entry point
├── scanner.rb       # scanning logic
├── vt_client.rb     # VirusTotal API wrapper
├── reports/         # exported JSON reports
├── scan.log         # scan history
└── README.md
```

---

## 📊 Example output

```
=== Scan Report ===
Harmless:   69
Undetected: 25
Malicious:  0
Suspicious: 0

Result:
✅ File keeps clean
```

---

## 📝 Logs & reports

Each scan:

- is logged in `scan.log`
- exports a JSON report to `reports/report.json`

This makes it easy to keep track of previous scans.

---
This project is for educational purposes only.  
It is not intended to bypass security or be used for illegal activity.
