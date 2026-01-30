require_relative 'vt_client'
require 'digest'
require 'uri'
require 'colorize'
require 'json'
require 'ruby-progressbar'

class Scanner

  LOG_FILE = "scan.log"

  def self.log(message)
    File.open(LOG_FILE, "a") do |f|
      f.puts "[#{Time.now}] #{message}"
    end
  end

  def self.export_report(data)
    Dir.mkdir("reports") unless Dir.exist?("reports")
    File.write("reports/report.json", JSON.pretty_generate(data))

    puts "\n[+] Report exported to reports/report.json".cyan

  end

  def self.show_verdict(stats)
    malicious = stats["malicious"] || 0

    if malicious > 0
      puts "\nVERDICT: MALICIOUS".red.bold
    else
      puts "\nVERDICT: CLEAN".green.bold
    end
  end

  
  def self.pretty_report(stats)
    harmless   = stats['harmless'] || 0
    undetected = stats['undetected'] || 0
    malicious  = stats['malicious'] || 0
    suspicious = stats['suspicious'] || 0

    puts "\n=== Scan Report ==="
    puts "Harmless:   #{harmless}"
    puts "Undetected: #{undetected}"
    puts "Malicious:  #{malicious}"
    puts "Suspicious: #{suspicious}"

    puts "\nResult:"

    if malicious > 0 || suspicious > 0
      puts "😈 Threat detected!"
    else
      puts "File looks clean"
    end
  end

  def self.scan_url(url)
    begin
      URI.parse(url)
    rescue
      raise "Invalid URL"
    end

    puts "[+] Sending URL..."
    log("Scanning URL: #{url}")

    result = VTClient.scan_url(url)
    analysis_id = result["data"]["id"]

    puts "[*] Waiting for analysis..."

    bar = ProgressBar.create(title: "Scanning", total: 10)

    report = nil

    loop do
      sleep 2
      bar.increment

      report = VTClient.get_analysis(analysis_id)
      status = report["data"]["attributes"]["status"]

      break if status == "completed"
    end

    stats = report["data"]["attributes"]["stats"]

    pretty_report(stats)
    show_verdict(stats)
    export_report(report)
    log("Scan finished: #{stats}")
  end

end
