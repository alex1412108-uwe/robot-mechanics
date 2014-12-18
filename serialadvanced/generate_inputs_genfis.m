function [ datainfull, dataoutfull, dataoutfull2, dataoutfull3 ] = generate_inputs_genfis( spacing, offset )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

l1 = 93; % length of first arm
l2 = 108; % length of second arm
l3 = 33;


theta1 = 0 + offset:spacing:pi - offset; % all possible theta1 values
theta2 = -pi+((10*pi)/180) + offset:spacing:0 - offset; % all possible theta2 values
theta3 = -pi + offset:spacing:0 - offset; % all possible theta3 values

[THETA1, THETA2, THETA3] = ndgrid(theta1, theta2, theta3); % generate a grid of theta1 and theta2 values

X = l1 * cos(THETA1) + l2 * cos(THETA1 + THETA2) + l3 * cos(THETA1 + THETA2 + THETA3); % compute x coordinates
Y = l1 * sin(THETA1) + l2 * sin(THETA1 + THETA2) + l3 * sin(THETA1 + THETA2 + THETA3); % compute y coordinates

datainfull = [X(:) Y(:)]; % create x-y-theta1 dataset
dataoutfull = [THETA1(:)]; % create x-y-theta2 dataset
dataoutfull2 = [THETA2(:)];
dataoutfull3 = [THETA3(:)];
%dataoutfull3 = 0;
end

