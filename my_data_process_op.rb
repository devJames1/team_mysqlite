require "csv"


# array_of_hashes = [{"name" => "tor", "age" => 2, "gender" => "M"}, {...}, {...}]
def convert_csv_to_hash(csv_file)
    array_of_hashes = []

    if File.exist?(csv_file)
        CSV.foreach(csv_file, headers: true) do |row|
            array_of_hashes << row.to_hash
        end
        return array_of_hashes
    else
        puts 'File not found!'
        return
    end
end

# # array_of_hashes = [{"name" => "tor", "age" => 2, "gender" => "M"}, {...}, {...}]
# # result ->> name,birth_state,age
# #           Andre,CA,60
def write_to_csv(array_of_hashes, csv_file)
    headers = array_of_hashes.first.keys

    if array_of_hashes.length != 0
        CSV.open(csv_file, "w") do |csv_hash|
            csv_hash << headers
            array_of_hashes.each do |row|
                csv_hash << row.values
            end
        end
    else
        return
    end
        # first row must be the header
    #     csv << array_of_hashes[0].keys

    #     array_of_hashes.each do |hash|
    #         csv << CSV::Row.new(hash.keys, hash.values)
    #     end
    # end
end

# # array_of_hashes = [{"name" => "tor", "age" => 2, "gender" => "M"}, {...}, {...}]
# # array_of_columns = ["name", "age"] OR string ("name")
# def get_hash_columns(array_of_hashes, array_of_columns)

#     if !array_of_hashes
#         return
#     else
#         result = []
#         array_of_hashes.each do |hash|
#             new_hash = {}
#             if array_of_columns[0] == "*"
#                 result << hash
#             elsif array_of_columns.instance_of? String
#                 new_hash[array_of_columns] = hash[array_of_columns]
#                 result << new_hash
#             else
#                 array_of_columns.each do |column|
#                     new_hash[column] = hash[column]
#                 end
#                 result << new_hash
#             end
#         end
#         return result
#     end

# end

# # array_of_hashes = [{"name" => "tor", "age" => 2, "gender" => "M"}, {...}, {...}]
# # order_type = "asc" OR "desc"
# # column = "name"
# def order_operation(array_of_hashes, order_type, column)
#     0.upto array_of_hashes.length - 1 do |i|
#         i.upto array_of_hashes.length - 1 do |j|
#             line_i = array_of_hashes[i]
#             line_j = array_of_hashes[j]

#             val_i = line_i[column]
#             val_j = line_j[column]

#             if order_type == "asc"
#                 if val_i > val_j
#                     temp_a = array_of_hashes[i]
#                     array_of_hashes[i] = array_of_hashes[j]
#                     array_of_hashes[j] = temp_a
#                 end
#             elsif order_type == "desc"
#                 if val_i < val_j
#                     temp_a = array_of_hashes[i]
#                     array_of_hashes[i] = array_of_hashes[j]
#                     array_of_hashes[j] = temp_a
#                 end
#             end
#         end
#     end
#     return array_of_hashes
# end

# # array_of_hashes = [{"name" => "tor", "age" => 2, "gender" => "M"}, {...}, {...}]
# # new_hash = {"name" => "iva", "age" => 5, "gender" => "F"}
# def insert_operation(array_of_hashes, new_hash)
#     result = []

#     array_of_hashes.each do |row|
#         result.push(row)
#     end

#     result.push(new_hash)
#     return result
# end

# # line_frm_arr_hash = {"name" => "tor", "age" => 2, "gender" => "M"}
# # criteria_hash = {"name" => "tor", "age" => 2}
# # true or false
# def criteria_exist(line_frm_arr_hash, criteria_hash)
#     if criteria_hash == nil
#         return true
#     end
#     criteria_hash.each do |key, value|
#         if value != line_frm_arr_hash[key]
#             return false
#         end
#     end
#     return true
# end

# # line_frm_arr_hash = {"name" => "tor", "age" => 2, "gender" => "M"} 
# # update_hash = {"name" => "tor", "age" => 555}
# def update_row(line_frm_arr_hash, update_hash)
#     update_hash.each do |key, value|
#         line_frm_arr_hash[key] = value
#     end
#     return line_frm_arr_hash
# end

# # array_of_hashes= [{"name" => "tor", "age" => 2, "gender" => "M"}, {...}, {...}]
# # criteria_hash = {"name" => "tor", "age" => 2}
# # update_hash = {"name" => "tor", "age" => 555, "gender" => "M"}
# def update_operation(array_of_hashes, criteria_hash, update_hash)
#     result = []
#     array_of_hashes.each do |row|
#         if criteria_exist(row, criteria_hash)
#             updated_row = update_row(row, update_hash)
#             result << updated_row
#         else
#             result << row
#         end
#     end
#     return result
# end

# # array_of_hashes = [{"name" => "Andre", "birth_state" => "CA", "age" => 60}, {...}, {...}]
# # criteria_hash = {"birth_state" => "CA"}
# def where_operation(array_of_hashes, criteria_hash)
#     result = []
#     array_of_hashes.each do |row|
#         if criteria_exist(row, criteria_hash)
#             result << row
#         end
#     end
#     return result
# end

# # array_of_hashes = [{"name" => "Andre", "birth_state" => "CA", "age" => 60}, {...}, {...}]
# # criteria_hash = {"birth_state" => "CA"}
# def delete_operations(array_of_hashes, criteria_hash)
#     result = []
#     if criteria_hash != nil
#         array_of_hashes.each do |row|
#             if criteria_exist(row, criteria_hash)
#                 next
#             else
#                 result << row
#             end
#         end
#     end
#     return result
# end



####################################
## Tests
####################################
my_csv_file = 'students.csv'
my_array_of_hashes = [{"name"=>"James", "email"=>"james@james.com", "grade"=>"A+", "blog"=>"https://blog.jamendoe.com"}]
my_csv_hash = convert_csv_to_hash(my_csv_file)

my_array_of_hashes.select do |rows|
    my_csv_hash << rows
end

write_to_csv(my_csv_hash, 'students.csv')