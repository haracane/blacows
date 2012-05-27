require "spec_helper"

describe "bin/create-tag-trie" do
  before :all do
    @stderr_redirect = Kjxtag::REDIRECT[:stderr]
  end
  it "should create trie" do
    
    tags_path = "#{Kjxtag::SPEC_DIR}/data/config/offering-tags.txt"
    keywords_path = "#{Kjxtag::SPEC_DIR}/data/config/offering-keywords.txt"
    trie_path = "#{Kjxtag::SPEC_DIR}/tmp/offering-trie"
    
    `rm #{trie_path}.*`
    `sh #{Kjxtag::BIN_DIR}/create-tag-trie #{tags_path} #{keywords_path} #{trie_path} #{@stderr_redirect}`
    File.exists?("#{trie_path}.key").should be_true
    File.exists?("#{trie_path}.val").should be_true
    File.exists?("#{trie_path}.map").should be_true
  end
end
