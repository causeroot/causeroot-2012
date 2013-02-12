require 'csv'

class Graph
  # attr_accessible :title, :body
  def self.grabdata(uId=0)
    
    idata_all = {}
    repeat = 0
    
    while repeat < 2 do
    
        if repeat == 0
            @game_data = GameResult.all
        elsif repeat == 1
            @game_data = GameResult.where({:user_id => uId})
            repeat = 3
        end
    
        # num_of_entries = @game_data.size
        
    ####### IDENTIFY THE BOUNDS OF THE DATASET ########
              
        idata = {}
        question_temp = []
        problem_temp1 = []
        problem_temp2 = []
        user_temp = []
        
        @game_data.each do |value|
            if value.skip == false && value.same == false
                question_temp << value.question_id
                problem_temp1 << value.issue_ids[0]
                problem_temp1 << value.issue_ids[1]
                problem_temp2 << value.issue_ids.sort
                user_temp << value.user_id
            end
        end
    
        # Define an array of the Question ID's in the subset of data chosen 
        question_set = question_temp.uniq.sort  
        
        # Define an array of the Problem ID's in the subset of data chosen
        problem_set = problem_temp1.uniq.sort
        
        # Define an array of the User ID's in the subset of data chosen
        user_set = user_temp.uniq.sort
        
        # TODO: FIGURE HOW WE WOULD REALLY WANT TO USE THIS VARIABLE
        unique_pairs = problem_temp2.uniq.length #
    
    ######## CALCULATE RANKING DATA FOR ALL QUESTIONS #########
      
        problem_set.each do |j|
            # Create data arrays corresponding for each problem, where each array will have values
            # corresponding to each of questions in the question_set
            idata = idata.merge(j => {})
        end
    
        question_set.each do |i|
            problem_key = Array.new(problem_set.length) { Array.new(2,0) };
            @game_data.each do |item|
            # Exclude all entries where the user skipped Q's or said they were the same
                if item.skip == false && item.same == false
                    if item.question_id == i
                      #problem_key[problem_set.index(item.issue_ids[0])][0] = problem_key[problem_set.index(item.issue_ids[0])][0]+1
                       #problem_key[problem_set.index(item.issue_ids[1])][1] = problem_key[problem_set.index(item.issue_ids[1])][1]+1 
                                   
                        if item.answer == item.issue_ids[0]
                            problem_key[problem_set.index(item.issue_ids[0])][0] = problem_key[problem_set.index(item.issue_ids[0])][0]+1
                            problem_key[problem_set.index(item.issue_ids[1])][1] = problem_key[problem_set.index(item.issue_ids[1])][1]-1
                        end
                        if item.answer == item.issue_ids[1]
                            problem_key[problem_set.index(item.issue_ids[0])][0] = problem_key[problem_set.index(item.issue_ids[0])][0]-1
                            problem_key[problem_set.index(item.issue_ids[1])][1] = problem_key[problem_set.index(item.issue_ids[1])][1]+1
                        end  
                    end
                end
            end
        
            # boundry_case = problem_key.max_by {|a,b| [a.abs,b.abs].max}
            # offset = [boundry_case[0].abs,boundry_case[1].abs].max
                 
            boundry_case_max = problem_key.max_by{|a,b| a+b}.sum
            boundry_case_min = problem_key.min_by{|a,b| a+b}.sum
            offset = boundry_case_max-boundry_case_min 
 
            if repeat == 0
                problem_set.each do |k|   
                    if offset == 0
                        entry = 0.5
                    #TODO: Contemplate whether we want to if NO data, for all of it to be smack at 0.5? (is it doing this already?)
                    else
                        entry = (problem_key[problem_set.index(k)][0].to_f+problem_key[problem_set.index(k)][1].to_f-boundry_case_min)/(offset) 
                    end
    
                    if i==1
                        temp = idata[k]            
                        idata[k] = {i => entry}
                    else
                        temp = idata[k]            
                        idata[k] = {i => entry}.merge(temp)
                    end
                end
            elsif repeat == 3
                problem_set.each do |k|        
                    if problem_key[problem_set.index(k)] == [0,0]
                        entry = idata_all[k][i]
                    else
                        entry = (problem_key[problem_set.index(k)][0].to_f+problem_key[problem_set.index(k)][1].to_f-boundry_case_min)/(offset) 
                    end
            
                    if i==1
                        temp = idata[k]            
                        idata[k] = {i => entry}
                    else
                        temp = idata[k]            
                        idata[k] = {i => entry}.merge(temp)
                    end
                end
            end
        end
        
        if uId == 0
            repeat = 3
        elsif repeat == 0
            idata_all = idata
            repeat = 1
        end
#            repeat = 2
#        end
        
        ######### WRITE THE CALCULATED DATA TO CSV FILE ###########
        #TODO: Limit the numbers that are being written here      
    end
    
    question_Themes = []
    
    # TODO questions = Question.all
    questions = YAML::load_file('db/questions.yml')
    questions.values.each do |q|
        question_Themes << q['name']
    end;
    
    problems = []
    
    Issue.uniq.each do |i|
        problems << i.problem
    end;

    csvstr = CSV.generate() do |csv|
      csv << ["Problem Name"] + question_set.map{|i| question_Themes[i-1] }
      idata.each do |k,v|    
          csv <<  ["#{problems[k-1]}"] + (question_set.map{|i| %Q[#{v[i]}] })
      end
    end;
    
    csvstr
  end
end

# idata_all = {}
#  => {} 
# 1.9.3p194 :1582 >     repeat = 0
#  => 0 
# 1.9.3p194 :1583 >     
# 1.9.3p194 :1584 >       while repeat < 2 do
# 1.9.3p194 :1585 >         
# 1.9.3p194 :1586 >             if repeat == 0
# 1.9.3p194 :1587?>                 @game_data = GameResult.all
# 1.9.3p194 :1588?>             elsif repeat == 1
# 1.9.3p194 :1589?>                 @game_data = GameResult.where({:user_id => uId})
# 1.9.3p194 :1590?>                 repeat = 3
# 1.9.3p194 :1591?>             end
# 1.9.3p194 :1592?>       
# 1.9.3p194 :1593 >             # num_of_entries = @game_data.size
# 1.9.3p194 :1594 >             
# 1.9.3p194 :1595 >         ####### IDENTIFY THE BOUNDS OF THE DATASET ########
# 1.9.3p194 :1596 >                   
# 1.9.3p194 :1597 >             idata = {}
# 1.9.3p194 :1598?>           question_temp = []
# 1.9.3p194 :1599?>           problem_temp1 = []
# 1.9.3p194 :1600?>           problem_temp2 = []
# 1.9.3p194 :1601?>           user_temp = []
# 1.9.3p194 :1602?>           
# 1.9.3p194 :1603 >             @game_data.each do |value|
# 1.9.3p194 :1604 >                   if value.skip == false && value.same == false
# 1.9.3p194 :1605?>                       question_temp << value.question_id
# 1.9.3p194 :1606?>                       problem_temp1 << value.issue_ids[0]
# 1.9.3p194 :1607?>                       problem_temp1 << value.issue_ids[1]
# 1.9.3p194 :1608?>                       problem_temp2 << value.issue_ids.sort
# 1.9.3p194 :1609?>                       user_temp << value.user_id
# 1.9.3p194 :1610?>                   end
# 1.9.3p194 :1611?>             end
# 1.9.3p194 :1612?>       
# 1.9.3p194 :1613 >             # Define an array of the Question ID's in the subset of data chosen 
# 1.9.3p194 :1614 >             question_set = question_temp.uniq.sort  
# 1.9.3p194 :1615?>           
# 1.9.3p194 :1616 >             # Define an array of the Problem ID's in the subset of data chosen
# 1.9.3p194 :1617 >             problem_set = problem_temp1.uniq.sort
# 1.9.3p194 :1618?>           
# 1.9.3p194 :1619 >             # Define an array of the User ID's in the subset of data chosen
# 1.9.3p194 :1620 >             user_set = user_temp.uniq.sort
# 1.9.3p194 :1621?>           
# 1.9.3p194 :1622 >             # TODO: FIGURE HOW WE WOULD REALLY WANT TO USE THIS VARIABLE
# 1.9.3p194 :1623 >             unique_pairs = problem_temp2.uniq.length #
# 1.9.3p194 :1624?>       
# 1.9.3p194 :1625 >         ######## CALCULATE RANKING DATA FOR ALL QUESTIONS #########
# 1.9.3p194 :1626 >           
# 1.9.3p194 :1627 >             problem_set.each do |j|
# 1.9.3p194 :1628 >                   # Create data arrays corresponding for each problem, where each array will have values
# 1.9.3p194 :1629 >                   # corresponding to each of questions in the question_set
# 1.9.3p194 :1630 >                   idata = idata.merge(j => {})
# 1.9.3p194 :1631?>             end
# 1.9.3p194 :1632?>       
# 1.9.3p194 :1633 >             question_set.each do |i|
# 1.9.3p194 :1634 >                   problem_key = Array.new(problem_set.length) { Array.new(2,0) };
# 1.9.3p194 :1635 >           
# 1.9.3p194 :1636 >                   @game_data.each do |item|
# 1.9.3p194 :1637 >                         # Exclude all entries where the user skipped Q's or said they were the same
# 1.9.3p194 :1638 >                         if item.skip == false && item.same == false
# 1.9.3p194 :1639?>                             if item.question_id == i
# 1.9.3p194 :1640?>                                   #problem_key[problem_set.index(item.issue_ids[0])][0] = problem_key[problem_set.index(item.issue_ids[0])][0]+1
# 1.9.3p194 :1641 >                                     #problem_key[problem_set.index(item.issue_ids[1])][1] = problem_key[problem_set.index(item.issue_ids[1])][1]+1 
# 1.9.3p194 :1642 >                                     
# 1.9.3p194 :1643 >                                     if item.answer == item.issue_ids[0]
# 1.9.3p194 :1644?>                                         problem_key[problem_set.index(item.issue_ids[0])][0] = problem_key[problem_set.index(item.issue_ids[0])][0]+1
# 1.9.3p194 :1645?>                                         problem_key[problem_set.index(item.issue_ids[1])][1] = problem_key[problem_set.index(item.issue_ids[1])][1]-1
# 1.9.3p194 :1646?>                                     end
# 1.9.3p194 :1647?>                                   if item.answer == item.issue_ids[1]
# 1.9.3p194 :1648?>                                         problem_key[problem_set.index(item.issue_ids[0])][0] = problem_key[problem_set.index(item.issue_ids[0])][0]-1
# 1.9.3p194 :1649?>                                         problem_key[problem_set.index(item.issue_ids[1])][1] = problem_key[problem_set.index(item.issue_ids[1])][1]+1
# 1.9.3p194 :1650?>                                     end  
# 1.9.3p194 :1651?>                               end
# 1.9.3p194 :1652?>                         end
# 1.9.3p194 :1653?>                   end
# 1.9.3p194 :1654?>         
# 1.9.3p194 :1655 >                  # boundry_case = problem_key.max_by {|a,b| [a.abs,b.abs].max}
# 1.9.3p194 :1656 >                  # offset = [boundry_case[0].abs,boundry_case[1].abs].max
# 1.9.3p194 :1657 >                  
# 1.9.3p194 :1658 >                   boundry_case_max = problem_key.max_by{|a,b| a+b}.sum
# 1.9.3p194 :1659?>                 boundry_case_min = problem_key.min_by{|a,b| a+b}.sum
# 1.9.3p194 :1660?>                 offset = boundry_case_max-boundry_case_min
# 1.9.3p194 :1661?>
# 1.9.3p194 :1662 >                   if repeat == 0
# 1.9.3p194 :1663?>                       problem_set.each do |k|   
# 1.9.3p194 :1664 >                               entry = 0.5
# 1.9.3p194 :1665?>                             #TODO: Contemplate whether we want to if NO data, for all of it to be smack at 0.5? (is it doing this already?)
# 1.9.3p194 :1666 >                               unless offset == 0
# 1.9.3p194 :1667?>                                   entry = (problem_key[problem_set.index(k)][0].to_f+problem_key[problem_set.index(k)][1].to_f-boundry_case_min)/(offset) 
# 1.9.3p194 :1668?>                               end
# 1.9.3p194 :1669?>                             
# 1.9.3p194 :1670 >                               if i==1
# 1.9.3p194 :1671?>                                   temp = idata[k]            
# 1.9.3p194 :1672?>                                   idata[k] = {i => entry}
# 1.9.3p194 :1673?>                               else
# 1.9.3p194 :1674 >                                     temp = idata[k]            
# 1.9.3p194 :1675?>                                   idata[k] = {i => entry}.merge(temp)
# 1.9.3p194 :1676?>                               end
# 1.9.3p194 :1677?>                         end
# 1.9.3p194 :1678?>                   elsif repeat == 3
# 1.9.3p194 :1679?>                       problem_set.each do |k|        
# 1.9.3p194 :1680 >                               if problem_key[problem_set.index(k)] == [0,0]
# 1.9.3p194 :1681?>                                   entry = idata_all[k][i]
# 1.9.3p194 :1682?>                               else
# 1.9.3p194 :1683 >                                     entry = (problem_key[problem_set.index(k)][0].to_f+problem_key[problem_set.index(k)][1].to_f-boundry_case_min)/(offset) 
# 1.9.3p194 :1684?>                               end
# 1.9.3p194 :1685?>                     
# 1.9.3p194 :1686 >                               if i==1
# 1.9.3p194 :1687?>                                   temp = idata[k]            
# 1.9.3p194 :1688?>                                   idata[k] = {i => entry}
# 1.9.3p194 :1689?>                               else
# 1.9.3p194 :1690 >                                     temp = idata[k]            
# 1.9.3p194 :1691?>                                   idata[k] = {i => entry}.merge(temp)
# 1.9.3p194 :1692?>                               end
# 1.9.3p194 :1693?>                         end
# 1.9.3p194 :1694?>                   end
# 1.9.3p194 :1695?>             end
# 1.9.3p194 :1696?>           
# 1.9.3p194 :1697 >             if uId == 0
# 1.9.3p194 :1698?>                 repeat = 3
# 1.9.3p194 :1699?>             elsif repeat == 0
# 1.9.3p194 :1700?>                 idata_all = idata
# 1.9.3p194 :1701?>                 repeat = 1
# 1.9.3p194 :1702?>             end
# 1.9.3p194 :1703?>   #            repeat = 2
# 1.9.3p194 :1704 >     #        end
# 1.9.3p194 :1705 >             
# 1.9.3p194 :1706 >             ######### WRITE THE CALCULATED DATA TO CSV FILE ###########
# 1.9.3p194 :1707 >             #TODO: Limit the numbers that are being written here      
# 1.9.3p194 :1708 >         end
