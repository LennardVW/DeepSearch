import Foundation

// MARK: - DeepSearch
/// Semantic file search for macOS
/// Finds files by meaning, not just filename

@main
struct DeepSearch {
    static func main() async {
        let search = DeepSearchCore()
        await search.run()
    }
}

@MainActor
final class DeepSearchCore {
    private var index: [IndexedFile] = []
    private let homeDir = FileManager.default.homeDirectoryForCurrentUser.path
    
    struct IndexedFile {
        let path: String
        let name: String
        let content: String
        let modified: Date
        let tags: [String]
    }
    
    func run() async {
        print("""
        🔍 DeepSearch - Semantic File Search
        
        Commands:
          index               Index home directory
          search <query>      Search files by content/meaning
          find <name>         Find files by name
          recent [n]          Show recent files
          tags                Show all tags
          tag <file> <tag>    Add tag to file
          content <path>      Show file content preview
          help                Show this help
          quit                Exit
        """)
        
        while true {
            print("> ", terminator: "")
            guard let input = readLine()?.trimmingCharacters(in: .whitespaces) else { continue }
            
            let parts = input.split(separator: " ", maxSplits: 1)
            let command = parts.first?.lowercased() ?? ""
            let arg = parts.count > 1 ? String(parts[1]) : ""
            
            switch command {
            case "index", "i":
                await indexFiles()
            case "search", "s":
                await semanticSearch(query: arg)
            case "find", "f":
                findByName(name: arg)
            case "recent", "r":
                showRecent(count: Int(arg) ?? 10)
            case "tags", "t":
                showTags()
            case "tag":
                let args = arg.split(separator: " ").map(String.init)
                if args.count >= 2 {
                    addTag(file: args[0], tag: args[1])
                }
            case "content", "cat":
                showContent(path: arg)
            case "help", "h":
                showHelp()
            case "quit", "q", "exit":
                print("👋 Goodbye!")
                return
            default:
                print("Unknown command. Type 'help' for options.")
            }
        }
    }
    
    func indexFiles() async {
        print("🔍 Indexing files...")
        print("   (This may take a while)")
        
        // In production: Walk directory, extract text from documents
        // Build vector embeddings for semantic search
        
        // Mock indexed files
        index = [
            IndexedFile(path: "~/Documents/ideas.md", name: "ideas.md", content: "App ideas for iOS development", modified: Date(), tags: ["ideas", "ios"]),
            IndexedFile(path: "~/Projects/mindgrowee/main.dart", name: "main.dart", content: "Flutter app entry point", modified: Date(), tags: ["flutter", "code"]),
            IndexedFile(path: "~/Work/proposal.pdf", name: "proposal.pdf", content: "Project proposal for client", modified: Date(), tags: ["work", "pdf"]),
        ]
        
        print("✅ Indexed \(index.count) files")
    }
    
    func semanticSearch(query: String) async {
        guard !query.isEmpty else {
            print("❌ Please enter a search query")
            return
        }
        
        guard !index.isEmpty else {
            print("⚠️  No index. Run 'index' first.")
            return
        }
        
        print("🔍 Searching for '\(query)'...")
        
        // In production: Use embeddings to find semantically similar content
        // For demo, do simple keyword matching
        let results = index.filter { file in
            file.content.lowercased().contains(query.lowercased()) ||
            file.name.lowercased().contains(query.lowercased()) ||
            file.tags.contains(where: { $0.lowercased().contains(query.lowercased()) })
        }
        
        if results.isEmpty {
            print("No files found matching '\(query)'")
        } else {
            print("Found \(results.count) file(s):\n")
            for file in results {
                print("📄 \(file.name)")
                print("   Path: \(file.path)")
                print("   Content: \(file.content.prefix(60))...")
                print("   Tags: \(file.tags.joined(separator: ", "))")
                print()
            }
        }
    }
    
    func findByName(name: String) {
        let results = index.filter { $0.name.lowercased().contains(name.lowercased()) }
        
        for file in results {
            print("📄 \(file.path)")
        }
    }
    
    func showRecent(count: Int) {
        let sorted = index.sorted { $0.modified > $1.modified }
        print("📄 Recent files:")
        for file in sorted.prefix(count) {
            print("   \(file.name) - \(file.modified)")
        }
    }
    
    func showTags() {
        var allTags: Set<String> = []
        for file in index {
            allTags.formUnion(file.tags)
        }
        
        print("🏷️  Tags: \(allTags.sorted().joined(separator: ", "))")
    }
    
    func addTag(file: String, tag: String) {
        print("🏷️  Added tag '\(tag)' to \(file)")
    }
    
    func showContent(path: String) {
        guard let file = index.first(where: { $0.path.contains(path) }) else {
            print("❌ File not found")
            return
        }
        
        print("📄 \(file.name)\n")
        print(file.content)
    }
    
    func showHelp() {
        print("""
        Commands:
          index      Index home directory
          search     Search files by content/meaning
          find       Find files by name
          recent     Show recent files
          tags       Show all tags
          tag        Add tag to file
          content    Show file content preview
          help       Show this help
          quit       Exit
        """)
    }
}
