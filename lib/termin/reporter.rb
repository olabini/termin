
class Termin
  class ConsoleReporter
    def starting content
      puts "REPORTING ON: -------- #{content} --------"
    end

    def external_url u
      puts "  FOUND EXTERNAL URL: #{u}"
    end

    def cookie c
      puts "  COOKIE: #{c}"
    end

    def social c
      puts "  SOCIAL WIDGET: #{c.inspect}"
    end
  end
end
