require_relative 'scanner'
require 'colorize'
require 'ruby-progressbar'


  def menu
    puts "\n=== Malware Scanner ===".green
    puts "1. Scan file"
    puts "2. Scan URL"
    puts "3. How to get sha256(hash)"
    puts "4. Scan file hash"
    puts "5. Exit"
    print "> "
end

loop do
  menu
  choice = gets.chomp

  case choice
  when "1"
    puts "\n⚠ WARNING:"
    puts "Files uploaded to VirusTotal may be shared in their global database."
    puts "Do NOT upload private or sensitive files."
    puts "If you want to scan private files, share only the SHA256 hash instead."
    puts "Use option 3 to scan via SHA256"
    print "Continue? (y/n): "
 
    confirm = gets.chomp.downcase
   next unless confirm == "y"

    print "File path: "
    path = gets.chomp
    result = Scanner.scan_file(path)
    puts result

  when "2"
    print "URL: "
    url = gets.chomp
    result = Scanner.scan_url(url)
    puts result

  when "3"
    puts "\n=== How to get SHA256 hash ==="
    puts "1. Open terminal (Ctrl + Alt + T)"
    puts "2. Go to file folder:"
    puts "   cd ~/Downloads"
    puts "3. Run:"
    puts "   sha256sum filename"
    puts "\nExample output:"
    puts "9f86d081884c7d659a2feaa0c55ad015...  filename.exe"
       puts "\nPress Enter to continue..."
    gets


  when "4"
    print "File path for hash: "
    path = gets.chomp
    result = Scanner.hash_file(path)
    puts result

  when "5"
    puts "Bye!"
    exit

  else
    puts "Invalid option".red
  end
end
