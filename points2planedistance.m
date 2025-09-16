function [d2H, H] = points2planedistance(M, n, I)
%% points2planedistance : function to compute the distance between the 3D
% point M and the plane (I,n). Also provides the coordinates of H,
% the projection of M on (I,n), and also works for a multiple points.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2019-2025.
%             
%
%%% Syntax
%
% d2H = points2planedistance(M, n, I);
% [d2H, H] = points2planedistance(M, n ,I);
%
%
%%% Description
%
% d2H = points2planedistance(M, n, I) computes the distance d2H between M and the
% plane (I,n).
%
% [d2H, H] = points2planedistance(n ,I, M) also provides the coordinates
% of H, the projection(s) of M on (I,n).
%
%
%%% Input arguments
%
%       [ |  |  |]
% - M = [Mx My Mz], real row vector -or matrix- double , the point -or list of N points- which
%       [ |  |  |]
%
%       we want the distance to the plane. size(M) = [N,3].
%
% - n = [nx ny nz], real row vector double, a plane normal vector, size(n) = [1,3].
%
% - I = [Ix Iy Iz], real row vector double, a point belonging to the plane, size(I) = [1,3]. 
% 
%
%%% Output arguments
%
% - d2H : real scalar -or vector- double, the euclidian distance between M and the plane (I,n). size(d2H) = [N,1].
%
% - H : real vector -or matrix- double, the projected point(s) on the plane. size(H) = [N,3].
%
%
%%% Example #1
% Single point
%
% M = [1 1 1];
% I = [1 0 0];
% n = M;
% [d2H, H] = points2planedistance(M, n ,I) % expected distance : 2/sqrt(3); expected coordinates : [1/3 1/3 1/3]                                                                                                            
%
%
%%% Example #2
% Multiple points
% M = [1 1 1; 2 1 1];
% I = [1 0 0];
% n = [1 1 1];
% Expected distances : 2/sqrt(3), sqrt(3); expected coordinates : [1/3 1/3 1/3], [1 0 0].
% [d2H, H] = points2planedistance(M, n ,I)


%% Inputs parsing
assert(size(n,1) == 1 && size(I,1) == 1,'Input argument n and I must be row vectors of size [1,3]. One plane at a time. See point2planes_distances for distance from one point to multiple planes.');
assert(isequal(size(M,2),size(n,2),size(I,2),3),'All input arguments must have the same number of columns (3).');
assert(isreal(M) && isreal(n) && isreal(I),'All input arguments must be real.');


%% Body
d_I = -(n(1,1)*I(1,1) + n(1,2)*I(1,2) + n(1,3)*I(1,3));
t_H = -(d_I + n(1)*M(:,1) + n(2)*M(:,2) + n(3)*M(:,3)) / sum(n.^2);

x_H = M(:,1) + t_H*n(1);
y_H = M(:,2) + t_H*n(2);
z_H = M(:,3) + t_H*n(3);

H = cat(2,x_H,y_H,z_H);
d2H = sqrt(sum((M-H).^2,2));


end % points2planedistance