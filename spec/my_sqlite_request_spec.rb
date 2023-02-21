require_relative '../my_data_process_op'
require_relative '../my_sqlite_request'

describe MySqliteRequest do

    subject { MySqliteRequest.new }

    # describe "#select" do

    #     # if test.csv file is not edited
    #     context "Given a column" do
    #         it "returns the array of data in the column" do
    #             expect(subject.from('test.csv').select("name").run).to eq([{"name" => "Alaa Abdelnaby"},{"name" => "Zaid Abdul-Aziz"},{"name" => "Kareem Abdul-Jabbar"},{"name" => "Prince Gamax"}])
    #         end
    #     end

    # end

    describe "#where" do

        # if test.csv file is not edited
        context "Given a column and value" do
            it "returns the column in select where('column'='value')" do
                expect(subject.from('test.csv').select("name").where("college", "University of California, Los Angeles").run).to eq([{"name" => "Kareem Abdul-Jabbar"}])
            end
        end
        
        #multiple where request
        context "given multiple where in one request" do
            it "returns the column in select where('column1'='value1') and where('column2'='value2')" do
                expect(subject.from('test.csv').select("name").where("year_start", "1991").where("college", "Louisiana State University").run).to eq([{"name" => "Prince Gamax"}])
            end
        end

    end

    # if test.csv file is not edited
    describe "#update" do
        context "given values{'column' => 'value'} to update in table where('column', 'value')" do
            it "update values in table row(s) and returns updated row" do
                expect(subject.update("test.csv").values("birth_date" => "March 9, 1980").where("name", "Prince Gamax").run).to eq({'birth_date' => "March 9, 1980"})
            end
        end
    end

    #uncomment block below to test 'insert' and 'delete', it add/remove row in the table, so after 'insert' or 'delete', 'select', 'where', 'update' tests may have to be updated.

    # ============================================================================

    # describe "#insert" do
    #     context "given row to insert into table" do
    #         it "inserts row into table columns and returns updated array of hash" do
    #             expect(subject.insert("test.csv").values('name' => 'Alaa Abdelnaby', 'year_start' => '1991', 'year_end' => '1995', 'position' => 'F-C', 'height' => '6-10', 'weight' => '240', 'birth_date' => "June 24, 1968", 'college' => 'Duke University').run).to eq({'name' => 'Alaa Abdelnaby', 'year_start' => '1991', 'year_end' => '1995', 'position' => 'F-C', 'height' => '6-10', 'weight' => '240', 'birth_date' => "June 24, 1968", 'college' => 'Duke University'})
    #         end
    #     end
    # end


    # if test.csv file is not edited
    # describe '#delete' do
    #     context "given a from(table_name) and where(column, value)" do
    #          it "deletes the row from the table" do
    #             expect(subject.delete().from('spec/test.csv').where("name", "Alaa Abdelnaby").run).not_to eq([{"name"=>"Alaa Abdelnaby", "year_start"=>"1991", "year_end"=>"1995", "position"=>"F-C", "height"=>"6-10", "weight"=>"240", "birth_date"=>"June 24, 1968", "college"=>"Duke University"}, 
    #             {"name"=>"Zaid Abdul-Aziz", "year_start"=>"1969", "year_end"=>"1978", "position"=>"C-F", "height"=>"6-9", "weight"=>"235", "birth_date"=>"April 7, 1946", "college"=>"Iowa State University"}, {"name"=>"Kareem Abdul-Jabbar", "year_start"=>"1970", "year_end"=>"1989", "position"=>"C", "height"=>"7-2", "weight"=>"225", "birth_date"=>"April 16, 1947", "college"=>"University of California, Los Angeles"}, {"name"=>"Prince Gamax", "year_start"=>"1991", "year_end"=>"2001", "position"=>"G", "height"=>"6-1", "weight"=>"162", "birth_date"=>"March 9, 1980", "college"=>"Louisiana State University"}])
    #         end
    #     end
    # end
        
end