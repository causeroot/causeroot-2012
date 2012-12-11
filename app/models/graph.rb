class Graph < ActiveRecord::Base
  # attr_accessible :title, :body
  def game_extractor
    
  end
  
  def 
        
        
        CSV.open("extracted_data.csv","wb") do |csv|
        csv << ["'Names'"] + question_set.map{|i| Attributes_Titles[i] }
        idata.each do |k,v|    
            csv << [Problems[k]] + (question_set.map{|i| v[i] })
        end;
    end;
  end
end
