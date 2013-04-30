
class Termin
  class ConsoleReporter
    def starting content
      puts "REPORTING ON: -------- #{content} --------"
    end

    def external_url u
      puts "  FOUND EXTERNAL URL: #{u}"
    end
  end
end
