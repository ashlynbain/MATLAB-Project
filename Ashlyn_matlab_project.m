clear; %clearing the matlab data in the program 
clc;
program = true; %to make the program run continuously 
while program == true
    p = menu('Ashlyn''s Interface','Set Username and Date','Load Data File',...
        'Clear Data From Memory','Set Output Filename','Plot Histogram',...
        'Plot Histogram Fit','Plot Probability Plots',...
        'Find Probability Given x or z','Find x or z given probability',...
        'Exit'); %menu pop-up syle
    switch p
        case 1 %enter the username of the person and date
            fprintf('Please enter your username:\n');
            UserN = input('','s');
            fprintf('Please enter the date:\n'); %date can be in any form
            date = input('','s');
            if UserN == ' ' %if they don't enter username
                UserN = input('Please create a usename.\n','s');
            else
                fprintf('Please Press any key to continue\n')
            end
            pause;
        case 2
            InputD = input('Please Enter the name of the file that you would like to input with extension.\n','s');
            inputd = lower(InputD); %making the coding easier by limiting things that they can enter
            if InputD == ' '
                inputd = input('Please input the file of the data again\n','s');
            elseif isempty(InputD) %checking to see if file has data
                inputd = input('Make sure your file in truly in the system. Try again.\n','s');
            else
                data = load(InputD);
                data = reshape(data,1,[]); %making the coding easier 
                nd = input('Is your data normally distributed? Y or N.\n','s');
                nd = lower(nd); %making the coding easier by limiting things that they can enter
                if nd == 'y'
                    nd = 'Yes';
                elseif nd == 'n'
                    nd = 'No';
                else
                    nd = input('Please enter either y or n.\n','s');
                end
                fprintf('Your file has been uploaded successfully.\n');
            end
            fprintf('Please press any key to continue\n');
            pause;
        case 3
            clearyn = input('Are you sure you want to clear everything? Y or N\n','s');
            clearyn = lower(clearyn); %making the coding easier by limiting things that they can enter
            if clearyn == 'y'
                clc; %giving them the option to clear just incase they 
                %chose the button on accident
                fprintf('Everything has been cleared, you can go to the beggining and re-enter a username.\n');
                pause;
            elseif clearyn == 'n'
                fprintf('Press any button to continue.\n');
            else
                clearyn = input('Please enter Yes or No.\n','s');
            end
        case 4
            outputN = input('Please Enter the name of the file that you would like to output all of your data to.\n','s');
            outputN = strcat(outputN,'.txt');
            Mean  = mean(data);
            %Mean = round(Mean,2);%rounding to make the value have 5 places
            Med = median(data);
            %Med = round(Med,2);
            Mode  = mode(data);
            %Mode = round(Mode,2);
            Var   = var(data);
            %Var = round(Var,2);
            Sdev  = std(data);
            %Sdev = round(Sdev,2);
            Min   = min(data);
            %Min = round(Min,2);
            Max   = max(data);
            %Max = round(Max,2);
            Count = length(data);
            h = [Mean Med Mode Var Sdev Min Max Count];
            %making into an array to make it easier to call values
            fid = fopen(outputN,'w'); %opening the users file
            fprintf(fid,'Username: %s\n',UserN);
            fprintf(fid,'Date: %s\n',date);
            fprintf(fid,'The input data files name is %s.\n', inputd);
            fprintf(fid,'Statistics about %s:\n', inputd);
            fprintf(fid,'Mean  = %.2f\n',h(1));
            fprintf(fid,'Med   = %.2f\n',h(2)); %printing them to the
            %separate file by doing fprintf(fid,...
            fprintf(fid,'Mode  = %.2f\n',h(3));
            fprintf(fid,'Var   = %.2f\n',h(4));
            fprintf(fid,'Sdev  = %.2f\n',h(5));
            fprintf(fid,'Min   = %.2f\n',h(6));
            fprintf(fid,'Max   = %.2f\n',h(7));
            fprintf(fid,'Count = %.f\n',h(8));
            fprintf(fid,'Is this data normally distributed?\n');
            fprintf(fid,'%s\n',nd);
            fclose(fid); %closing users new file
            openit = input('Do you want to open your data? Y or N.\n','s');
            openit = lower(openit);
            if openit == 'y'
                open(outputN); %if they want to open it they have option to
            else
                fprintf('Please continue using the interface.\n');
            end
        case 5
            x = input('Please enter the name of your x lable.\n','s');
            %these are so the user can choose what they want their
            %axis and title to be called
            y = input('Please enter the name of your y lable.\n','s');
            titleD = input('Please enter the name of your title.\n','s');
            bins = input('Please enter the number of bins that you would like to have, I recomend any number between 8 and 12.\n');
            if isempty(data) %checking to see if there is any data
                fprintf('Your input file is empty, try again with another file.\n');
            else
                figure; %to create a seperate figure not on the menu
                histogram(data,bins);
                xlabel(x); %user input names
                ylabel(y);
                title(titleD);
            end
            fprintf('Please press any key to continue.\n');
            pause;
            close all
        case 6
            x = input('Please enter the name of your x lable.\n','s');
            %these are so the user can choose what they want their
            %axis and title to be called
            y = input('Please enter the name of your y lable.\n','s');
            titleD = input('Please enter the name of your title.\n','s');
            bins = input('Please enter the number of bins that you would like to have, I recommend any number between 8 and 12.\n');
            %I told them what their # of bins should be (8-12)
            if isempty(data)
                fprintf('You need to try again and select a file with data encoded.\n');
            else
                data = reshape(data,1,[]);
                figure;
                histfit(data,bins);
                xlabel(x);
                ylabel(y);
                title(titleD);
            end
            fprintf('Please press any key to continue.\n');
            pause;
            close all
        case 7
            fprintf('Please enter the name of your x lable.\n');
            x = input('','s');
            titleD = input('Please enter the name of your title.\n','s');
            if isempty(data)
                fprintf('You need to try again and select a file with data encoded.\n');
            else
                figure;
                probplot(data);
                xlabel(x);
                ylabel('Probability');
                title(titleD);
            end
            fprintf('Please press any key to continue.\n');
            pause;
            close all
        case 8
            nd = input('Is your data normally distributed? Yes or No?\n','s');
            nd = lower(nd); %making the coding easier by limiting things
            %that they can enter
            if nd == 'yes'
                fprintf('Would you like to find probability less than(LT), greater than(GT) or within a range(WR)?\n');
                prob = input('','s');
                prob = lower(prob); %making the coding easier by limiting 
                %things that they can enter
                if prob == 'lt'
                    given = input('Do you know x or z?\n','s');
                    if given == 'x'
                        xval = input('Please input your x-value\n');
                        s = std(data);
                        mu = mean(data);
                        zval = (xval - mu)/ (s);
                        ncdfzx = normcdf(zval);
                        fprintf('Your probability is %0.3f.\n',ncdfzx)
                        %z = (x-mu/sigma);
                    elseif given == 'z'
                        fprintf('What is your z-value?\n');
                        zvalue = input('');
                        ncdfz = normcdf(zvalue);
                        fprintf('Your probability is %0.3f.\n',ncdfz)
                    else
                        nd = input('Please enter either x or z.\n','s');
                    end
                elseif prob == 'gt'
                    fprintf('Do you know x or z?\n');
                    given = input('','s');
                    if given == 'x'
                        xval = input('Please input your x-value\n');
                        s = std(data); %sigma / standard deviation
                        mu = mean(data);
                        zval = (xval - mu)/ (s);
                        ncdfzx = normcdf(zval);
                        bf = 1 - ncdfzx;
                        fprintf('Your probability is %0.3f.\n',bf)
                        %z = (x-mu/sigma);
                    elseif given == 'z'
                        fprintf('What is your z-value?\n');
                        zvalue = input('');
                        ncdfz = normcdf(zvalue);
                        cf = 1 - ncdfz;
                        fprintf('Your probability is %0.3f.\n',cf)
                    else
                        given = input('Please enter x or z.\n','s');
                    end
                elseif prob == 'wr'
                    rangl = input('Please input the lower value of your range.\n','s');
                    rangu = input('Please input the upper value of your range.\n','s');
                    
                    if rangl == ' ' || rangu == ' '
                        fprintf('Please enter the two values of your ranges.\n')
                    else
                        cdful = normcdf(rangu) - normcdf(rangl);
                        fprintf('Your probability is %0.3f.\n',cdful)
                    end
                else
                    prob = input('Please enter LT, GT, or WR.\n','s');
                end
            elseif nd == 'no'
                fprinf('Your data, must be normally distributed. Please try again and input new data.\n');
            else
                fprintf('Please enter Yes or No\n');
            end
            
        case 9
            ques = input('Would you like to find x or z?\n','s');
            ques = lower(ques); %making the coding easier by limiting things that they can enter
            nd = input('Is your data normally distributed? Yes or No.\n','s');
            nd = lower(nd); %limiting options that user can input
            if nd == 'yes'
                if ques == 'x'
                    proba = input('What is the probability of the function?\n');
                    ques2 = input('Was the probability less than(LT), greater than(GT) or within a range(WR)?\n','s');
                    ques2 = lower(ques2); %making the coding easier by limiting things that they can enter
                    if ques2 == 'lt'
                        mu = mean(data); %mu is the mean of the data
                        s = std(data);
                        zval2 = norminv(proba,mu,s);
                        xval2 = ( zval2 .* s ) + mu; %these equations were derived from one given to us in class
                        fprintf('Your x-value is equal to %0.3f.\n',xval2);
                        %z = (x-mu/sigma);
                    elseif ques2 == 'gt'
                        proba = 1 - proba;
                        mu = mean(data);
                        s = std(data);
                        zval2 = norminv(proba,mu,s); %got formula from
                        %class slides
                        xval2 = ( zval2 .* s ) + mu; %got formula from
                        %class slides
                        fprintf('Your x-value is equal to %0.3f.\n',xval2);
                    else
                        fprintf('Please try again and input either lt, gt, or wr.\n');
                    end
                elseif ques == 'z'
                    proba = input('What is the probability of the function?\n'); %no 's' because it is not a scrpit
                    ques2 = input('Was the probability less than(LT), greater than(GT) or within a range(WR)?\n','s');
                    ques2 = lower(ques2); %making the coding easier by limiting things that they can enter
                    if ques2 == 'lt'
                        mu = mean(data); %mean
                        s = std(data); %sigma/standard deviation
                        zval2 = norminv(proba,mu,s);
                        xval2 = ( zval2 .* s ) + mu;
                        fprintf('Your z-value is equal to %0.3f.\n',zval2);
                    elseif ques2 == 'gt'
                        proba = 1 - proba; %probability
                        mu = mean(data); %mean
                        s = std(data); %sigma
                        zval2 = norminv(proba,mu,s); %z
                        xval2 = ( zval2 .* s ) + mu; %x
                        fprintf('Your z-value is equal to %0.3f.\n',zval2);
                    else
                        fprintf('Please input either lt or gt.\n');
                    end
                else
                    fprintf('Please try again and enter either x or z.\n');
                end
            elseif nd == 'no'
                fprintf('The data must be normally distributed.\n');
            else
                fprintf('Please try again and enter either yes or no.\n');
            end
        case 10 %giving them options to close or not
            clc;
            a = input('Are you sure you want to exit the interface? Type ''y'' for Yes.\n','s');
            a = lower(a); %making the coding easier by limiting things 
            %that they can enter
            if (a == 'y') %if they really want to close
                program = false; %closing the program
            else
                fprintf('Press any key to continue.\n');
            end
    end
end
clear;
clc;