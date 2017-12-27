#!/bin/bash 
show_menu()
{
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    echo -e "${MENU}**********************APP MENU***********************${NORMAL}"
    echo -e "${MENU}**${NUMBER} 1)${MENU} Question 1a ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2)${MENU} Question 1b ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 3)${MENU} Question 2a ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 4)${MENU} Question 2b ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 5)${MENU} Question 3 ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 6)${MENU} Question 4 ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 7)${MENU} Question 5a ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 8)${MENU} Question 5b ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 9)${MENU} Question 6 ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 10)${MENU} Question 7 ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 11)${MENU} Question 8 ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 12)${MENU} Question 9 ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 13)${MENU} Question 10 ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 14)${MENU} Question 11 ${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter a menu option and enter or ${RED_TEXT}enter to exit. ${NORMAL}"
    read opt
}
function option_picked() 
{
    COLOR='\033[01;31m' # bold red
    RESET='\033[00;00m' # normal white
    MESSAGE="$1"  #modified to post the correct option selected
    echo -e "${COLOR}${MESSAGE}${RESET}"
}

function getpinCodeBank(){
	echo "in getPinCodebank"
	echo $1
	echo $2
	#hive -e "Select * from AppData where PinCode = $1 AND Bank = '$2'"
}

clear
show_menu
while [ opt != '' ]
    do
    if [[ $opt = "" ]]; then 
            exit;
    else
        case $opt in
        1) clear;
	option_picked "1a) Is the number of petitions with Data Engineer job title increasing over time?";
        bash /home/hduser/Desktop/1a.sh
	show_menu;
        ;;

        2) clear;
	option_picked "1b) Find top 5 job titles who are having highest avg growth in applications.";
        pig /home/hduser/project/project1b.pig
        show_menu;
        ;;
            
        3) clear;
	option_picked "2a) Which part of the US has the most Data Engineer jobs for each year?";
   	bash /home/hduser/Desktop/2a.sh
        show_menu;
        ;;
	
        4) clear;
        option_picked "2b) find top 5 locations in the US who have got certified visa for each year";
        echo "Enter the year"
        read year
        echo "You've selected ${year}"
	hive -e "select year, worksite, count(*) as n from h1b_final where year=$year and case_status='CERTIFIED' group by  year, worksite order by n desc limit 5;" 
        show_menu;
        ;;
            
	5) clear;
        option_picked "3)Which industry(SOC_NAME) has the most number of Data Scientist positions?";
        hive -e "select soc_name,job_title,count(job_title) as n from h1b_final where job_title='DATA SCIENTIST' and case_status='CERTIFIED' group by soc_name,job_title order by n desc limit 1;"
        show_menu;
        ;;
                    
        6) clear;
        option_picked "4)Which top 5 employers file the most petitions each year?";
	bash /home/hduser/Desktop/4.sh
        show_menu;
        ;;
        
        7) clear;
        option_picked "5) Find the most popular top 10 job positions for H1B visa applications for each year?a) for all the applications";
	echo "Enter the year"
	read year
	echo "You've selected ${year}"
	hive -e "select year, job_title, count(job_title) as n from h1b_final where year=$year group by year, job_title order by n desc limit 10;"		
	show_menu;
        ;;
        
	    8) clear;
        option_picked "5) Find the most popular top 10 job positions for H1B visa applications for each year?b) for only certified applications.";
	echo "Enter the year"
	read year
	echo "You've selected ${year}"
	hive -e "select year, job_title, count(job_title) as n from h1b_final where year=$year and case_status='CERTIFIED' group by year, job_title order by n desc limit 10;"
        show_menu;
        ;;
	
	9) clear;
        option_picked "6) Find the percentage and the count of each case status on total applications for each year. Create a line graph depicting the pattern of All the cases over the period of time.";
	pig /home/hduser/project/project6.pig
        show_menu;
        ;;

	10) clear;
        option_picked "7) Create a bar graph to depict the number of applications for each year";
	bash /home/hduser/Desktop/7.sh
        show_menu;
        ;;

	11) clear;
        option_picked "8) Find the average Prevailing Wage for each Job for each Year (take part time and full time separate). Arrange the output in descending order";
	 echo -e "${MENU}Select Full Time Job or Part Time Job ${NORMAL}"
        echo -e "${MENU}**${NUMBER} 1)${MENU} Full Time Job ${NORMAL}"
        echo -e "${MENU}**${NUMBER} 2)${MENU} Part Time Job ${NORMAL}"
        read job
        case $job in
                1)    echo "FULL TIME JOB SELECTED"
                        pig /home/hduser/project/project8y.pig
                        ;;       
                   
                2)     echo "PART TIME JOB SELECTED"
                                          
                    pig /home/hduser/Proj/Proj8n.pig
                    ;;  
                   *) echo "Please Select one among the option[1-2]";;
                esac
        show_menu;
        ;;
	
	12) clear;
        option_picked "9) Which are the employers along with the number of petitions who have the success rate more than 70%  in petitions. (total petitions filed 1000 OR more than 1000) ?";
	pig /home/hduser/project/project9.pig
        show_menu;
        ;;

	13) clear;
        option_picked "10) Which are the  job positions along with the number of petitions which have the success rate more than 70%  in petitions (total petitions filed 1000 OR more than 1000)?";
	pig /home/hduser/project/project10.pig
        show_menu;
        ;;

	14) clear;
        option_picked "11) Export result for question no 10 to MySql database.";
	sqoop export --connect jdbc:mysql://localhost/project10 --username root --P --table emp --update-mode  allowinsert --update-key job   --export-dir /niit/project10/* --input-fields-terminated-by '\t' ;
        show_menu;
        ;;

        \n) exit;
        ;;

        *) clear;
        option_picked "Pick an option from the menu";
        show_menu;
        ;;
    esac
fi



done


