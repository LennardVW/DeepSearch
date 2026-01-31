# DeepSearch

🔍 Semantic file search for macOS. Find files by meaning, not just filename.

## Features

- 🧠 **Vector Search** - AI-powered semantic understanding
- 📝 **Content Search** - Search inside documents
- 🏷️ **Auto Tagging** - AI-generated tags
- 📊 **Similarity Search** - Find related files
- 🎯 **Natural Language** - "files about API authentication"
- 🔗 **Cross-Reference** - Find linked documents
- 📈 **Usage Analytics** - Track file access patterns
- 🔐 **Local Only** - No cloud, fully private

## Installation

```bash
git clone https://github.com/LennardVW/DeepSearch.git
cd DeepSearch
swift build -c release
cp .build/release/deepsearch /usr/local/bin/
```

## Usage

```bash
# Index your files
deepsearch index ~/Documents

# Semantic search
deepsearch search "project proposals"
deepsearch search "code about networking"

# Find similar files
deepsearch similar ~/Documents/report.pdf

# Search by content
deepsearch content "TODO: refactor"

# Natural language
deepsearch ask "where is my passport scan?"
```

## Search Examples

| Query | Finds |
|-------|-------|
| "last week's presentation" | Recent .pptx/.key files |
| "contract with Acme Corp" | PDFs mentioning Acme |
| "swift code for networking" | .swift files with URLSession |
| "photos from Japan trip" | Images with Japan metadata |

## Supported Formats

- 📄 PDF (text extraction)
- 📝 Markdown, TXT
- 📊 Office documents (via text extraction)
- 🖼️ Images (EXIF + OCR)
- 💻 Code files (syntax-aware)

## How It Works

1. **Indexing** - Extracts text from all files
2. **Embeddings** - Creates vector representations
3. **Semantic Search** - Finds meaning, not just keywords
4. **Ranking** - Most relevant results first

## Configuration

`~/.deepsearch/config.json`:
```json
{
  "indexPath": "~/.deepsearch/index",
  "excludeDirs": [".git", "node_modules"],
  "maxFileSize": "100MB",
  "autoIndex": true
}
```

## Requirements
- macOS 15.0+ (Tahoe)
- Swift 6.0+
- ~1GB disk space for index

## License
MIT
