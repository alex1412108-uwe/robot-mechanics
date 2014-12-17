function [ fismat ] = generate_genfis( datainfull, dataoutfull, plot_1 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[rows, cols] = size(datainfull);
datain = datainfull(1:rows*.75,:);
chkdatain = datainfull(1:rows*.25,:);

[rows, cols] = size(dataoutfull);
dataout = dataoutfull(1:rows*.75,:);
chkdataout = dataoutfull(1:rows*.25,:);


%subplot(2,1,1), plot(datain);
%subplot(2,1,2), plot(dataout);


fismat=genfis2(datain,dataout,0.5);

fuzout=evalfis(datain,fismat);
trnRMSE=norm(fuzout-dataout)/sqrt(length(fuzout));
chkfuzout=evalfis(chkdatain,fismat);
chkRMSE=norm(chkfuzout-chkdataout)/sqrt(length(chkfuzout))

if isequal (plot_1, 1)
figure
plot(chkdataout)
hold on
plot(chkfuzout,'o')
hold off
end

%At this point, we can use the optimization capability of anfis to improve the model. First, we will try using a relatively short anfis training (20 epochs) 
%without implementing the checking data option, but test the resulting FIS model against the test data. The command-line version of this is as follows.

fismat2=anfis([datain dataout],fismat,[20 0 0.1]);

%After the training is done, we type

    fuzout2=evalfis(datain,fismat2);
    trnRMSE2=norm(fuzout2-dataout)/sqrt(length(fuzout2));
   
    chkfuzout2=evalfis(chkdatain,fismat2);
    chkRMSE2=norm(chkfuzout2-chkdataout)/sqrt(length(chkfuzout2));

if isequal (plot_1, 1)
 figure
 plot(chkdataout)
 hold on
 plot(chkfuzout2,'o')
 hold off
end

% what happens if we carry out a longer (200 epoch) training of this system using anfis, including its checking data option.

[fismat3,trnErr,stepSize,fismat4,chkErr]= ...
        anfis([datain dataout],fismat2,[200 0 0.1],[], ...
        [chkdatain chkdataout]);

if isequal (plot_1, 1)
    figure
plot(trnErr)
title('Training Error')
xlabel('Number of Epochs')
ylabel('Training Error')
end

if isequal (plot_1, 1)
figure
plot(chkErr)
title('Checking Error')
xlabel('Number of Epochs')
ylabel('Checking Error')
end
end

