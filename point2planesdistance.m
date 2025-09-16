function [d2H, H] = point2planesdistance(M, n, I)
% point2planesdistance : function to compute the distance between the
% 3D point M and the plane (I,n). Also provides the coordinates of H,
% the projection of M on (I,n), and also works for a multiple planes.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2020-2025.
%             
%
%%% Syntax
%
% d2H = point2planesdistance(M, n, I);
% [d2H, H] = point2planesdistance(M, n ,I);
%
%
%%% Description
%
% d2H = point2planesdistance(M, n, I) computes the distance d2H between M and the
% plane(s) (I,n).
%
% [d2H, H] = point2planesdistance(n ,I, M) also provides the coordinates
% of H, the projection(s) of M on (I,n).
%
%
%%% Input arguments
%
% - M = [Mx My Mz] real row vector/matrix double, the point which
%       we want the distance to the plane(s). size(M) = [1,3]. Mandatory.
%
%       [ |  |  |]
% - n = [nx ny nz], real row vector double, the plane(s) normal vector(s), size(n) = [N,3]. Mandatory.
%       [ |  |  |]
%
%   where N is the number of planes.
%
%       [ |  |  |]
% - I = [Ix Iy Iz], real row vector double, the point(s) belonging to the plane(s), size(I) = [N,3]. Mandatory.
%       [ |  |  |]
%
% 
%%% Output arguments
%
% - d2H : real scalar -or vector- double, the euclidian distance between M and the plane (I,n). size(d2H) = [N,1].
%
% - H : real vector double, the projected point(s) on the plane. size(H) = [N,3].
%
%
%%% Example #1
% Single plane
%
% M = [1 1 1];
% I = [1 0 0];
% n = M;
% [d2H, H] = point2planesdistance(M, n ,I) % expected distance : 2/sqrt(3); expected coordinates : [1/3 1/3 1/3]                                                                                                            
%
%
%%% Example #2
% % Multiple planes
% M = [0 0 0];
% 
% % Cube included in the unist sphere
% V = (sqrt(3)/3)*[ 1  1  1;
%                  -1  1  1;
%                  -1 -1  1;
%                   1 -1  1;
%                   1  1 -1;
%                  -1  1 -1;
%                  -1 -1 -1;
%                   1 -1 -1];
%
% % 6 normals to the cube faces
% n = [ 1  0  0;
%       0  1  0;
%      -1  0  0;
%       0 -1  0;
%       0  0  1;
%       0  0 -1];
%
% I = (sqrt(3)/3)*n;
%
% [d2H, H] = point2planesdistance(M, n ,I) % expected results : d2H = (sqrt(3)/3)*ones(6,1); H = I;


% Inputs parsing
assert(size(M,1) < 2,'Input argument M must be a row vector of size [1,3]. One point at a time. See points2planedistance for distance from multiple points to a plane.');
assert(size(M,2) == 3 && size(n,2) == 3 && size(I,2) == 3,'All input arguments must have the same number of columns (3).');
assert(isreal(M) && isreal(n) && isreal(I),'All input arguments must be real.');


% Body
d_I = -(n(:,1).*I(:,1) + n(:,2).*I(:,2) + n(:,3).*I(:,3));
t_H = -(d_I + n(:,1).*M(1,1) + n(:,2).*M(1,2) + n(:,3).*M(1,3)) ./ sum(n.^2,2);

x_H = M(1,1) + t_H.*n(:,1);
y_H = M(1,2) + t_H.*n(:,2);
z_H = M(1,3) + t_H.*n(:,3);

% Orthogonal projected point
H = cat(2,x_H,y_H,z_H);
d2H = sqrt(sum((M-H).^2,2));


end % point2planesdistance