
l1 = 10; % length of first arm
l2 = 7; % length of second arm

theta1 = 0:0.1:pi/2; % all possible theta1 values
theta2 = 0:0.1:pi; % all possible theta2 values

[THETA1, THETA2] = meshgrid(theta1, theta2); % generate a grid of theta1 and theta2 values

X = l1 * cos(THETA1) + l2 * cos(THETA1 + THETA2); % compute x coordinates
Y = l1 * sin(THETA1) + l2 * sin(THETA1 + THETA2); % compute y coordinates

datainfull = [X(:) Y(:)]; % create x-y-theta1 dataset
dataoutfull = [THETA1(:) THETA2(:)]; % create x-y-theta2 dataset

[rows, cols] = size(datainfull);
datain = datainfull(1:rows*.75,:);
dataout = dataoutfull(1:rows*.75,:);
chkdatain = datainfull(1:rows*.25,:);
chkdataout = dataoutfull(1:rows*.25,:);

% In this example we apply the genfis2 function to model the relationship between the number of automobile trips generated from an area and the area's 
% demographics. Demographic and trip data are from 100 traffic analysis zones in New Castle County, Delaware. Five demographic factors are considered:
% population, number of dwelling units, vehicle ownership, median household income, and total employment.
% Hence the model has five input variables and one output variable. 



subplot(2,1,1), plot(datain);
subplot(2,1,2), plot(dataout);
 

fismat=genfis2(datain,dataout,0.5)

fuzout=evalfis(datain,fismat);
trnRMSE=norm(fuzout-dataout)/sqrt(length(fuzout));
chkfuzout=evalfis(chkdatain,fismat);
chkRMSE=norm(chkfuzout-chkdataout)/sqrt(length(chkfuzout))

figure
plot(chkdataout)
hold on
plot(chkfuzout,'o')
hold off

%At this point, we can use the optimization capability of anfis to improve the model. First, we will try using a relatively short anfis training (20 epochs) 
%without implementing the checking data option, but test the resulting FIS model against the test data. The command-line version of this is as follows.

fismat2=anfis([datain dataout],fismat,[20 0 0.1]);

%After the training is done, we type

    fuzout2=evalfis(datain,fismat2);
    trnRMSE2=norm(fuzout2-dataout)/sqrt(length(fuzout2));
   
    chkfuzout2=evalfis(chkdatain,fismat2);
    chkRMSE2=norm(chkfuzout2-chkdataout)/sqrt(length(chkfuzout2));

 figure
 plot(chkdataout)
 hold on
 plot(chkfuzout2,'o')
 hold off


% what happens if we carry out a longer (200 epoch) training of this system using anfis, including its checking data option.

[fismat3,trnErr,stepSize,fismat4,chkErr]= ...
        anfis([datain dataout],fismat2,[200 0 0.1],[], ...
        [chkdatain chkdataout]);

    figure
plot(trnErr)
title('Training Error')
xlabel('Number of Epochs')
ylabel('Training Error')

figure
plot(chkErr)
title('Checking Error')
xlabel('Number of Epochs')
ylabel('Checking Error')

