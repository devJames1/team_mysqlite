require_relative '../my_sqlite_cli'
require_relative '../my_sqlite_request'

## Before you run test comment the run() function call at the last line in 
## my_sqlite_cli.rb file, to avoid multiple calls.  
##

describe "MySqliteCli" do
    subject { MySqliteRequest.new }

    describe "SELECT" do
        context "SELECT query *(all) FROM table" do
            it "displays all rows in the table" do
                return_data = subject.from('testcli.csv').select("*").run
                expect(execute_request("SELECT * FROM testcli.csv;")).to eq(return_data)
            end
        end

        context "SELECT column,column  FROM table WHERE column='value'" do
            it "gets/displays the columns of the criteria/row(s) specified" do
                return_data = subject.from('testcli.csv').select(["name", "weight"]).where("name", "Gamax").run
                expect(execute_request("SELECT name,weight FROM testcli.csv WHERE name=Gamax;")).to eq(return_data)
            end
        end
    end

    # the tested format is a bit formatted for testing purposes. uncomment to test INSERT

    # describe "INSERT" do
    #     context "Insert into table new row with values" do
    #         it "returns the row inserted" do
    #             return_data = subject.insert("testcli.csv").values('name' => 'James', 'year_start' => '1991', 'year_end' => '1995', 'position' => 'F-C', 'height' => '6-10', 'weight' => '240', 'birth_date' => "1994", 'college' => 'Duke-University').run
    #             expect(execute_request("INSERT INTO testcli.csv VALUES James,1991,1995,F-C,6-10,240,1994,Duke-University;")).to eq(return_data)
    #         end
    #     end
    # end

    
    describe "UPDATE" do
        context "when given criteria(column)" do
            it "updates the specified data" do
                return_data = subject.update("testcli.csv").values("birth_date" => "June-9-2000").where("name", "James").run
                expect(execute_request("UPDATE testcli.csv SET birth_date=June-9-2000 WHERE name=James;")).to eq(return_data)
            end
        end
    end

    describe "DELETE" do
        context "when given a WHERE colunm=value" do 
            it "deletes row/record" do
                return_data = subject.from('testcli.csv').select("*").run
                expect(execute_request("DELETE FROM testcli.csv WHERE name=James;")).not_to eq(return_data)
            end
        end
    end
            
end
        