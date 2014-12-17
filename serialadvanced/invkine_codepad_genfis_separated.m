
l1 = 10; % length of first arm
l2 = 7; % length of second arm
l3 = 7;

theta1 = 0:0.1:pi/2; % all possible theta1 values
theta2 = 0:0.1:pi; % all possible theta2 values
theta3 = 0:0.1:pi; % all possible theta3 values

[THETA1, THETA2, THETA3] = ndgrid(theta1, theta2, theta3); % generate a grid of theta1 and theta2 values

X = l1 * cos(THETA1) + l2 * cos(THETA1 + THETA2) + l3 * cos(THETA1 + THETA2 + THETA3); % compute x coordinates
Y = l1 * sin(THETA1) + l2 * sin(THETA1 + THETA2) + l3 * sin(THETA1 + THETA2 + THETA3); % compute y coordinates

datainfull = [X(:) Y(:)]; % create x-y-theta1 dataset
dataoutfull = [THETA1(:)]; % create x-y-theta2 dataset
dataoutfull2 = [THETA2(:)];
dataoutfull3 = [THETA3(:)];

fistmat1 = generate_genfis( datainfull, dataoutfull, 0 );
progress_status = '1 done'
ruleview(fistmat1)

fismat2 = generate_genfis( datainfull, dataoutfull2, 0 );
progress_status = '2 done'
ruleview(fismat2)

fismat3 = generate_genfis( datainfull, dataoutfull3, 0 );
ruleview(fismat3)
progress_status = '3 done'

progress_status = 'finished'