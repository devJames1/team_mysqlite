require_relative 'my_sqlite_request'
require 'readline'
require "csv"


def readline_manage_hist
    
    line = Readline.readline('my_sqlite_cli> ', true)
    line = line.gsub(/(')/, '').gsub(/( = )/, "=")
    line = line.delete "()"

    #handle blank lines
    if line =~ /^\s*$/ or Readline::HISTORY.to_a[-2] == line
        Readline::HISTORY.pop
    end
    return line
end


def to_haash(array)
    result = Hash.new
    index = 0
    while index < array.length
        key, value = array[index].split("=")
        result[key] = value
        index += 1
    end
    return result
end

def process_request(action, args, request)

    case action
    
    when "from"
        if args.length != 1
            puts "Ex.: FROM db.csv"
            return
        else
            request.from(*args)
        end

    when "select"
        if args.length < 1
            puts "Ex.: SELECT name, age"
            return
        else
            request.select(args)
        end

    when "where"
        if args.length != 1
            puts "Ex.: WHERE age=30"
        else
            col, val = args[0].split("=")
            request.where(col, val)
        end

    when "order"
        if args.length != 2
            p "Ex.: ORDER age ASC"
        else
            col_name = args[0]
            sort_type = args[1].downcase
            request.order(sort_type, col_name)
        end

    when "join"
        if args.length != 3
            puts "Try Ex.: JOIN table ON col_a=col_b"
        elsif args[1] != "ON"
            puts "ON statement missing. Ex.: JOIN table ON col_a=col_b"
            return
        else
            table = args[0]
            col_a, col_b = args[2].split("=")
            request.join(col_a, table, col_b)
        end

    when "insert"
        
        return

    when "into"
        if args.length < 1
            puts "Ex.: Provide table name to insert data"
        else
            request.insert(args)
        end

    when "values"
        if args.length < 1
            puts "Provide some data to insert. Ex.: name=James, birth_state=CA, age=40"
        else
            arr_str = args.join(" ")
            arr_value = arr_str.split(",")
            table_name = request.table_name
            student_info_arr = []
            table_headers = CSV.open(table_name, &:readline)

            0.upto table_headers.length-1 do |index|
                
                student_info_arr.push("#{table_headers[index]}=#{arr_value[index]}")

            end
            request.values(to_haash(student_info_arr))
        end

    when "update"
        if args.length != 1
            puts "Ex.: UPDATE db.csv"
        else
            request.update(*args)
        end
    when "set"
        if args.length < 1
            puts "Ex.: SET name=BOB. Use WHERE - Or it may UPDATE ALL."
        else
            request.set(to_haash(args)) 
        end
    when "delete"
        if args.length != 0
            # conditional statement to confirm deletion of table
            puts "Ex.: DELETE FROM db.csv! Use WHERE - Or it may DELETE ALL."
        else
            request.delete 
        end
    else
        puts "don't have this statement yet"
        puts "To quit - type quit."
    end
end

def execute_request(sql)
    valid_db_actions = ["SELECT", "FROM", "JOIN", "WHERE", "ORDER", "INSERT", "INTO", "VALUES", "UPDATE", "SET", "DELETE"]
    command = nil
    args = []
    request = MySqliteRequest.new
    splited_command = sql.split(" ")
    
    0.upto splited_command.length - 1 do |arg|

        if valid_db_actions.include?(splited_command[arg].upcase())
            if (command != nil) 
                if command != "JOIN"
                    args_string = args.join(" ")
                  
                    if args_string.match(" ")
                        args = args_string.split(", ")
                    else
                        args = args_string.split(",")
                    end
                end

                if command == "into"
                        process_request(command, args_string, request)
                else
                    process_request(command, args, request)
                end

                command = nil
                args = []
            end
            command = splited_command[arg].downcase()
        else
            args << splited_command[arg]
        end
    end

    if args[-1].end_with?(";")
        args[-1] = args[-1].chomp(";")
        process_request(command, args, request)
        request.run
    else
        p "Please end your request with ;"
    end
end

def run
    puts "MySQLite version 0.1 2023-02-11"
    while command = readline_manage_hist
        if command == "quit"
            break
        else
            execute_request(command)
        end
    end
end

run()
