function update_rust_analyzer -d "update rust_analyzer"
    command curl -L https://github.com/rust-analyzer/rust-analyzer/releases/download/nightly/rust-analyzer-aarch64-apple-darwin.gz -o ~/bin/rust-analyzer.gz
    command gunzip -f ~/bin/rust-analyzer.gz
    command chmod a+x ~/bin/rust-analyzer

end

