require "csv"
require_relative "my_data_process_op"



class MySqliteRequest

    def initialize
        @table_name = nil
        @request = nil
    end

    attr_reader :table_name

    def from(table_name)

        if table_name == nil
            puts "No database found with extension .csv"
        else
            @table_name = table_name
        end
        return self

    end

    def select(columns)

        if columns == nil
            puts "Column(s) not selected"
        else
            @request = 'select'
            @columns = columns
        end
        return self

    end

    def where(column, value)
        @where = {column: column, value: value}
        return self
    end

    def join(column_on_db_a, filename_db_b, column_on_db_b)
        @join = {column_a: column_on_db_a, column_b: column_on_db_b}
        @table_join = filename_db_b
        return self
    end

    def order(order, column_name)
        @order_query = {order: order, column_name: column_name}
        return self
    end

    def insert(table_name)
        @request = 'insert'
        @table_name = table_name
        return self
    end

    def values(data)
        @data = data
        return self
    end

    def update(table_name)
        @request = 'update'
        @table_name = table_name
        return self
    end

    def set(data)
        @data = data
        return self
    end

    def delete
        @request = 'delete'
        return self
    end

    def run_join_op

        array_of_hashes_a = convert_csv_to_hash(@table_name)
        array_of_hashes_b = convert_csv_to_hash(@table_name_join)
        array_of_hashes_b.each do |row|
            criteria = {@join[:column_a] => row[@join[:column_b]]}
            row.delete(@join[:column_b])
            update_operation(array_of_hashes_a, criteria, row)
        end
        return array_of_hashes_a

    end

    def nice_print_selection(returns)

        if !returns
            return
        end

        if returns.length == 0
            puts "Request has no returns"
        else
            puts returns.first.keys.join(' | ')
            len = returns.first.keys.join(' | ').length
            puts "-" * len
            returns.each do |row|
                puts row.values.join(' | ')
            end
            puts "-" * len
        end

    end

 
    # run all request

    def run

        if @table_name != nil
            array_of_hashes = convert_csv_to_hash(@table_name)
        else
            puts "Add table/csv name"
            return
        end

        if @request == 'select'
            if @join != nil
                array_of_hashes = run_join_op
            end

            if @order_query != nil 
                array_of_hashes = order_operation(array_of_hashes, order_query[:order], @order_query[column_name])
            end

            if @where != nil
                array_of_hashes = where_operation(array_of_hashes, {@where[:column] => @where[:value]})
            end

            if @columns != nil && @table_name != nil
                result = get_hash_columns(array_of_hashes, @columns)
                nice_print_selection(result)
                return result
            else
                puts "No columns to select"
                return
            end
        end

        if @request == 'insert'
            if @data != nil
                array_of_hashes = insert_operation(array_of_hashes, @data)
            end
            write_to_db(array_of_hashes,  @table_name)
            return current_insert = array_of_hashes[(array_of_hashes.length) - 1]
        end

        if @request == 'update'
            if @where != nil
                @where = {@where[:column] => @where[:value]}
            end
            array_of_hashes = update_operation(array_of_hashes, @where, @data)
            write_to_db(array_of_hashes, @table_name)
            return @data
        end

        if @request == 'delete'
            if @where != nil
                @where = {@where[:column] => @where[:value]}
            end
            array_of_hashes = delete_operations(array_of_hashes, @where)
            write_to_db(array_of_hashes, @table_name)
            return array_of_hashes
        end

        @request = nil
        @where = nil
        @table_name = nil
        @data = nil
        @join = nil

    end

end