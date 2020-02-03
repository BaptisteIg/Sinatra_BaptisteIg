require 'pry'
require 'csv'

class Gossip
    attr_accessor :author, :content

    def initialize (name, potin)
        @author = name
        @content = potin
    end

    def save 
        CSV.open("db/gossip.csv", "ab") do |csv|
            csv << [@author, @content]
        end
    end

    def self.all
        all_gossips = []
        CSV.read("./db/gossip.csv").each do |csv_line|
          all_gossips << Gossip.new(csv_line[0], csv_line[1])
        end
        return all_gossips
    end

    def self.find(id)
        self.all.each_with_index do |line, index|
            if index + 1 == id.to_i
                return [line.author, line.content]
            end
        end
    end

    def self.update (id, author, content)
        arr = []
        self.all.each_with_index do |line, index|
          if index + 1 == id.to_i
            line.author = author.to_s
            line.content = content.to_s
          end
        arr << [line.author, line.content]
        end

        File.delete("./db/gossip.csv")

        CSV.open("db/gossip.csv", "ab") do |row|
          arr.each do |obj|
            row << obj
          end
        end
    end
end
    
